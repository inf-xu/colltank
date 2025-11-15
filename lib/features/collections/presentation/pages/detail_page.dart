import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as p;

import '../../../../core/database/app_database.dart';
import '../../../../shared/utils/color_utils.dart';
import '../../../settings/providers/preferences_providers.dart';
import '../../domain/entities/collection_models.dart';
import '../controllers/collectible_import_controller.dart';
import '../providers/detail_providers.dart';

const _defaultDescription = '把散落日常的咖啡杯、唱片和旅途小票都收进同一个罐子里，按心情排列，慢慢酿出专属的收藏仪式感。';

/// 收集罐详情页：画框 + 功能按钮 + 权限/存储控制 + 实际瀑布流
class CollectionDetailPage extends ConsumerStatefulWidget {
  const CollectionDetailPage({super.key, required this.collectionId});

  final int collectionId;

  @override
  ConsumerState<CollectionDetailPage> createState() =>
      _CollectionDetailPageState();
}

class _CollectionDetailPageState extends ConsumerState<CollectionDetailPage> {
  bool _isImporting = false;

  @override
  Widget build(BuildContext context) {
    final collectionAsync = ref.watch(
      collectionDetailProvider(widget.collectionId),
    );
    final galleryAsync = ref.watch(
      collectionGalleryProvider(widget.collectionId),
    );
    final prefsAsync = ref.watch(appPreferencesProvider);
    final title = collectionAsync.value?.name ?? '收集罐 #${widget.collectionId}';
    final accent = parseHexColor(
      collectionAsync.value?.accentColor ?? '#FFA726',
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
        forceMaterialTransparency: true,
      ),
      body: SafeArea(
        child: collectionAsync.when(
          data: (collection) => _buildBody(
            context,
            collection: collection,
            accent: accent,
            galleryAsync: galleryAsync,
            prefsAsync: prefsAsync,
          ),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) => Center(child: Text('加载详情失败：$error')),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _isImporting ? null : _handleUpload,
        child: _isImporting
            ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(strokeWidth: 3),
              )
            : const Icon(Icons.add_photo_alternate),
      ),
    );
  }

  Widget _buildBody(
    BuildContext context, {
    required CollectionEntity? collection,
    required Color accent,
    required AsyncValue<List<CollectibleEntity>> galleryAsync,
    required AsyncValue<AppPreferenceRow> prefsAsync,
  }) {
    final description = (collection?.description ?? '').isNotEmpty
        ? collection!.description!
        : _defaultDescription;
    final rootDirectory = prefsAsync.maybeWhen(
      data: (data) => data.rootDirectory,
      orElse: () => null,
    );
    return Column(
      children: [
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.only(top: 8),
            child: AspectRatio(
              aspectRatio: 1,
              child: _FrameCanvasPlaceholder(accentColor: accent),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  shadowColor: Colors.transparent,
                ),
                onPressed: () => _showWorkInProgress('切换画框'),
                icon: const Icon(Icons.photo_filter_outlined),
                label: const Text('切换画框'),
              ),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  shadowColor: Colors.transparent,
                ),
                onPressed: () => _showWorkInProgress('导出拼贴'),
                icon: const Icon(Icons.download_outlined),
                label: const Text('导出拼贴'),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
          child: _CollectionDescriptionCard(
            accentColor: accent,
            description: description,
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
          child: prefsAsync.when(
            data: (prefs) => _StorageDirectoryCard(
              path: prefs.rootDirectory,
              onSelect: _selectDirectory,
            ),
            loading: () => const _StorageDirectoryCard(isLoading: true),
            error: (error, _) => _StorageDirectoryCard(
              isError: true,
              errorMessage: '读取保存目录失败：$error',
              onSelect: _selectDirectory,
            ),
          ),
        ),
        const SizedBox(height: 12),
        Expanded(
          flex: 4,
          child: galleryAsync.when(
            data: (items) =>
                _CollectibleGrid(items: items, rootDirectory: rootDirectory),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, _) => Center(child: Text('加载图片失败：$error')),
          ),
        ),
      ],
    );
  }

  Future<void> _handleUpload() async {
    final service = CollectibleImportService(ref);
    setState(() => _isImporting = true);
    try {
      final result = await service.importFromGallery(
        collectionId: widget.collectionId,
      );
      if (!mounted) return;
      _showSnack('图片已保存：${result.relativePath}');
    } on RootDirectoryMissingException {
      if (!mounted) return;
      await _showDirectoryGuide();
    } on MediaPermissionDeniedException {
      if (!mounted) return;
      _showSnack('请在系统设置授予照片读取权限');
    } on ImageProcessingException catch (error) {
      if (!mounted) return;
      _showSnack('裁剪失败：$error');
    } on UserAbortedImportException {
      if (!mounted) return;
      _showSnack('已取消选择图片');
    } catch (error) {
      if (!mounted) return;
      _showSnack('导入失败：$error');
    } finally {
      if (mounted) {
        setState(() => _isImporting = false);
      }
    }
  }

  Future<void> _selectDirectory() async {
    final service = CollectibleImportService(ref);
    final selected = await service.selectRootDirectory();
    if (!mounted) return;
    if (selected == null) {
      _showSnack('已取消目录设置');
    } else {
      _showSnack('已设置保存目录：$selected');
    }
  }

  Future<void> _showDirectoryGuide() async {
    await showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '设置图片保存目录',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Android 13+ 需要先授权一个可访问的目录，导入的图片才可以复制保存。'
                  '目录建议选择内部存储的“CollTank”或任意新建文件夹，应用会在其中按收集罐 ID 建立子目录。',
                  style: TextStyle(height: 1.5),
                ),
                const SizedBox(height: 20),
                FilledButton.icon(
                  onPressed: () {
                    Navigator.of(context).pop();
                    _selectDirectory();
                  },
                  icon: const Icon(Icons.folder_outlined),
                  label: const Text('立即选择目录'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showWorkInProgress(String label) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('$label 功能开发中')));
  }

  void _showSnack(String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
  }
}

