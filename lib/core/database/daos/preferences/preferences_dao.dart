part of 'package:colltank/core/database/app_database.dart';

/// 全局偏好 DAO：维护根目录、导出策略等配置
@DriftAccessor(tables: [AppPreferences])
class PreferencesDao extends DatabaseAccessor<AppDatabase>
    with _$PreferencesDaoMixin {
  PreferencesDao(AppDatabase db) : super(db);

  Future<AppPreferenceRow> loadOrCreate() async {
    final existing = await select(appPreferences).getSingleOrNull();
    if (existing != null) return existing;
    final id = await into(appPreferences).insert(AppPreferencesCompanion.insert());
    return (select(appPreferences)..where((tbl) => tbl.id.equals(id))).getSingle();
  }

  Future<void> updatePreferences(AppPreferencesCompanion companion) async {
    final prefs = await loadOrCreate();
    await (update(appPreferences)..where((tbl) => tbl.id.equals(prefs.id)))
        .write(companion);
  }

  Future<void> updateRootDirectory(String path) async {
    await updatePreferences(
      AppPreferencesCompanion(
        rootDirectory: Value(path),
        lastDirectoryCheckAt: Value(DateTime.now()),
      ),
    );
  }

  Future<void> updateImportMode(String mode) async {
    await updatePreferences(
      AppPreferencesCompanion(
        importMode: Value(mode),
      ),
    );
  }

  Future<void> updateLastExportDir(String path) async {
    await updatePreferences(
      AppPreferencesCompanion(
        lastExportDir: Value(path),
      ),
    );
  }
}
