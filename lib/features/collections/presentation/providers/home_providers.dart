import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/providers/global_providers.dart';
import '../../domain/entities/collection_models.dart';

/// 监听全部收集罐（含物品计数），驱动首页滚轮 UI
final homeCollectionsProvider =
    StreamProvider<List<CollectionEntity>>((ref) {
  final repository = ref.watch(collectionsRepositoryProvider);
  return repository.watchCollectionsWithCount();
});

/// 监听指定收集罐本月每日新增数量，用于小型热力图
final homeMonthlyHeatmapProvider =
    StreamProvider.family<List<int>, int>((ref, collectionId) {
  final repository = ref.watch(metricsRepositoryProvider);
  final now = DateTime.now();
  final startOfMonth = DateTime(now.year, now.month, 1);
  final endOfMonth = DateTime(now.year, now.month + 1, 1);
  final daysInMonth = endOfMonth.difference(startOfMonth).inDays;

  return repository
      .watchMetricsForYear(collectionId: collectionId, year: now.year)
      .map((metrics) {
    final counts = List<int>.filled(daysInMonth, 0);
    for (final metric in metrics) {
      final date = metric.statDate;
      if (!date.isBefore(endOfMonth) || date.isBefore(startOfMonth)) {
        continue;
      }
      final index = date.day - 1;
      if (index >= 0 && index < counts.length) {
        counts[index] = metric.itemCount;
      }
    }
    return counts;
  });
});

/// 监听指定收集罐最近一次上传时间
final homeLatestUploadProvider =
    StreamProvider.family<DateTime?, int>((ref, collectionId) {
  final repository = ref.watch(collectiblesRepositoryProvider);
  return repository.watchLatestCapturedAt(collectionId);
});
