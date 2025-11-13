# Collections Usecases

- `create_collection_usecase.dart`：创建收集罐并初始化 3×3 槽位。
- `delete_collection_usecase.dart`：删除指定收集罐。
- `reorder_collections_usecase.dart`：根据拖拽结果重排排序权重。
- `switch_frame_style_usecase.dart`：切换画框模板。
- `update_cover_preview_usecase.dart`：更新封面拼贴路径。

> 依赖 CollectionsRepository / HighlightSlotsRepository，供 UI 或更高层服务触发。
