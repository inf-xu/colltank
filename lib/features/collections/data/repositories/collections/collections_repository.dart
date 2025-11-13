import 'dart:async';

import '../../../domain/entities/collection_models.dart';
import '../../../../../core/database/app_database.dart';

/// 收集罐 Repository：基于 CollectionsDao 提供实体级操作
class CollectionsRepository {
  CollectionsRepository(this._collectionsDao);

  final CollectionsDao _collectionsDao;

  Future<int> createCollection(CollectionEntity entity) {
    return _collectionsDao.insertCollection(entity.toCompanion());
  }

  Future<void> deleteCollection(int id) {
    return _collectionsDao.deleteCollection(id);
  }

  Future<CollectionEntity?> findById(int id) async {
    final row = await _collectionsDao.findById(id);
    if (row == null) {
      return null;
    }
    return row.toEntity(itemCount: 0);
  }

  Future<List<CollectionEntity>> fetchCollectionsWithCount() async {
    final rows = await _collectionsDao.fetchCollectionRowsWithCount();
    return rows
        .map(
          (row) => row.row.toEntity(itemCount: row.itemCount),
        )
        .toList();
  }

  Stream<List<CollectionEntity>> watchCollectionsWithCount() {
    return _collectionsDao.watchCollectionsWithCount().map(
          (rows) => rows
              .map(
                (row) => row.row.toEntity(itemCount: row.itemCount),
              )
              .toList(),
        );
  }

  Future<void> reorderCollections(List<int> orderedIds) {
    return _collectionsDao.reorderCollections(orderedIds);
  }

  Future<void> updateFrameStyle({
    required int collectionId,
    required int frameStyleId,
  }) {
    return _collectionsDao.updateFrameStyle(
      collectionId: collectionId,
      frameStyleId: frameStyleId,
    );
  }

  Future<void> updateCoverPreview({
    required int collectionId,
    String? previewPath,
  }) {
    return _collectionsDao.updateCoverPreview(
      collectionId: collectionId,
      previewPath: previewPath,
    );
  }

  Future<List<CollectionEntity>> searchByKeyword(String keyword) async {
    final rows = await _collectionsDao.searchByKeyword(keyword);
    return rows.map((row) => row.toEntity(itemCount: 0)).toList();
  }
}
