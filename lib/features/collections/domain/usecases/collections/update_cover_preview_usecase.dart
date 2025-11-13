import '../../../data/repositories/collections/collections_repository.dart';

/// 更新封面缩略图路径
class UpdateCoverPreviewUsecase {
  UpdateCoverPreviewUsecase(this._collectionsRepository);

  final CollectionsRepository _collectionsRepository;

  Future<void> call({
    required int collectionId,
    String? previewPath,
  }) {
    return _collectionsRepository.updateCoverPreview(
      collectionId: collectionId,
      previewPath: previewPath,
    );
  }
}
