import '../../../data/repositories/collections/collections_repository.dart';

/// 切换画框样式，并可扩展 hooking highlight slots
class SwitchFrameStyleUsecase {
  SwitchFrameStyleUsecase(this._collectionsRepository);

  final CollectionsRepository _collectionsRepository;

  Future<void> call({
    required int collectionId,
    required int frameStyleId,
  }) {
    return _collectionsRepository.updateFrameStyle(
      collectionId: collectionId,
      frameStyleId: frameStyleId,
    );
  }
}
