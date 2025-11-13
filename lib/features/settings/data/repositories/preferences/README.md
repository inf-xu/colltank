# PreferencesRepository

- `preferences_repository.dart`
  - 基于 `PreferencesDao` 对外暴露 `loadOrCreate` 及 `updateRootDirectory`、`updateImportMode`、`updateLastExportDir` 等方法。
  - 用于“我的”或设置页面读取/保存全局偏好，也能在 Usecase 中注入以同步导出路径、目录授权状态。
