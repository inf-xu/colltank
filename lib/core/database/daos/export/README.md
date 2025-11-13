# ExportLogsDao 说明

专注于 `export_logs` 表，追踪 3×3 拼贴导出记录：

- `insertLog`：在导出完成后写入路径、文件名、分辨率与大小。
- `latestForCollection`：读取某个类别最近一次导出信息（用于“最近导出”提示）。
- `logsForCollection`：分页获取历史导出日志，便于“我的”页面或调试页面展示。

> 与画布导出 Usecase 配合，可实现用户导出历史、空间占用统计等功能。
