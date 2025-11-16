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

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _handleRefresh() async {
    ref.invalidate(profileCollectionsProvider);
    ref.invalidate(profileYearlyCountsProvider);
  }

  @override
  Widget build(BuildContext context) {
    final collectionsAsync = ref.watch(profileCollectionsProvider);
    final yearlyAsync = ref.watch(profileYearlyCountsProvider);
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
              '今日也要好好记录。',
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
