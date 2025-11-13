# HighlightSlotsRepository

- `highlight_slots_repository.dart`
  - 封装 3×3 画布槽位的 `upsertSlot`、`resetSlots`、`listSlots`、`watchSlots`。
  - Repository 自动将 Drift Row 映射为 `HighlightSlotEntity`，便于 UI 与 Usecase 直接消费。
  - 适配拖拽、锁定、模板切换场景，未来可扩展更多画框布局时保持接口稳定。
