# MetricsDao 说明

`MetricsDao` 聚焦指标类数据：

- `incrementDailyMetric`：在新增/删除物品时更新 `collection_daily_metrics`（支持类别或全局），自动处理插入/累加。
- `metricsForYear`／`watchMetricsForYear`：按年份拉取或监听热力图数据，用于首页卡片与日历模块。
- `upsertStorageSnapshot`：定时写入 `storage_snapshots`，统计各类别/全局空间占用。
- `latestSnapshots`：读取最近 N 条快照，供“我的”页面展示趋势。

> 建议在导入、删除、压缩等 Usecase 的事务中调用，以保持指标与真实数据一致。
