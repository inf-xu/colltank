import '../repositories/preferences_repository.dart';

/// 更新根目录授权的用例
class UpdateRootDirectoryUsecase {
  UpdateRootDirectoryUsecase(this._preferencesRepository);

  final PreferencesRepository _preferencesRepository;

  Future<void> call(String path) {
    return _preferencesRepository.updateRootDirectory(path);
  }
}
