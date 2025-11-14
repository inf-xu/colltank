import '../../entities/collection_models.dart';
import '../../../data/repositories/collections/collections_repository.dart';
import '../../../data/repositories/highlight_slots/highlight_slots_repository.dart';
import '../../exceptions/collection_exceptions.dart';

/// 创建收集罐：写入数据库并初始化九宫格槽位
class CreateCollectionUsecase {
  CreateCollectionUsecase(
    this._collectionsRepository,
    this._highlightSlotsRepository,
  );

  final CollectionsRepository _collectionsRepository;
  final HighlightSlotsRepository _highlightSlotsRepository;

  Future<int> call(CollectionEntity entity) async {
    final exists = await _collectionsRepository.existsByName(entity.name);
    if (exists) {
      throw CollectionNameExistsException(entity.name);
    }
    final id = await _collectionsRepository.createCollection(entity);
    await _highlightSlotsRepository.resetSlots(id);
    return id;
  }
}
