import '../../../data/repositories/collections/collections_repository.dart';

/// 删除收集罐：封装 Repository 的删除操作
class DeleteCollectionUsecase {
  DeleteCollectionUsecase(this._collectionsRepository);

  final CollectionsRepository _collectionsRepository;

  Future<void> call(int id) {
    return _collectionsRepository.deleteCollection(id);
  }
}
