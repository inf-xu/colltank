# ExportLogsRepository

- `export_logs_repository.dart`
  - 提供 `logExport`、`latestForCollection`、`logsForCollection` 三个语义化方法，封装导出历史的插入与查询。
  - `logExport` 支持自定义分辨率、文件大小、导出时间，默认自动写入当前时间。

用于“导出记录提示”“我的页面导出历史”等场景，可由 Usecase 注入，避免直接操作 DAO。
