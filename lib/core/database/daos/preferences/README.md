# PreferencesDao 说明

封装 `app_preferences` 表，负责全局配置管理：

- `loadOrCreate`：确保存在唯一的偏好行，初始化应用配置。
- `updatePreferences`：批量写入任意字段，常见于设置页面保存操作。
- `updateRootDirectory`／`updateImportMode`／`updateLastExportDir`：提供语义化方法，便于 Usecase 调用。

> 该 DAO 为文件策略、权限校验与分享路径提供持久化支持，建议在 Riverpod Provider 中暴露读取结果。
