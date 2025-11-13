# CollectiblesDao 说明

负责 `collectibles` 表的增删改查，支持以下场景：

- `insertCollectible`／`insertMany`：写入图片元数据，搭配导入流程或批量迁移。
- `listByCollection`／`watchByCollection`：按类别读取或监听所有物品，瀑布流/详情页可直接使用。
- `paginateByCollection`：支持 limit/offset、展示筛选（是否在画框、是否归档），用于无限滚动与筛选面板。
- `deleteByIds`：批量删除物品，结合多选操作。
- `updateThumbnailPath`／`updateAllowHighlight`／`updateSortWeight`：在后台生成缩略图、切换展示资格或拖动排序时调用。

> 推荐在 Repository/Usecase 中注入 DAO，以保持 UI 与数据库逻辑解耦。
