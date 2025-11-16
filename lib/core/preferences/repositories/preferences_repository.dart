import '../../database/app_database.dart';

/// 偏好仓储：封装 app_preferences 的增删改查
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
