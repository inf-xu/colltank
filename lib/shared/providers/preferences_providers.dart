import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/providers/global_providers.dart';
import '../../core/database/app_database.dart';

/// 全局偏好 Provider：统一从 Drift 读取 app_preferences
final appPreferencesProvider = FutureProvider<AppPreferenceRow>((ref) async {
  final repository = ref.watch(preferencesRepositoryProvider);
  return repository.loadOrCreate();
});
