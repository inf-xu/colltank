# Home Providers

- `home_providers.dart`
  - `homeCollectionsProvider`：监听 `CollectionsRepository.watchCollectionsWithCount()`，驱动首页滚轮、抽屉、指示器。
  - `homeMonthlyHeatmapProvider`：按收集罐 ID 监听本年度指标并抽取当月每日数量，用于首页卡片的迷你热力图。
  - `homeLatestUploadProvider`：监听 `CollectiblesRepository.watchLatestCapturedAt`，渲染“最近上传时间”文案。

UI 可通过 `ref.watch(homeCollectionsProvider)` 获取 `AsyncValue<List<CollectionEntity>>`，随数据更新自动重建。
