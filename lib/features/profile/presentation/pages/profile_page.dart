import 'package:fl_heatmap/fl_heatmap.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/utils/color_utils.dart';
import '../../../collections/domain/entities/collection_models.dart';
import '../providers/profile_providers.dart';

/// 我的页面：只展示统计与热力图
class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  final ScrollController _scrollController = ScrollController();
  Key _heatmapKey = UniqueKey();
  ProfileHeatmapItem? _selectedHeatmapItem;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _handleRefresh() async {
    ref.invalidate(profileCollectionsProvider);
    ref.invalidate(profileYearlyCountsProvider);
    ref.invalidate(profileMoodStatisticsProvider);
  }

  @override
  Widget build(BuildContext context) {
    final collectionsAsync = ref.watch(profileCollectionsProvider);
    final yearlyAsync = ref.watch(profileYearlyCountsProvider);
    final moodStatsAsync = ref.watch(profileMoodStatisticsProvider);
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('我的'), centerTitle: true),
      body: RefreshIndicator(
        onRefresh: _handleRefresh,
        child: ListView(
          controller: _scrollController,
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          children: [
            Text(
              '今日也要好好记录呀～',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            _SectionHeader(title: '统计面板'),
            const SizedBox(height: 12),
            _buildOverview(collectionsAsync, yearlyAsync),
            const SizedBox(height: 24),
            _SectionHeader(title: '分类别统计'),
            const SizedBox(height: 12),
            _buildCategorySection(collectionsAsync),
            const SizedBox(height: 24),
            _SectionHeader(title: '心情统计'),
            const SizedBox(height: 12),
            _buildMoodChart(moodStatsAsync),
            const SizedBox(height: 24),
            _SectionHeader(title: '年度热力图'),
            const SizedBox(height: 12),
            _buildYearlyHeatmap(context, yearlyAsync),
          ],
        ),
      ),
    );
  }

  Widget _buildOverview(
    AsyncValue<List<CollectionEntity>> collectionsAsync,
    AsyncValue<List<DailyCollectibleCount>> yearlyAsync,
  ) {
    return collectionsAsync.when(
      loading: () => const _SectionLoading(),
      error: (error, _) => _ErrorCard(message: '基础统计加载失败：$error'),
      data: (collections) {
        return yearlyAsync.when(
          loading: () => const _SectionLoading(),
          error: (error, _) => _ErrorCard(message: '年度统计异常：$error'),
          data: (yearlyCounts) {
            final overview = _computeOverview(collections, yearlyCounts);
            return _StatGrid(items: overview);
          },
        );
      },
    );
  }

  Widget _buildMoodChart(AsyncValue<List<MoodStatistic>> moodStatsAsync) {
    return moodStatsAsync.when(
      loading: () => const _SectionLoading(),
      error: (error, _) => _ErrorCard(message: '心情统计加载失败：$error'),
      data: (stats) {
        if (stats.isEmpty) {
          return const _EmptyCard(message: '暂无心情记录，快去写下当下心情吧');
        }
        final total = stats.fold<int>(0, (sum, item) => sum + item.count);
        final slices = _buildMoodSlices(stats, total);
        return _CardContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 220,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    PieChart(
                      PieChartData(
                        sectionsSpace: 2,
                        centerSpaceRadius: 60,
                        sections: [
                          for (final slice in slices)
                            PieChartSectionData(
                              color: slice.color,
                              value: slice.count.toDouble(),
                              title: slice.percent >= 12
                                  ? '${slice.percent.toStringAsFixed(0)}%'
                                  : '',
                              titleStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                        ],
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '$total 张',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '已记录心情',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              _MoodLegend(slices: slices),
            ],
          ),
        );
      },
    );
  }

  Widget _buildYearlyHeatmap(
    BuildContext context,
    AsyncValue<List<DailyCollectibleCount>> yearlyAsync,
  ) {
    return yearlyAsync.when(
      loading: () => const _SectionLoading(),
      error: (error, _) => _ErrorCard(message: '年度热力图加载失败：$error'),
      data: (yearlyCounts) {
        final theme = Theme.of(context);
        final total = yearlyCounts.fold<int>(
          0,
          (sum, item) => sum + item.count,
        );
        final activeDays = yearlyCounts.where((item) => item.count > 0).length;
        final heatmapData = _createYearHeatmapData(
          yearlyCounts,
          theme,
          _selectedHeatmapItem?.date,
        );
        final legendColors = _legendColors(heatmapData.colorPalette);
        final summary = _selectedHeatmapItem == null
            ? (total == 0 ? '本年暂无上传记录，去首页开启首次收集' : '点击任意日期查看上传数量')
            : _formatHeatmapSelection(_selectedHeatmapItem!);
        final subTitle = total == 0
            ? '等待第一张照片'
            : '累计 $total 张 · 活跃 $activeDays 天';
        const double cellSize = 24;
        final heatmapWidth = heatmapData.columns.length * cellSize;
        return _CardContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                summary,
                style: theme.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subTitle,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.outline,
                ),
              ),
              const SizedBox(height: 16),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SizedBox(
                  width: heatmapWidth,
                  child: Heatmap(
                    key: _heatmapKey,
                    heatmapData: heatmapData,
                    showXAxisLabels: false,
                    showYAxisLabels: false,
                    onItemSelectedListener: (item) {
                      if (!mounted) {
                        return;
                      }
                      setState(() {
                        _selectedHeatmapItem = item is ProfileHeatmapItem
                            ? item
                            : null;
                        _heatmapKey = UniqueKey();
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 16),
              _HeatLegend(colors: legendColors),
            ],
          ),
        );
      },
    );
  }

  List<_StatItem> _computeOverview(
    List<CollectionEntity> collections,
    List<DailyCollectibleCount> yearlyCounts,
  ) {
    final totalCollections = collections.length;
    final totalPhotos = collections.fold<int>(0, (sum, e) => sum + e.itemCount);
    final yearlyTotal = yearlyCounts.fold<int>(0, (sum, e) => sum + e.count);
    final activeDays = yearlyCounts.where((e) => e.count > 0).length;
    final today = DateTime.now();
    final todayDate = DateTime(today.year, today.month, today.day);
    final lastSevenDaysStart = todayDate.subtract(const Duration(days: 6));
    var weeklyUploads = 0;
    var weeklyActiveDays = 0;
    for (final entry in yearlyCounts) {
      final entryDate = DateTime(
        entry.date.year,
        entry.date.month,
        entry.date.day,
      );
      final isWithinRange =
          !entryDate.isBefore(lastSevenDaysStart) &&
          !entryDate.isAfter(todayDate);
      if (isWithinRange) {
        weeklyUploads += entry.count;
        if (entry.count > 0) {
          weeklyActiveDays++;
        }
      }
    }
    final topCollections = [...collections]
      ..sort((a, b) => b.itemCount.compareTo(a.itemCount));
    return [
      _StatItem(
        title: '收藏罐',
        value: '$totalCollections',
        subtitle: totalCollections == 0
            ? '创建第一个收藏罐，开启仪式感'
            : '当前已有 $totalCollections 个分类',
        icon: Icons.inventory_2_outlined,
        color: Colors.green,
      ),
      _StatItem(
        title: '图片总量',
        value: '$totalPhotos',
        subtitle: totalPhotos == 0 ? '还没有照片被收纳' : '累计整理 $totalPhotos 张',
        icon: Icons.photo_library_outlined,
        color: Colors.deepOrange,
      ),
      _StatItem(
        title: '近7日',
        value: '$weeklyUploads',
        subtitle: weeklyActiveDays == 0 ? '暂未记录' : '$weeklyActiveDays 天有记录',
        icon: Icons.calendar_today_outlined,
        color: Colors.purple,
      ),
      if (topCollections.isNotEmpty)
        _StatItem(
          title: '最满的罐子',
          value: topCollections.first.name,
          subtitle: '已有 ${topCollections.first.itemCount} 张',
          icon: Icons.emoji_events_outlined,
          color: Colors.teal,
        ),
    ];
  }

  List<_MoodSlice> _buildMoodSlices(List<MoodStatistic> stats, int totalCount) {
    final safeTotal = totalCount == 0 ? 1 : totalCount;
    return stats.map((stat) {
      final color = parseHexColor(stat.moodColor);
      final percent = stat.count / safeTotal * 100;
      return _MoodSlice(
        icon: _buildMoodIcon(stat),
        color: color,
        count: stat.count,
        percent: percent,
      );
    }).toList();
  }

  IconData _buildMoodIcon(MoodStatistic stat) {
    final fontFamily = stat.moodFontFamily.isEmpty ? null : stat.moodFontFamily;
    final fontPackage = (stat.moodPackage?.isEmpty ?? true)
        ? null
        : stat.moodPackage;
    return IconData(
      stat.moodCodePoint,
      fontFamily: fontFamily,
      fontPackage: fontPackage,
    );
  }

  HeatmapData _createYearHeatmapData(
    List<DailyCollectibleCount> yearlyCounts,
    ThemeData theme,
    DateTime? selectedDate,
  ) {
    final now = DateTime.now();
    final year = now.year;
    final columns = List<String>.generate(
      31,
      (index) => (index + 1).toString(),
    );
    final rows = List<String>.generate(12, (index) => '${index + 1}月');
    final maxCount = yearlyCounts.fold<int>(
      0,
      (prev, item) => item.count > prev ? item.count : prev,
    );
    final highlightValue = (maxCount + 1).toDouble();
    final highlightColor = theme.colorScheme.primary.withValues(alpha: 0.85);
    final Map<int, int> countMap = {
      for (final entry in yearlyCounts)
        DateUtils.dateOnly(entry.date).millisecondsSinceEpoch: entry.count,
    };
    final items = <HeatmapItem>[];
    for (var month = 1; month <= 12; month++) {
      final days = DateUtils.getDaysInMonth(year, month);
      for (var day = 1; day <= days; day++) {
        final current = DateTime(year, month, day);
        final key = DateUtils.dateOnly(current).millisecondsSinceEpoch;
        final count = countMap[key] ?? 0;
        final isSelected =
            selectedDate != null && DateUtils.isSameDay(current, selectedDate);
        items.add(
          ProfileHeatmapItem(
            date: current,
            count: count,
            displayValue: isSelected ? highlightValue : count.toDouble(),
            unit: '张',
            xAxisLabel: columns[day - 1],
            yAxisLabel: rows[month - 1],
          ),
        );
      }
    }
    return HeatmapData(
      columns: columns,
      rows: rows,
      items: items,
      colorPalette: _buildHeatmapPalette(theme, highlightColor),
      selectedColor: highlightColor,
      radius: 6,
    );
  }

  List<Color> _buildHeatmapPalette(ThemeData theme, Color highlightColor) {
    final primary = theme.colorScheme.primary;
    final surfaceVariant = theme.colorScheme.surfaceVariant;
    return [
      surfaceVariant.withValues(alpha: 0.45),
      primary.withValues(alpha: 0.15),
      primary.withValues(alpha: 0.3),
      primary.withValues(alpha: 0.45),
      primary.withValues(alpha: 0.65),
      highlightColor,
    ];
  }

  List<Color> _legendColors(List<Color> palette) {
    if (palette.length <= 6) {
      return palette;
    }
    final step = (palette.length / 6).ceil();
    final resolved = <Color>[];
    for (var i = 0; i < palette.length; i += step) {
      resolved.add(palette[i]);
      if (resolved.length == 6) {
        break;
      }
    }
    if (resolved.length < 6) {
      resolved.add(palette.last);
    } else {
      resolved[resolved.length - 1] = palette.last;
    }
    return resolved;
  }

  String _formatHeatmapSelection(ProfileHeatmapItem item) {
    final dateText = '${item.date.month}月${item.date.day}日';
    final countText = item.count;
    return '$dateText · $countText 张';
  }

  Widget _buildCategorySection(
    AsyncValue<List<CollectionEntity>> collectionsAsync,
  ) {
    return collectionsAsync.when(
      loading: () => const _SectionLoading(),
      error: (error, _) => _ErrorCard(message: '分类统计失败：$error'),
      data: (collections) {
        if (collections.isEmpty) {
          return const _EmptyCard(message: '暂无收集罐，先在首页添加一个吧');
        }
        final total = collections.fold<int>(0, (sum, e) => sum + e.itemCount);
        final sorted = [...collections]
          ..sort((a, b) => b.itemCount.compareTo(a.itemCount));
        return _CardContainer(
          child: Column(
            children: [
              for (final item in sorted)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: _CategoryTile(
                    name: item.name,
                    count: item.itemCount,
                    percent: total == 0 ? 0 : item.itemCount / total,
                    accent: parseHexColor(item.accentColor),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(
        context,
      ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
    );
  }
}

class _SectionLoading extends StatelessWidget {
  const _SectionLoading();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 32),
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class _ErrorCard extends StatelessWidget {
  const _ErrorCard({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return _CardContainer(
      child: Row(
        children: [
          const Icon(Icons.error_outline, color: Colors.redAccent),
          const SizedBox(width: 12),
          Expanded(child: Text(message)),
        ],
      ),
    );
  }
}

class _EmptyCard extends StatelessWidget {
  const _EmptyCard({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return _CardContainer(
      child: Row(
        children: [
          Icon(
            Icons.inbox_outlined,
            color: Theme.of(context).colorScheme.outline,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(message, style: Theme.of(context).textTheme.bodyMedium),
          ),
        ],
      ),
    );
  }
}

class _CardContainer extends StatelessWidget {
  const _CardContainer({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Padding(padding: const EdgeInsets.all(16), child: child),
    );
  }
}

class _StatItem {
  const _StatItem({
    required this.title,
    required this.value,
    required this.subtitle,
    required this.icon,
    required this.color,
  });

  final String title;
  final String value;
  final String subtitle;
  final IconData icon;
  final Color color;
}

class _StatGrid extends StatelessWidget {
  const _StatGrid({required this.items});

  final List<_StatItem> items;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return const _EmptyCard(message: '暂无统计数据');
    }
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 1,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return _StatCard(item: item);
      },
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({required this.item});

  final _StatItem item;

  @override
  Widget build(BuildContext context) {
    final bg = item.color.withValues(alpha: 0.12);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: item.color.withValues(alpha: 0.2),
            child: Icon(item.icon, color: item.color),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  item.value,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: item.color,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  item.title,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 4),
                Text(
                  item.subtitle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoryTile extends StatelessWidget {
  const _CategoryTile({
    required this.name,
    required this.count,
    required this.percent,
    required this.accent,
  });

  final String name;
  final int count;
  final double percent;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CircleAvatar(radius: 6, backgroundColor: accent),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                name,
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
              ),
            ),
            Text('$count 张'),
          ],
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: LinearProgressIndicator(
            value: percent.clamp(0, 1),
            minHeight: 8,
            backgroundColor: accent.withValues(alpha: 0.12),
            valueColor: AlwaysStoppedAnimation(accent),
          ),
        ),
      ],
    );
  }
}

