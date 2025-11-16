import '../../../data/repositories/export/export_logs_repository.dart';
import 'package:colltank/core/preferences/repositories/preferences_repository.dart';

/// 画框导出完成后写日志并记录最后路径
class LogExportUsecase {
  LogExportUsecase(this._exportLogsRepository, this._preferencesRepository);

  final ExportLogsRepository _exportLogsRepository;
  final PreferencesRepository _preferencesRepository;

  Future<void> call({
    required int collectionId,
    required String exportPath,
    required String fileName,
    String? directory,
    String resolutionPx = '2048x2048',
    int fileSizeBytes = 0,
  }) async {
    await _exportLogsRepository.logExport(
      collectionId: collectionId,
      exportPath: exportPath,
      fileName: fileName,
      resolutionPx: resolutionPx,
      fileSizeBytes: fileSizeBytes,
    );
    if (directory != null) {
      await _preferencesRepository.updateLastExportDir(directory);
    }
  }
}
