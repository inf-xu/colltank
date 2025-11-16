import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:path/path.dart' as p;

import '../../../../app/router/routes.dart';
import '../../../../app/shell/app_shell_scope.dart';
import '../../../../shared/utils/color_utils.dart';
import '../../domain/entities/collection_models.dart';
import '../../../settings/providers/preferences_providers.dart';
import '../../presentation/providers/home_providers.dart';
import '../providers/detail_providers.dart';

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
    final prefsAsync = ref.watch(appPreferencesProvider);
    final rootDirectory = prefsAsync.maybeWhen(
      data: (prefs) => prefs.rootDirectory,
      orElse: () => null,
    );
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
              data: (collections) =>
                  _buildCarousel(collections, rootDirectory: rootDirectory),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, _) => Center(child: Text('加载失败：$error')),
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildCarousel(
    List<CollectionEntity> collections, {
    required String? rootDirectory,
  }) {
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
                rootDirectory: rootDirectory,
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
    required this.rootDirectory,
    required this.onTap,
    required this.onEdit,
  });

  final CollectionEntity collection;
  final bool isActive;
  final String? rootDirectory;
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
    final previewWidget = collection.id == null
        ? _FramePreview(accentColor: accent)
        : _CardThumbnail(
            collectionId: collection.id!,
            accentColor: accent,
            rootDirectory: widget.rootDirectory,
          );

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
                      previewWidget,
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

/// 首页卡片缩略图：实时监听九宫格槽位与收藏文件
class _CardThumbnail extends ConsumerWidget {
  const _CardThumbnail({
    required this.collectionId,
    required this.accentColor,
    required this.rootDirectory,
  });

  final int collectionId;
  final Color accentColor;
  final String? rootDirectory;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final slotsAsync = ref.watch(
      collectionHighlightSlotsProvider(collectionId),
    );
    return AspectRatio(
      aspectRatio: 1,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: accentColor.withValues(alpha: 0.9),
            width: 3,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(13),
          child: slotsAsync.when(
            data: (slots) => Padding(
              padding: const EdgeInsets.all(8),
              child: _ThumbnailGrid(
                slots: slots,
                rootDirectory: rootDirectory,
                accentColor: accentColor,
              ),
            ),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, _) =>
                _ThumbnailError(accentColor: accentColor, message: '缩略图加载失败'),
          ),
        ),
      ),
    );
  }
}

class _ThumbnailGrid extends StatelessWidget {
  const _ThumbnailGrid({
    required this.slots,
    required this.rootDirectory,
    required this.accentColor,
  });

  final List<HighlightSlotEntity> slots;
  final String? rootDirectory;
  final Color accentColor;

  @override
  Widget build(BuildContext context) {
    final normalized = List<HighlightSlotEntity?>.filled(9, null);
    for (final slot in slots) {
      final index = slot.slotIndex;
      if (index >= 0 && index < normalized.length) {
        normalized[index] = slot;
      }
    }
    return GridView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: normalized.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 4,
        mainAxisSpacing: 4,
      ),
      itemBuilder: (context, index) {
        return _ThumbnailSlot(
          slot: normalized[index],
          rootDirectory: rootDirectory,
          accentColor: accentColor,
        );
      },
    );
  }
}

class _ThumbnailSlot extends ConsumerWidget {
  const _ThumbnailSlot({
    required this.slot,
    required this.rootDirectory,
    required this.accentColor,
  });

  final HighlightSlotEntity? slot;
  final String? rootDirectory;
  final Color accentColor;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final collectibleId = slot?.collectibleId;
    final isLocked = slot?.isLocked ?? false;

    Widget child;
    if (collectibleId == null) {
      child = const _SlotPlaceholder();
    } else {
      final collectibleAsync = ref.watch(
        collectibleDetailProvider(collectibleId),
      );
      child = collectibleAsync.when(
        data: (collectible) {
          if (collectible == null) {
            return const _SlotPlaceholder();
          }
          final absolutePath = _resolvePreviewPath(
            rootDirectory,
            collectible.relativePath,
          );
          if (absolutePath == null) {
            return const _SlotMessage(label: '未设置目录');
          }
          final file = File(absolutePath);
          if (!file.existsSync()) {
            return const _SlotMessage(label: '文件缺失');
          }
          return Image.file(file, fit: BoxFit.cover);
        },
        loading: () => const _SlotLoadingIndicator(),
        error: (error, _) => const _SlotMessage(label: '加载失败'),
      );
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        color: accentColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: accentColor.withValues(alpha: 0.25),
          width: 1,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(7),
        child: Stack(
          fit: StackFit.expand,
          children: [
            child,
            if (isLocked)
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: Icon(
                    Icons.lock,
                    size: 14,
                    color: Colors.white.withValues(alpha: 0.9),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _SlotPlaceholder extends StatelessWidget {
  const _SlotPlaceholder();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withValues(alpha: 0.04),
      child: const Center(
        child: Icon(Icons.image, size: 16, color: Colors.white70),
      ),
    );
  }
}

class _SlotMessage extends StatelessWidget {
  const _SlotMessage({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withValues(alpha: 0.25),
      child: Center(
        child: Text(
          label,
          style: const TextStyle(color: Colors.white, fontSize: 10),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class _SlotLoadingIndicator extends StatelessWidget {
  const _SlotLoadingIndicator();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withValues(alpha: 0.05),
      child: const Center(
        child: SizedBox(
          width: 14,
          height: 14,
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
      ),
    );
  }
}

class _ThumbnailError extends StatelessWidget {
  const _ThumbnailError({required this.accentColor, required this.message});

  final Color accentColor;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: accentColor.withValues(alpha: 0.2),
      child: Center(
        child: Text(message, style: const TextStyle(color: Colors.white)),
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
                    Icon(
                      Icons.add,
                      size: 48,
                      color: Theme.of(context).primaryColor,
                    ),
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

String? _resolvePreviewPath(String? rootDirectory, String relativePath) {
  if (relativePath.isEmpty) {
    return null;
  }
  if (p.isAbsolute(relativePath)) {
    return relativePath;
  }
  if (rootDirectory == null || rootDirectory.isEmpty) {
    return null;
  }
  return p.join(rootDirectory, relativePath);
}

String _formatDate(DateTime date) {
  return '${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
}
