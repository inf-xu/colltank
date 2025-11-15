import 'dart:async';

import 'dart:math';

import '../../../domain/entities/collection_models.dart';
import '../../../../../core/database/app_database.dart';

/// 画框槽位 Repository：面向 3×3 画布的状态管理
class HighlightSlotsRepository {
  HighlightSlotsRepository(this._dao);

  final HighlightSlotsDao _dao;

  Future<void> upsertSlot({
    required int collectionId,
    required int slotIndex,
    int? collectibleId,
    bool? isLocked,
  }) {
    return _dao.upsertSlot(
      collectionId: collectionId,
      slotIndex: slotIndex,
      collectibleId: collectibleId,
      isLocked: isLocked,
    );
  }

  Future<void> resetSlots(int collectionId) {
    return _dao.resetSlots(collectionId);
  }

  Future<List<HighlightSlotEntity>> listSlots(int collectionId) async {
    final rows = await _dao.listSlots(collectionId);
    return rows.map((row) => row.toEntity()).toList();
  }

  Stream<List<HighlightSlotEntity>> watchSlots(int collectionId) {
    return _dao.watchSlots(collectionId).map(
          (rows) => rows.map((row) => row.toEntity()).toList(),
        );
  }

  Future<void> shuffleSlots(int collectionId) async {
    final rows = await _dao.listSlots(collectionId);
    final unlocked = rows.where((row) => !row.isLocked).toList();
    if (unlocked.isEmpty) {
      return;
    }
    final movableCollectibles = unlocked
        .where((row) => row.collectibleId != null)
        .map((row) => row.collectibleId!)
        .toList();
    if (movableCollectibles.isEmpty) {
      return;
    }
    final rng = Random();
    unlocked.shuffle(rng);
    movableCollectibles.shuffle(rng);
    var assignIndex = 0;
    await _dao.transaction(() async {
      for (final slot in unlocked) {
        final newCollectible = assignIndex < movableCollectibles.length
            ? movableCollectibles[assignIndex++]
            : null;
        await _dao.upsertSlot(
          collectionId: collectionId,
          slotIndex: slot.slotIndex,
          collectibleId: newCollectible,
        );
      }
    });
  }
}
