# MetricsRepository

- `metrics_repository.dart`
  - 对接 `MetricsDao`，提供 `incrementDailyMetric`、`metricsForYear`、`watchMetricsForYear`、`upsertStorageSnapshot`、`latestSnapshots`。
  - 返回 `CollectionDailyMetricRow` 与 `StorageSnapshotRow`，供首页卡片、日历、我的页面直接绘制统计结果。
  - 将事务逻辑留在 DAO，Repository 专注领域语义，后续可在此叠加缓存或过滤规则。
