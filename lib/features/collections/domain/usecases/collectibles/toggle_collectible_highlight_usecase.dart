import '../../../data/repositories/collectibles/collectibles_repository.dart';

/// 切换物品是否参与画框展示
class ToggleCollectibleHighlightUsecase {
  ToggleCollectibleHighlightUsecase(this._collectiblesRepository);

  final CollectiblesRepository _collectiblesRepository;

  Future<void> call({
    required int collectibleId,
    required bool allowHighlight,
  }) {
    return _collectiblesRepository.updateAllowHighlight(
      collectibleId,
      allowHighlight,
    );
  }
}
