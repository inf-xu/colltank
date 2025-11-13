import 'dart:async';

import '../../../domain/entities/collection_models.dart';
import '../../../../../core/database/app_database.dart';

/// 收藏物 Repository：封装物品相关的增删查改
class CollectiblesRepository {
  CollectiblesRepository(this._collectiblesDao);

  final CollectiblesDao _collectiblesDao;

  Future<int> insertCollectible(CollectibleEntity entity) {
    return _collectiblesDao.insertCollectible(entity.toCompanion());
  }

  Future<void> insertMany(List<CollectibleEntity> entities) async {
    await _collectiblesDao.insertMany(
      entities.map((e) => e.toCompanion()).toList(),
    );
  }

  Future<List<CollectibleEntity>> listByCollection(int collectionId) async {
    final rows = await _collectiblesDao.listByCollection(collectionId);
    return rows.map((row) => row.toEntity()).toList();
  }

  Stream<List<CollectibleEntity>> watchByCollection(int collectionId) {
    return _collectiblesDao.watchByCollection(collectionId).map(
          (rows) => rows.map((row) => row.toEntity()).toList(),
        );
  }

  Future<List<CollectibleEntity>> paginateByCollection({
    required int collectionId,
    int limit = 30,
    int offset = 0,
    bool? allowHighlight,
    bool? isArchived,
  }) async {
    final rows = await _collectiblesDao.paginateByCollection(
      collectionId: collectionId,
      limit: limit,
      offset: offset,
      allowHighlight: allowHighlight,
      isArchived: isArchived,
    );
    return rows.map((row) => row.toEntity()).toList();
  }

  Future<int> deleteByIds(List<int> ids) {
    return _collectiblesDao.deleteByIds(ids);
  }

  Future<void> updateThumbnailPath(int id, String? path) {
    return _collectiblesDao.updateThumbnailPath(id, path);
  }

  Future<void> updateAllowHighlight(int id, bool value) {
    return _collectiblesDao.updateAllowHighlight(id, value);
  }

  Future<void> updateSortWeight({
    required int id,
    required int sortWeight,
  }) {
    return _collectiblesDao.updateSortWeight(
      id: id,
      sortWeight: sortWeight,
    );
  }
}
