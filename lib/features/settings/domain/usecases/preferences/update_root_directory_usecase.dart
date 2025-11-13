import '../../../data/repositories/preferences/preferences_repository.dart';

/// 更新授权根目录
class UpdateRootDirectoryUsecase {
  UpdateRootDirectoryUsecase(this._preferencesRepository);

  final PreferencesRepository _preferencesRepository;

  Future<void> call(String path) {
    return _preferencesRepository.updateRootDirectory(path);
  }
}