/// 自定义热力图条目，方便记录所属日期
class ProfileHeatmapItem extends HeatmapItem {
  const ProfileHeatmapItem({
    required this.date,
    required this.count,
    required double displayValue,
    super.unit,
    super.xAxisLabel,
    super.yAxisLabel,
  }) : super(value: displayValue);

  final DateTime date;
  final int count;
}

class _MoodSlice {
  const _MoodSlice({
    required this.icon,
    required this.color,
    required this.count,
    required this.percent,
  });

  final IconData icon;
  final Color color;
  final int count;
  final double percent;
}

class _MoodLegend extends StatelessWidget {
  const _MoodLegend({required this.slices});

  final List<_MoodSlice> slices;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (final slice in slices)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: _MoodLegendItem(slice: slice),
          ),
      ],
    );
  }
}

class _MoodLegendItem extends StatelessWidget {
  const _MoodLegendItem({required this.slice});

  final _MoodSlice slice;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: slice.color.withValues(alpha: 0.2),
          child: Icon(slice.icon, color: slice.color),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            '${slice.count} 张',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
          ),
        ),
        Text(
          '${slice.percent.toStringAsFixed(1)} %',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Theme.of(context).colorScheme.outline,
          ),
        ),
      ],
    );
  }
}

class _HeatLegend extends StatelessWidget {
  const _HeatLegend({required this.colors});

  final List<Color> colors;

  @override
  Widget build(BuildContext context) {
    if (colors.length < 2) {
      return const SizedBox.shrink();
    }
    return Row(
      children: [
        Text(
          '少',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Theme.of(context).colorScheme.outline,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Row(
            children: [
              for (var i = 0; i < colors.length; i++)
                Expanded(
                  child: Container(
                    height: 8,
                    decoration: BoxDecoration(
                      color: colors[i],
                      borderRadius: BorderRadius.horizontal(
                        left: i == 0 ? const Radius.circular(4) : Radius.zero,
                        right: i == colors.length - 1
                            ? const Radius.circular(4)
                            : Radius.zero,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        Text(
          '多',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Theme.of(context).colorScheme.outline,
          ),
        ),
      ],
    );
  }
}