/// 画框占位：复用首页缩略图的 3×3 样式，保证 1:1 比例
class _FrameCanvasPlaceholder extends StatelessWidget {
  const _FrameCanvasPlaceholder({required this.accentColor});

  final Color accentColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: accentColor.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: Colors.transparent, width: 2),
      ),
      padding: const EdgeInsets.all(6),
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 6,
          mainAxisSpacing: 6,
        ),
        itemBuilder: (context, index) {
          return DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.4),
              borderRadius: BorderRadius.circular(6),
            ),
            child: const Center(
              child: Icon(Icons.image, size: 32, color: Colors.white),
            ),
          );
        },
        itemCount: 9,
      ),
    );
  }
}

/// 描述信息卡片：展示收集罐故事，保证与画框区协调
class _CollectionDescriptionCard extends StatelessWidget {
  const _CollectionDescriptionCard({
    required this.accentColor,
    required this.description,
  });

  final Color accentColor;
  final String description;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DecoratedBox(
      decoration: BoxDecoration(
        color: accentColor.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: accentColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.auto_awesome, color: Colors.white),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '收藏物语',
                    style: theme.textTheme.titleSmall?.copyWith(
                      color: theme.colorScheme.onSurface,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StorageDirectoryCard extends StatelessWidget {
  const _StorageDirectoryCard({
    this.path,
    this.isLoading = false,
    this.isError = false,
    this.errorMessage,
    this.onSelect,
  });

  final String? path;
  final bool isLoading;
  final bool isError;
  final String? errorMessage;
  final VoidCallback? onSelect;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final hasPath = (path ?? '').isNotEmpty;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(
              Icons.folder_special_outlined,
              color: theme.colorScheme.primary,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: isLoading
                  ? Row(
                      children: const [
                        SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                        SizedBox(width: 12),
                        Text('正在检查保存目录...'),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          hasPath ? path! : '尚未设置图片保存目录，导入前请先选择',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        if (isError && errorMessage != null) ...[
                          const SizedBox(height: 6),
                          Text(
                            errorMessage!,
                            style: TextStyle(
                              color: theme.colorScheme.error,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ],
                    ),
            ),
            const SizedBox(width: 12),
            FilledButton(
              onPressed: (isLoading || onSelect == null) ? null : onSelect,
              child: Text(hasPath ? '变更目录' : '去设置'),
            ),
          ],
        ),
      ),
    );
  }
}

class _CollectibleGrid extends StatelessWidget {
  const _CollectibleGrid({required this.items, required this.rootDirectory});

  final List<CollectibleEntity> items;
  final String? rootDirectory;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return const _EmptyGalleryPlaceholder();
    }
    return GridView.builder(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 32),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        final absolutePath = _resolveAbsolutePath(item);
        final file = absolutePath != null ? File(absolutePath) : null;
        final exists = file?.existsSync() ?? false;
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: exists
              ? Image.file(file!, fit: BoxFit.cover)
              : Container(
                  color: Colors.grey.shade300,
                  child: Center(
                    child: Text(
                      '文件缺失',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ),
                ),
        );
      },
    );
  }

  String? _resolveAbsolutePath(CollectibleEntity item) {
    if (rootDirectory == null || rootDirectory!.isEmpty) {
      return null;
    }
    return p.join(rootDirectory!, item.relativePath);
  }
}

class _EmptyGalleryPlaceholder extends StatelessWidget {
  const _EmptyGalleryPlaceholder();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(Icons.photo_library_outlined, size: 48),
          SizedBox(height: 12),
          Text('还没有图片，点击右下角上传'),
        ],
      ),
    );
  }
}
