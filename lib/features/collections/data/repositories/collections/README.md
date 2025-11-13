# CollectionsRepository

- `collections_repository.dart`
  - 基于 `CollectionsDao` 输出实体层接口：创建/删除收集罐、按排序获取、模糊搜索。
  - `fetchCollectionsWithCount`、`watchCollectionsWithCount` 会把 `CollectionRowWithCount` 映射成 `CollectionEntity`，供 Riverpod 状态或 Usecase 使用。
  - `reorderCollections`、`updateFrameStyle`、`updateCoverPreview` 用于抽屉拖拽和画框样式切换。

> 使用方式：构造函数传入 `database.collectionsDao`，即可在 Usecase 中调用语义化方法。README 也适用于后续扩展的文件。
