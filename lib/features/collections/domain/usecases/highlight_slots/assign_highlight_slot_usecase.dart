import '../../../data/repositories/highlight_slots/highlight_slots_repository.dart';

/// 拖拽到 3×3 画布的操作入口
class AssignHighlightSlotUsecase {
  AssignHighlightSlotUsecase(this._highlightSlotsRepository);

  final HighlightSlotsRepository _highlightSlotsRepository;

  Future<void> call({
    required int collectionId,
    required int slotIndex,
    int? collectibleId,
    bool? isLocked,
  }) {
    return _highlightSlotsRepository.upsertSlot(
      collectionId: collectionId,
      slotIndex: slotIndex,
      collectibleId: collectibleId,
      isLocked: isLocked,
    );
  }
}
