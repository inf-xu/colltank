part of 'package:colltank/core/database/app_database.dart';

/// DAO 查询结果的轻量封装，避免核心层直接依赖 UI 实体
class CollectionRowWithCount {
  const CollectionRowWithCount({required this.row, required this.itemCount});

  final CollectionRow row;
  final int itemCount;
}

/// 收集罐 DAO：封装列表、排序与封面维护等操作
@DriftAccessor(tables: [Collections, Collectibles])
class CollectionsDao extends DatabaseAccessor<AppDatabase>
    with _$CollectionsDaoMixin {
  CollectionsDao(super.db);

  Future<int> insertCollection(CollectionsCompanion companion) =>
      into(collections).insert(companion);

  Future<void> deleteCollection(int id) async {
    final db = attachedDatabase;
    await transaction(() async {
      await (db.delete(
        db.highlightSlots,
      )..where((tbl) => tbl.collectionId.equals(id))).go();
      await (delete(
        collectibles,
      )..where((tbl) => tbl.collectionId.equals(id))).go();
      await (db.delete(
        db.collectionDailyMetrics,
      )..where((tbl) => tbl.collectionId.equals(id))).go();
      await (db.delete(
        db.exportLogs,
      )..where((tbl) => tbl.collectionId.equals(id))).go();
      await (db.delete(
        db.storageSnapshots,
      )..where((tbl) => tbl.collectionId.equals(id))).go();
      await (delete(collections)..where((tbl) => tbl.id.equals(id))).go();
    });
  }

  Future<CollectionRow?> findById(int id) {
    return (select(
      collections,
    )..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
  }

  Stream<CollectionRow?> watchById(int id) {
    return (select(
      collections,
    )..where((tbl) => tbl.id.equals(id))).watchSingleOrNull();
  }

  Future<CollectionRow?> findByName(String name) {
    return (select(
      collections,
    )..where((tbl) => tbl.name.equals(name))).getSingleOrNull();
  }

  Future<List<CollectionRow>> allCollectionsRaw() => (select(
    collections,
  )..orderBy([(tbl) => OrderingTerm.desc(tbl.sortIndex)])).get();

  Future<List<CollectionRowWithCount>> fetchCollectionRowsWithCount() async {
    final rows = await allCollectionsRaw();
    final countMap = await _countByCollection(rows.map((e) => e.id));
    return rows
        .map(
          (row) => CollectionRowWithCount(
            row: row,
            itemCount: countMap[row.id] ?? 0,
          ),
        )
        .toList();
  }

  Stream<List<CollectionRowWithCount>> watchCollectionsWithCount() {
    final query = select(collections)
      ..orderBy([(tbl) => OrderingTerm.desc(tbl.sortIndex)]);
    return query.watch().asyncMap((rows) async {
      final countMap = await _countByCollection(rows.map((e) => e.id));
      return rows
          .map(
            (row) => CollectionRowWithCount(
              row: row,
              itemCount: countMap[row.id] ?? 0,
            ),
          )
          .toList();
    });
  }

  Future<void> reorderCollections(List<int> orderedIds) async {
    await transaction(() async {
      for (var index = 0; index < orderedIds.length; index++) {
        final id = orderedIds[index];
        final sortValue = orderedIds.length - index;
        await (update(collections)..where((tbl) => tbl.id.equals(id))).write(
          CollectionsCompanion(
            sortIndex: Value(sortValue),
            updatedAt: Value(DateTime.now()),
          ),
        );
      }
    });
  }

  Future<void> updateFrameStyle({
    required int collectionId,
    required int frameStyleId,
  }) async {
    await (update(
      collections,
    )..where((tbl) => tbl.id.equals(collectionId))).write(
      CollectionsCompanion(
        frameStyleId: Value(frameStyleId),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  Future<void> updateCoverPreview({
    required int collectionId,
    String? previewPath,
  }) async {
    await (update(
      collections,
    )..where((tbl) => tbl.id.equals(collectionId))).write(
      CollectionsCompanion(
        coverPreviewPath: Value(previewPath),
        coverUpdatedAt: Value(DateTime.now()),
      ),
    );
  }

  Future<List<CollectionRow>> searchByKeyword(String keyword) {
    final like = '%$keyword%';
    return (select(
      collections,
    )..where((tbl) => tbl.name.like(like) | tbl.description.like(like))).get();
  }

  Future<void> updateCollectionValues({
    required int id,
    required CollectionsCompanion companion,
  }) {
    return (update(
      collections,
    )..where((tbl) => tbl.id.equals(id))).write(companion);
  }

  Future<Map<int, int>> _countByCollection(Iterable<int> ids) async {
    if (ids.isEmpty) return {};
    final countExpr = collectibles.id.count();
    final query = selectOnly(collectibles)
      ..addColumns([collectibles.collectionId, countExpr])
      ..where(collectibles.collectionId.isIn(ids))
      ..groupBy([collectibles.collectionId]);
    final rows = await query.get();
    return {
      for (final row in rows)
        row.read(collectibles.collectionId)!: row.read(countExpr) ?? 0,
    };
  }
}
