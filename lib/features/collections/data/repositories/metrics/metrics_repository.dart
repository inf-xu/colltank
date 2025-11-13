import '../../../../../core/database/app_database.dart';

/// 指标 Repository：封装热力图与存储快照操作
class MetricsRepository {
  MetricsRepository(this._dao);

  final MetricsDao _dao;

  Future<void> incrementDailyMetric({
    int? collectionId,
    required DateTime statDate,
    int deltaCount = 1,
    int? firstCollectibleId,
    int? lastCollectibleId,
  }) {
    return _dao.incrementDailyMetric(
      collectionId: collectionId,
      statDate: statDate,
      deltaCount: deltaCount,
      firstCollectibleId: firstCollectibleId,
      lastCollectibleId: lastCollectibleId,
    );
  }

  Future<List<CollectionDailyMetricRow>> metricsForYear({
    int? collectionId,
    required int year,
  }) {
    return _dao.metricsForYear(collectionId: collectionId, year: year);
  }

  Stream<List<CollectionDailyMetricRow>> watchMetricsForYear({
    int? collectionId,
    required int year,
  }) {
    return _dao.watchMetricsForYear(collectionId: collectionId, year: year);
  }

  Future<void> upsertStorageSnapshot({
    int? collectionId,
    required int totalBytes,
    required int thumbnailBytes,
    required int itemsCount,
    DateTime? computedAt,
  }) {
    return _dao.upsertStorageSnapshot(
      collectionId: collectionId,
      totalBytes: totalBytes,
      thumbnailBytes: thumbnailBytes,
      itemsCount: itemsCount,
      computedAt: computedAt,
    );
  }

  Future<List<StorageSnapshotRow>> latestSnapshots({
    int? collectionId,
    int limit = 10,
  }) {
    return _dao.latestSnapshots(collectionId: collectionId, limit: limit);
  }
}
