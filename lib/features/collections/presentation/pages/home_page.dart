import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/routes.dart';
import '../../../../app/shell/app_shell_scope.dart';
import '../../../../shared/utils/color_utils.dart';
import '../../domain/entities/collection_models.dart';
import '../../presentation/providers/home_providers.dart';

/// 首页（收集罐列表）
class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  late final PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.78);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final collectionsAsync = ref.watch(homeCollectionsProvider);
    final drawerScope = AppShellScope.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('收集罐'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: drawerScope?.openDrawer,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: '添加收集罐',
            onPressed: _openCreateCollectionPage,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: collectionsAsync.when(
              data: (collections) => _buildCarousel(collections),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, _) => Center(child: Text('加载失败：$error')),
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildCarousel(List<CollectionEntity> collections) {
    final data = [...collections];
    final itemCount = data.length + 1; // +1 添加卡片
    return Column(
      children: [
        Expanded(
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) => setState(() => _currentPage = index),
            itemCount: itemCount,
            itemBuilder: (context, index) {
              final isActive = index == _currentPage;
              if (index == data.length) {
                return _AddCard(
                  isActive: isActive,
                  onTap: _openCreateCollectionPage,
                );
              }
              final item = data[index];
              return _CollectionCard(
                collection: item,
                isActive: isActive,
                onTap: () => context.push(AppRoute.detailPathWithId(item.id!)),
                onEdit: () => _openEditCollection(item),
              );
            },
          ),
        ),
        const SizedBox(height: 16),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              itemCount,
              (index) => AnimatedScale(
                scale: _currentPage == index ? 1.2 : 0.9,
                duration: const Duration(milliseconds: 200),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 10,
                  height: 10,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    color: _currentPage == index
                        ? Colors.greenAccent
                        : Colors.greenAccent.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _openCreateCollectionPage() async {
    final result = await context.push<bool>(AppRoute.createCollectionPath);
    if (result == true && mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('已创建收集罐')));
    }
  }

  Future<void> _openEditCollection(CollectionEntity collection) async {
    final result = await context.push<bool>(
      AppRoute.createCollectionPath,
      extra: collection,
    );
    if (result == true && mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('已更新收集罐')));
    }
  }
}

class _CollectionCard extends ConsumerStatefulWidget {
  const _CollectionCard({
    required this.collection,
    required this.isActive,
    required this.onTap,
    required this.onEdit,
  });

  final CollectionEntity collection;
  final bool isActive;
  final VoidCallback onTap;
  final VoidCallback onEdit;

  @override
  ConsumerState<_CollectionCard> createState() => _CollectionCardState();
}

class _CollectionCardState extends ConsumerState<_CollectionCard> {
  bool _isPressed = false;

  void _updatePressed(bool value) {
    if (_isPressed == value) return;
    setState(() => _isPressed = value);
  }

