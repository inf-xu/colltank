part of 'package:colltank/core/database/app_database.dart';

/// 收藏物品 DAO：负责分页、筛选与基础增删改
/// Drift 聚合结果：记录某日新增多少条收藏
class DailyCollectibleCountRow {
  DailyCollectibleCountRow({required this.date, required this.count});

  final DateTime date;
  final int count;
}

/// Drift 联结结果：收藏记录 + 对应的收集罐信息
class CollectibleWithCollectionRow {
  CollectibleWithCollectionRow({
    required this.collection,
    required this.collectible,
  });

  final CollectionRow collection;
  final CollectibleRow collectible;
}

@DriftAccessor(tables: [Collectibles, Collections])
class CollectiblesDao extends DatabaseAccessor<AppDatabase>
    with _$CollectiblesDaoMixin {
  CollectiblesDao(super.db);

  Future<int> insertCollectible(CollectiblesCompanion companion) =>
      into(collectibles).insert(companion);

  Future<void> insertMany(List<CollectiblesCompanion> companions) async {
    await batch((batch) {
      batch.insertAll(collectibles, companions);
    });
  }

  Future<List<CollectibleRow>> listByCollection(int collectionId) {
    return (select(collectibles)
          ..where((tbl) => tbl.collectionId.equals(collectionId))
          ..orderBy([
            (tbl) => OrderingTerm.desc(tbl.sortWeight),
            (tbl) => OrderingTerm.desc(tbl.capturedAt),
          ]))
        .get();
  }

  Stream<List<CollectibleRow>> watchByCollection(int collectionId) {
    final query = select(collectibles)
      ..where((tbl) => tbl.collectionId.equals(collectionId))
      ..orderBy([
        (tbl) => OrderingTerm.desc(tbl.sortWeight),
        (tbl) => OrderingTerm.desc(tbl.capturedAt),
      ]);
    return query.watch();
  }

  Future<List<CollectibleRow>> paginateByCollection({
    required int collectionId,
    int limit = 30,
    int offset = 0,
    bool? allowHighlight,
    bool? isArchived,
  }) {
    final query = select(collectibles)
      ..where((tbl) => tbl.collectionId.equals(collectionId));

    if (allowHighlight != null) {
      query.where((tbl) => tbl.allowHighlight.equals(allowHighlight));
    }
    if (isArchived != null) {
      query.where((tbl) => tbl.isArchived.equals(isArchived));
    }

    query
      ..orderBy([
        (tbl) => OrderingTerm.desc(tbl.sortWeight),
        (tbl) => OrderingTerm.desc(tbl.capturedAt),
      ])
      ..limit(limit, offset: offset);

    return query.get();
  }

  Future<int> deleteByIds(List<int> ids) {
    if (ids.isEmpty) return Future.value(0);
    return (delete(collectibles)..where((tbl) => tbl.id.isIn(ids))).go();
  }

  Future<void> updateThumbnailPath(int id, String? path) async {
    await (update(collectibles)..where((tbl) => tbl.id.equals(id))).write(
      CollectiblesCompanion(
        thumbnailPath: Value(path),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  Future<void> updateAllowHighlight(int id, bool value) async {
    await (update(collectibles)..where((tbl) => tbl.id.equals(id))).write(
      CollectiblesCompanion(
        allowHighlight: Value(value),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  Future<void> updateSortWeight({
    required int id,
    required int sortWeight,
  }) async {
    await (update(collectibles)..where((tbl) => tbl.id.equals(id))).write(
      CollectiblesCompanion(
        sortWeight: Value(sortWeight),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  Stream<DateTime?> watchLatestCapturedAt(int collectionId) {
    final query =
        (select(collectibles)
              ..where((tbl) => tbl.collectionId.equals(collectionId))
              ..orderBy([(tbl) => OrderingTerm.desc(tbl.capturedAt)])
              ..limit(1))
            .watchSingleOrNull();
    return query.map((row) => row?.capturedAt);
  }

  Future<CollectibleRow?> findById(int id) {
    return (select(
      collectibles,
    )..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
  }

  Stream<CollectibleRow?> watchById(int id) {
    return (select(
      collectibles,
    )..where((tbl) => tbl.id.equals(id))).watchSingleOrNull();
  }

  Future<void> updateMeta({
    required int id,
    String? displayName,
    String? story,
    int? moodCodePoint,
    String? moodFontFamily,
    String? moodPackage,
    String? moodColor,
  }) async {
    await (update(collectibles)..where((tbl) => tbl.id.equals(id))).write(
      CollectiblesCompanion(
        displayName: displayName == null
            ? const Value.absent()
            : Value(displayName),
        story: story == null ? const Value.absent() : Value(story),
        moodCodePoint: moodCodePoint == null
            ? const Value.absent()
            : Value(moodCodePoint),
        moodFontFamily: moodFontFamily == null
            ? const Value.absent()
            : Value(moodFontFamily),
        moodPackage: moodPackage == null
            ? const Value.absent()
            : Value(moodPackage),
        moodColor: moodColor == null ? const Value.absent() : Value(moodColor),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  Stream<List<DailyCollectibleCountRow>> watchDailyCounts({
    required DateTime start,
    required DateTime end,
  }) {
    final startDate = DateTime(start.year, start.month, start.day);
    final normalizedEnd = DateTime(end.year, end.month, end.day);
    final endExclusive = normalizedEnd.isAfter(startDate)
        ? normalizedEnd.add(const Duration(days: 1))
        : startDate.add(const Duration(days: 1));
    final countExpr = collectibles.id.count();
    final query = selectOnly(collectibles)
      ..addColumns([collectibles.capturedDate, countExpr])
      ..where(
        collectibles.capturedDate.isBiggerOrEqualValue(startDate) &
            collectibles.capturedDate.isSmallerThanValue(endExclusive),
      )
      ..groupBy([collectibles.capturedDate])
      ..orderBy([OrderingTerm.asc(collectibles.capturedDate)]);
    return query.watch().map(
      (rows) => rows
          .map(
            (row) => DailyCollectibleCountRow(
              date: row.read(collectibles.capturedDate)!,
              count: row.read(countExpr) ?? 0,
            ),
          )
          .toList(),
    );
  }

  Stream<List<CollectibleWithCollectionRow>>
  watchCollectiblesWithCollectionByDate(DateTime date) {
    final startDate = DateTime(date.year, date.month, date.day);
    final endDate = startDate.add(const Duration(days: 1));
    final query =
        select(collectibles).join([
            innerJoin(
              collections,
              collections.id.equalsExp(collectibles.collectionId),
            ),
          ])
          ..where(
            collectibles.capturedDate.isBiggerOrEqualValue(startDate) &
                collectibles.capturedDate.isSmallerThanValue(endDate),
          )
          ..orderBy([
            OrderingTerm.desc(collectibles.capturedAt),
            OrderingTerm.desc(collectibles.sortWeight),
          ]);
    return query.watch().map(
      (rows) => rows
          .map(
            (row) => CollectibleWithCollectionRow(
              collection: row.readTable(collections),
              collectible: row.readTable(collectibles),
            ),
          )
          .toList(),
    );
  }
}
