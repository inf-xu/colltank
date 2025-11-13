import '../../../data/repositories/preferences/preferences_repository.dart';

/// 切换导入模式（复制/移动）
class UpdateImportModeUsecase {
  UpdateImportModeUsecase(this._preferencesRepository);

  final PreferencesRepository _preferencesRepository;

  Future<void> call(String mode) {
    return _preferencesRepository.updateImportMode(mode);
  }
}
