# CollectiblesRepository

- `collectibles_repository.dart`
  - 封装物品 CRUD，所有返回值均转换为 `CollectibleEntity`，包括 `listByCollection`、`watchByCollection`、`paginateByCollection`。
  - 提供 `insertCollectible`、`insertMany` 便于导入流程批量写入。
  - 暴露 `updateThumbnailPath`、`updateAllowHighlight`、`updateSortWeight` 等方法，服务瀑布流与画框配置。

使用建议：在 Usecase 中注入 Repository，避免直接依赖 Drift Companion/Row，实现更清晰的领域边界。