  @override
  Widget build(BuildContext context) {
    final collection = widget.collection;
    final theme = Theme.of(context);
    final accent = parseHexColor(collection.accentColor);
    final heatmapAsync = collection.id == null
        ? const AsyncValue<List<int>>.data(<int>[])
        : ref.watch(homeMonthlyHeatmapProvider(collection.id!));
    final latestUploadAsync = collection.id == null
        ? const AsyncValue<DateTime?>.data(null)
        : ref.watch(homeLatestUploadProvider(collection.id!));
    final baseScale = widget.isActive ? 1.0 : 0.92;
    final targetScale = _isPressed ? baseScale * 0.96 : baseScale;

    return AnimatedScale(
      scale: targetScale,
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOut,
      child: GestureDetector(
        onTap: widget.onTap,
        onLongPressStart: (_) => _updatePressed(true),
        onLongPressEnd: (_) => _updatePressed(false),
        onLongPressCancel: () => _updatePressed(false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOut,
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 24),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28),
            color: accent,
            boxShadow: _buildCardShadows(
              accent: accent,
              isActive: widget.isActive,
              isPressed: _isPressed,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      collection.name,
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.white),
                    tooltip: '编辑收集罐',
                    onPressed: widget.onEdit,
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                collection.description ?? '暂无描述',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: Colors.white70,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 16),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _FramePreview(accentColor: accent),
                      const SizedBox(height: 16),
                      Text(
                        '本月上传热度',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: Colors.white70,
                        ),
                      ),
                      const SizedBox(height: 8),
                      heatmapAsync.when(
                        data: (counts) => _HeatmapPreview(counts: counts),
                        loading: () => const SizedBox(
                          height: 24,
                          child: Center(child: CircularProgressIndicator()),
                        ),
                        error: (error, _) => Text(
                          '热力图加载失败',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: Colors.white70,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.collections, color: Colors.white),
                      const SizedBox(width: 4),
                      Text(
                        '${collection.itemCount} 件收藏',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  latestUploadAsync.when(
                    data: (date) => Text(
                      date == null ? '暂无上传' : '最近 ${_formatDate(date)}',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: Colors.white,
                      ),
                    ),
                    loading: () => const SizedBox(
                      height: 12,
                      width: 12,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                    error: (error, _) => Text(
                      '日期获取失败',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: Colors.white70,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FramePreview extends StatelessWidget {
  const _FramePreview({required this.accentColor});

  final Color accentColor;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: accentColor.withValues(alpha: 0.9),
            width: 3,
          ),
        ),
        padding: const EdgeInsets.all(8),
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 4,
            mainAxisSpacing: 4,
          ),
          itemBuilder: (context, index) {
            return DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Center(
                child: Icon(Icons.image, size: 16, color: Colors.white70),
              ),
            );
          },
          itemCount: 9,
        ),
      ),
    );
  }
}

class _HeatmapPreview extends StatelessWidget {
  const _HeatmapPreview({required this.counts});

  final List<int> counts;

  @override
  Widget build(BuildContext context) {
    if (counts.isEmpty) {
      return Text(
        '本月暂无上传',
        style: Theme.of(
          context,
        ).textTheme.bodySmall?.copyWith(color: Colors.white70),
      );
    }

    return Wrap(
      spacing: 4,
      runSpacing: 4,
      children: counts.map((value) {
        final hasUpload = value > 0;
        return Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
              color: hasUpload ? Colors.green : Colors.white54,
              width: 1,
            ),
          ),
          child: hasUpload
              ? const Icon(Icons.check, size: 12, color: Colors.green)
              : null,
        );
      }).toList(),
    );
  }
}

List<BoxShadow> _buildCardShadows({
  required Color accent,
  required bool isActive,
  required bool isPressed,
}) {
  double basePrimary = isActive ? 0.25 : 0.18;
  double baseSecondary = isActive ? 0.2 : 0.12;
  if (isPressed) {
    basePrimary = (basePrimary + 0.18).clamp(0.0, 0.6);
    baseSecondary = (baseSecondary + 0.12).clamp(0.0, 0.5);
  }
  return [
    BoxShadow(
      color: accent.withValues(alpha: basePrimary),
      blurRadius: isPressed ? 26 : 20,
      offset: const Offset(0, 8),
    ),
    BoxShadow(
      color: accent.withValues(alpha: basePrimary * 0.75),
      blurRadius: isPressed ? 24 : 18,
      offset: const Offset(0, -8),
    ),
    BoxShadow(
      color: accent.withValues(alpha: baseSecondary),
      blurRadius: isPressed ? 24 : 18,
      offset: const Offset(8, 0),
    ),
    BoxShadow(
      color: accent.withValues(alpha: baseSecondary),
      blurRadius: isPressed ? 24 : 18,
      offset: const Offset(-8, 0),
    ),
  ];
}

class _AddCard extends StatelessWidget {
  const _AddCard({required this.isActive, required this.onTap});

  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      scale: isActive ? 1.0 : 0.92,
      duration: const Duration(milliseconds: 200),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.white70, width: 2),
        ),
        child: SizedBox.expand(
          child: Card(
            margin: EdgeInsets.zero,
            elevation: 0,
            color: Colors.white70,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(22),
            ),
            child: InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(22),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.add, size: 48, color: Theme.of(context).primaryColor),
                    SizedBox(height: 12),
                    Text('添加收集罐'),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

String _formatDate(DateTime date) {
  return '${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
}
