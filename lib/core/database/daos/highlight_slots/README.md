# HighlightSlotsDao 说明

面向 `highlight_slots` 九宫格槽位表，提供以下功能：

- `upsertSlot`：在拖拽或锁定时写入单个槽位，若存在则更新，实现幂等覆盖。
- `listSlots`／`watchSlots`：读取或监听指定类别的 9 个槽位，画框 UI 可直接订阅。
- `resetSlots`：重置为 0~8 的空槽位，适用于新建类别或更换模板时的初始化。

> 搭配 `CollectionListController` 或详情页 Provider，可确保 3×3 画布状态与数据库同步。
