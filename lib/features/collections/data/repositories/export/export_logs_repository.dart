import 'package:drift/drift.dart';

import '../../../../../core/database/app_database.dart';

/// 导出日志 Repository：结合 ExportLogsDao 提供更语义化的接口
class ExportLogsRepository {
  ExportLogsRepository(this._dao);

  final ExportLogsDao _dao;

  Future<int> logExport({
    required int collectionId,
    required String exportPath,
    required String fileName,
    String resolutionPx = '2048x2048',
    int fileSizeBytes = 0,
    DateTime? createdAt,
  }) {
    return _dao.insertLog(
      ExportLogsCompanion.insert(
        collectionId: collectionId,
        exportPath: exportPath,
        fileName: fileName,
        resolutionPx: Value(resolutionPx),
        fileSizeBytes: Value(fileSizeBytes),
        createdAt: Value(createdAt ?? DateTime.now()),
      ),
    );
  }

  Future<ExportLogRow?> latestForCollection(int collectionId) {
    return _dao.latestForCollection(collectionId);
  }

  Future<List<ExportLogRow>> logsForCollection(
    int collectionId, {
    int limit = 20,
  }) {
    return _dao.logsForCollection(collectionId, limit: limit);
  }
}
