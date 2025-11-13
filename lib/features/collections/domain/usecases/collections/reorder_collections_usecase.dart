import '../../../data/repositories/collections/collections_repository.dart';

/// 抽屉/首页拖拽排序入口
class ReorderCollectionsUsecase {
  ReorderCollectionsUsecase(this._collectionsRepository);

  final CollectionsRepository _collectionsRepository;

  Future<void> call(List<int> orderedIds) {
    return _collectionsRepository.reorderCollections(orderedIds);
  }
}
