import '../../entities/collection_models.dart';
import '../../../data/repositories/collections/collections_repository.dart';

/// 更新收集罐基本信息
class UpdateCollectionUsecase {
  UpdateCollectionUsecase(this._collectionsRepository);

  final CollectionsRepository _collectionsRepository;

  Future<void> call(CollectionEntity entity) {
    return _collectionsRepository.updateCollection(entity);
  }
}
