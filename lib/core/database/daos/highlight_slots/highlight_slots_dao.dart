part of 'package:colltank/core/database/app_database.dart';

/// 画框九宫格 DAO：负责槽位锁定、拖拽与批量重置
@DriftAccessor(tables: [HighlightSlots])
class HighlightSlotsDao extends DatabaseAccessor<AppDatabase>
    with _$HighlightSlotsDaoMixin {
  HighlightSlotsDao(AppDatabase db) : super(db);

  Future<void> upsertSlot({
    required int collectionId,
    required int slotIndex,
    int? collectibleId,
    bool? isLocked,
  }) async {
    final now = DateTime.now();
    final query = select(highlightSlots)
      ..where(
        (tbl) =>
            tbl.collectionId.equals(collectionId) &
            tbl.slotIndex.equals(slotIndex),
      );
    final existing = await query.getSingleOrNull();
    if (existing == null) {
      await into(highlightSlots).insert(
        HighlightSlotsCompanion(
          collectionId: Value(collectionId),
          slotIndex: Value(slotIndex),
          collectibleId: Value(collectibleId),
          isLocked: Value(isLocked ?? false),
          updatedAt: Value(now),
        ),
      );
    } else {
      await (update(highlightSlots)..where((tbl) => tbl.id.equals(existing.id)))
          .write(
        HighlightSlotsCompanion(
          collectibleId: Value(collectibleId),
          isLocked: isLocked == null ? const Value.absent() : Value(isLocked!),
          updatedAt: Value(now),
        ),
      );
    }
  }

  Future<List<HighlightSlotRow>> listSlots(int collectionId) {
    return (select(highlightSlots)
          ..where((tbl) => tbl.collectionId.equals(collectionId))
          ..orderBy([(tbl) => OrderingTerm.asc(tbl.slotIndex)]))
        .get();
  }

  Stream<List<HighlightSlotRow>> watchSlots(int collectionId) {
    final query = select(highlightSlots)
      ..where((tbl) => tbl.collectionId.equals(collectionId))
      ..orderBy([(tbl) => OrderingTerm.asc(tbl.slotIndex)]);
    return query.watch();
  }

  Future<void> resetSlots(int collectionId) async {
    await transaction(() async {
      await (delete(highlightSlots)
            ..where((tbl) => tbl.collectionId.equals(collectionId)))
          .go();
      await batch((batch) {
        batch.insertAll(
          highlightSlots,
          List.generate(
            9,
            (index) => HighlightSlotsCompanion.insert(
              collectionId: collectionId,
              slotIndex: index,
              collectibleId: const Value(null),
            ),
          ),
        );
      });
    });
  }
}
