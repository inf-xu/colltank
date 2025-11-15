part of 'package:colltank/core/database/app_database.dart';

/// 指标 DAO：负责热力图与存储占用的聚合写入
@DriftAccessor(tables: [CollectionDailyMetrics, StorageSnapshots])
class MetricsDao extends DatabaseAccessor<AppDatabase>
    with _$MetricsDaoMixin {
  MetricsDao(super.db);

  Future<void> incrementDailyMetric({
    int? collectionId,
    required DateTime statDate,
    int deltaCount = 1,
    int? firstCollectibleId,
    int? lastCollectibleId,
  }) async {
    final dateOnly = DateTime(statDate.year, statDate.month, statDate.day);
    await transaction(() async {
      Expression<bool> filter(CollectionDailyMetrics tbl) =>
          (collectionId == null
                  ? tbl.collectionId.isNull()
                  : tbl.collectionId.equals(collectionId)) &
          tbl.statDate.equals(dateOnly);
      final query = select(collectionDailyMetrics)..where(filter);
      final existing = await query.getSingleOrNull();
      if (existing == null) {
        await into(collectionDailyMetrics).insert(
          CollectionDailyMetricsCompanion(
            collectionId: Value(collectionId),
            statDate: Value(dateOnly),
            itemCount: Value(deltaCount),
            firstCollectibleId: Value(firstCollectibleId),
            lastCollectibleId: Value(lastCollectibleId),
          ),
        );
      } else {
        await (update(collectionDailyMetrics)..where(filter)).write(
          CollectionDailyMetricsCompanion(
            itemCount: Value(existing.itemCount + deltaCount),
            firstCollectibleId:
                Value(firstCollectibleId ?? existing.firstCollectibleId),
            lastCollectibleId: Value(lastCollectibleId),
            lastSyncedAt: Value(DateTime.now()),
          ),
        );
      }
    });
  }

  Future<List<CollectionDailyMetricRow>> metricsForYear({
    int? collectionId,
    required int year,
  }) {
    final start = DateTime(year);
    final end = DateTime(year + 1);
    final query = select(collectionDailyMetrics)
      ..where(
        (tbl) =>
            (collectionId == null
                ? tbl.collectionId.isNull()
                : tbl.collectionId.equals(collectionId)) &
            tbl.statDate.isBetweenValues(start, end),
      )
      ..orderBy([(tbl) => OrderingTerm.asc(tbl.statDate)]);
    return query.get();
  }

  Stream<List<CollectionDailyMetricRow>> watchMetricsForYear({
    int? collectionId,
    required int year,
  }) {
    final start = DateTime(year);
    final end = DateTime(year + 1);
    final query = select(collectionDailyMetrics)
      ..where(
        (tbl) =>
            (collectionId == null
                ? tbl.collectionId.isNull()
                : tbl.collectionId.equals(collectionId)) &
            tbl.statDate.isBetweenValues(start, end),
      )
      ..orderBy([(tbl) => OrderingTerm.asc(tbl.statDate)]);
    return query.watch();
  }

  Future<void> upsertStorageSnapshot({
    int? collectionId,
    required int totalBytes,
    required int thumbnailBytes,
    required int itemsCount,
    DateTime? computedAt,
  }) async {
    final snapshot = StorageSnapshotsCompanion(
      collectionId: Value(collectionId),
      totalBytes: Value(totalBytes),
      thumbnailBytes: Value(thumbnailBytes),
      itemsCount: Value(itemsCount),
      computedAt: Value(computedAt ?? DateTime.now()),
    );
    await into(storageSnapshots).insertOnConflictUpdate(snapshot);
  }

  Future<List<StorageSnapshotRow>> latestSnapshots({
    int? collectionId,
    int limit = 10,
  }) {
    final query = select(storageSnapshots)
      ..where(
        (tbl) => collectionId == null
            ? tbl.collectionId.isNull()
            : tbl.collectionId.equals(collectionId),
      )
      ..orderBy([(tbl) => OrderingTerm.desc(tbl.computedAt)])
      ..limit(limit);
    return query.get();
  }
}
