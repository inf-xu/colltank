import '../repositories/preferences_repository.dart';

/// 更新导入策略
class UpdateImportModeUsecase {
  UpdateImportModeUsecase(this._preferencesRepository);

  final PreferencesRepository _preferencesRepository;

  Future<void> call(String mode) {
    return _preferencesRepository.updateImportMode(mode);
  }
}
