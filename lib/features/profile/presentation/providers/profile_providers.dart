import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/providers/global_providers.dart';
import '../../../collections/domain/entities/collection_models.dart';

/// 我的页面 - 收集罐列表（含计数）
final profileCollectionsProvider = StreamProvider<List<CollectionEntity>>((
  ref,
) {
  final repository = ref.watch(collectionsRepositoryProvider);
  return repository.watchCollectionsWithCount();
});

/// 我的页面 - 全年每日上传数
final profileYearlyCountsProvider = StreamProvider<List<DailyCollectibleCount>>(
  (ref) {
    final repository = ref.watch(collectiblesRepositoryProvider);
    final now = DateTime.now();
    final start = DateTime(now.year, 1, 1);
    final end = DateTime(now.year + 1, 1, 1);
    return repository.watchDailyCounts(start: start, end: end);
  },
);
