import '../../../data/repositories/highlight_slots/highlight_slots_repository.dart';

/// 将指定类别的画框槽位清空
class ResetHighlightSlotsUsecase {
  ResetHighlightSlotsUsecase(this._highlightSlotsRepository);

  final HighlightSlotsRepository _highlightSlotsRepository;

  Future<void> call(int collectionId) {
    return _highlightSlotsRepository.resetSlots(collectionId);
  }
}
