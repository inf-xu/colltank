import '../../../../../core/database/app_database.dart';

/// 偏好设置 Repository：封装 app_preferences 数据访问
class PreferencesRepository {
  PreferencesRepository(this._dao);

  final PreferencesDao _dao;

  Future<AppPreferenceRow> loadOrCreate() {
    return _dao.loadOrCreate();
  }

  Future<void> updateRootDirectory(String path) {
    return _dao.updateRootDirectory(path);
  }

  Future<void> updateImportMode(String mode) {
    return _dao.updateImportMode(mode);
  }

  Future<void> updateLastExportDir(String path) {
    return _dao.updateLastExportDir(path);
  }
}
