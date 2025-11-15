import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/providers/global_providers.dart';
import '../../../core/database/app_database.dart';

/// 全局偏好 Provider：读取并缓存 app_preferences 行
final appPreferencesProvider = FutureProvider<AppPreferenceRow>((ref) async {
  final repository = ref.watch(preferencesRepositoryProvider);
  return repository.loadOrCreate();
});
