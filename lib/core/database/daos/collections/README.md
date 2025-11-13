# CollectionsDao 说明

该 DAO 面向收集罐类别（`collections` 表），提供以下能力：

- `insertCollection` / `deleteCollection`：新增、删除类别数据，配合 UI 创建/移除收集罐。
- `findById` / `allCollectionsRaw`：读取单条或全部类别原始行，通常用于详情页或导出场景。
- `fetchCollectionRowsWithCount`：即时聚合类别下物品数量，适合初始化 Riverpod 状态。
- `watchCollectionsWithCount`：监听类别与数量变化，驱动首页滚轮卡片实时刷新。
- `reorderCollections`：根据传入的 ID 顺序批量更新 `sort_index`，服务抽屉拖拽排序。
- `updateFrameStyle` / `updateCoverPreview`：切换画框样式、更新封面缩略图路径。
- `searchByKeyword`：用于抽屉搜索或过滤功能。

> 使用方式：通过 `AppDatabase.collectionsDao` 获取实例，或在 Riverpod Provider 中 `ref.watch(collectionsDaoProvider)` 即可调用以上方法。
