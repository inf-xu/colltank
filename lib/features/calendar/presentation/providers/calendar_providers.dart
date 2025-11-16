import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/providers/global_providers.dart';
import '../../../collections/domain/entities/collection_models.dart';
import '../../domain/entities/calendar_entities.dart';

/// 监听某年内每日上传数量，驱动日历高亮
final calendarYearlyStatsProvider =
    StreamProvider.family<List<DailyCollectibleCount>, int>((ref, year) {
  final repository = ref.watch(collectiblesRepositoryProvider);
  final start = DateTime(year, 1, 1);
  final end = DateTime(year + 1, 1, 1);
  return repository.watchDailyCounts(start: start, end: end);
});

/// 监听指定日期的按类别分组数据
final calendarDailyGroupsProvider =
    StreamProvider.family<List<CalendarCollectionGroup>, DateTime>((ref, raw) {
  final repository = ref.watch(collectiblesRepositoryProvider);
  final normalized = DateTime(raw.year, raw.month, raw.day);
  return repository
      .watchCollectiblesWithCollectionByDate(normalized)
      .map((items) {
    final grouped = <int, List<CollectibleEntity>>{};
    final names = <int, String>{};
    final colors = <int, String>{};
    for (final item in items) {
      final collectionId = item.collection.id ?? 0;
      names[collectionId] = item.collection.name;
      colors[collectionId] = item.collection.accentColor;
      grouped.putIfAbsent(collectionId, () => []).add(item.collectible);
    }
    final result = grouped.entries.map((entry) {
      final sorted = [...entry.value]
        ..sort((a, b) => b.capturedAt.compareTo(a.capturedAt));
      return CalendarCollectionGroup(
        collectionId: entry.key,
        collectionName: names[entry.key] ?? '未命名收集罐',
        accentColor: colors[entry.key] ?? '#FF4CAF50',
        items: sorted,
      );
    }).toList()
      ..sort((a, b) => b.items.length.compareTo(a.items.length));
    return result;
  });
});
