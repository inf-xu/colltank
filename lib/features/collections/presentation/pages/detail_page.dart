import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:path/path.dart' as p;

import '../../../../app/providers/global_providers.dart';
import '../../../../app/router/routes.dart';
import '../../../../core/database/app_database.dart';
import '../../../../shared/utils/color_utils.dart';
import 'package:colltank/shared/providers/preferences_providers.dart';
import '../../domain/entities/collection_models.dart';
import '../controllers/collage_export_service.dart';
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

class _DualActionFab extends StatefulWidget {
  const _DualActionFab({
    required this.isLoading,
    required this.onTap,
    required this.onLongPress,
    required this.heroTag,
  });

  final bool isLoading;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final String heroTag;

  @override
  State<_DualActionFab> createState() => _DualActionFabState();
}

class _DualActionFabState extends State<_DualActionFab> {
  final _longPressRecognizer = LongPressGestureRecognizer();

  @override
  void dispose() {
    _longPressRecognizer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RawGestureDetector(
      gestures: {
        LongPressGestureRecognizer:
            GestureRecognizerFactoryWithHandlers<LongPressGestureRecognizer>(
          () => _longPressRecognizer,
          (instance) {
            instance.onLongPress = widget.onLongPress;
          },
        ),
      },
      child: FloatingActionButton(
        heroTag: widget.heroTag,
        onPressed: widget.onTap,
        child: widget.isLoading
            ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(strokeWidth: 3),
              )
            : const Icon(Icons.add_a_photo_outlined),
      ),
    );
  }
}

class _CollectionDetailPageState extends ConsumerState<CollectionDetailPage> {
  bool _isImporting = false;
  bool _isExporting = false;
  bool _isShuffling = false;
  final GlobalKey _canvasKey = GlobalKey();
  int? _editingSlotIndex;

  @override
  Widget build(BuildContext context) {
    final collectionAsync = ref.watch(
      collectionDetailProvider(widget.collectionId),
    );
    final galleryAsync = ref.watch(
      collectionGalleryProvider(widget.collectionId),
    );
    final highlightSlotsAsync = ref.watch(
      collectionHighlightSlotsProvider(widget.collectionId),
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
            slotsAsync: highlightSlotsAsync,
            prefsAsync: prefsAsync,
          ),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) => Center(child: Text('加载详情失败：$error')),
        ),
      ),
      floatingActionButton: Tooltip(
        message: '轻触相册 · 长按相机',
        child: _DualActionFab(
          isLoading: _isImporting,
          onTap: _isImporting ? null : _handleUpload,
          onLongPress:
              _isImporting ? null : () => _handleUpload(fromCamera: true),
          heroTag: 'detail-fab-${widget.collectionId}',
        ),
      ),
    );
  }

  Widget _buildBody(
    BuildContext context, {
    required CollectionEntity? collection,
    required Color accent,
    required AsyncValue<List<CollectibleEntity>> galleryAsync,
    required AsyncValue<List<HighlightSlotEntity>> slotsAsync,
    required AsyncValue<AppPreferenceRow> prefsAsync,
  }) {
    final userDescription = collection?.description?.trim();
    final description = (userDescription?.isNotEmpty ?? false)
        ? userDescription!
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
            child: slotsAsync.when(
              data: (slots) {
                final galleryItems = galleryAsync.asData?.value ?? const [];
                final slotMap = _indexCollectibles(galleryItems);
                return GestureDetector(
                  onTap: () => _setEditingSlot(null),
                  child: RepaintBoundary(
                    key: _canvasKey,
                    child: _FrameCanvasBoard(
                      accentColor: accent,
                      collectionId: collection?.id ?? widget.collectionId,
                      slots: slots,
                      collectiblesById: slotMap,
                      rootDirectory: rootDirectory,
                      editingSlotIndex: _editingSlotIndex,
                      onEditingSlotChanged: _setEditingSlot,
                    ),
                  ),
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, _) => Center(child: Text('画框加载失败：$error')),
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
                onPressed: _isShuffling ? null : _shuffleHighlights,
                icon: _isShuffling
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.shuffle),
                label: Text(_isShuffling ? '打乱中...' : '随机打乱'),
              ),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  shadowColor: Colors.transparent,
                ),
                onPressed: _isExporting ? null : _handleExport,
                icon: _isExporting
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.download_outlined),
                label: Text(_isExporting ? '导出中...' : '导出拼贴'),
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

  Future<void> _handleUpload({bool fromCamera = false}) async {
    final navigator = Navigator.of(context);
    final service = CollectibleImportService(ref);
    setState(() => _isImporting = true);
    try {
      final result = fromCamera
          ? await service.importFromCamera(
              navigator: navigator,
              collectionId: widget.collectionId,
            )
          : await service.importFromGallery(
              navigator: navigator,
              collectionId: widget.collectionId,
            );
      if (!mounted) return;
      final messenger = ScaffoldMessenger.of(context);
      _showSnack(messenger, '图片已保存：${result.relativePath}');
    } on RootDirectoryMissingException {
      if (!mounted) return;
      await _showDirectoryGuide();
    } on MediaPermissionDeniedException {
      if (!mounted) return;
      final messenger = ScaffoldMessenger.of(context);
      _showSnack(messenger, '请在系统设置授予照片读取权限');
    } on UserAbortedImportException {
      if (!mounted) return;
      final messenger = ScaffoldMessenger.of(context);
      _showSnack(messenger, '已取消选择图片');
    } catch (error) {
      if (!mounted) return;
      final messenger = ScaffoldMessenger.of(context);
      _showSnack(messenger, '导入失败：$error');
    } finally {
      if (mounted) {
        setState(() => _isImporting = false);
      }
    }
  }

  Future<void> _handleExport() async {
    if (_isExporting) return;
    setState(() => _isExporting = true);
    try {
      final snapshot = await _captureCanvas();
      final service = CollageExportService(ref);
      final result = await service.saveToGallery(
        collectionId: widget.collectionId,
        bytes: snapshot.bytes,
        width: snapshot.width,
        height: snapshot.height,
      );
      if (!mounted) return;
      final messenger = ScaffoldMessenger.of(context);
      _showSnack(messenger, '已保存到相册：${result.fileName}');
    } on CanvasCaptureException catch (error) {
      if (!mounted) return;
      final messenger = ScaffoldMessenger.of(context);
      _showSnack(messenger, error.toString());
    } on CollageExportException catch (error) {
      if (!mounted) return;
      final messenger = ScaffoldMessenger.of(context);
      _showSnack(messenger, error.toString());
    } catch (error) {
      if (!mounted) return;
      final messenger = ScaffoldMessenger.of(context);
      _showSnack(messenger, '导出失败：$error');
    } finally {
      if (mounted) {
        setState(() => _isExporting = false);
      }
    }
  }

  Future<void> _shuffleHighlights() async {
    setState(() => _isShuffling = true);
    try {
      final repository = ref.read(highlightSlotsRepositoryProvider);
      await repository.shuffleSlots(widget.collectionId);
      if (!mounted) return;
      final messenger = ScaffoldMessenger.of(context);
      _showSnack(messenger, '已随机打乱画框');
    } catch (error) {
      if (!mounted) return;
      final messenger = ScaffoldMessenger.of(context);
      _showSnack(messenger, '打乱失败：$error');
    } finally {
      if (mounted) {
        setState(() => _isShuffling = false);
      }
    }
  }

  Future<_CapturedCanvas> _captureCanvas() async {
    final boundary =
        _canvasKey.currentContext?.findRenderObject() as RenderRepaintBoundary?;
    if (boundary == null) {
      throw const CanvasCaptureException('画布未就绪，请稍后再试');
    }
    final pixelRatio = MediaQuery.of(context).devicePixelRatio * 2;
    final image = await boundary.toImage(pixelRatio: pixelRatio);
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    if (byteData == null) {
      throw const CanvasCaptureException('导出图像数据为空，请重试');
    }
    return _CapturedCanvas(
      bytes: byteData.buffer.asUint8List(),
      width: image.width,
      height: image.height,
    );
  }

  void _setEditingSlot(int? slotIndex) {
    if (_editingSlotIndex == slotIndex) {
      return;
    }
    setState(() => _editingSlotIndex = slotIndex);
  }

  Future<void> _selectDirectory() async {
    final service = CollectibleImportService(ref);
    final selected = await service.selectRootDirectory();
    if (!mounted) return;
    if (selected == null) {
      final messenger = ScaffoldMessenger.of(context);
      _showSnack(messenger, '已取消目录设置');
    } else {
      final messenger = ScaffoldMessenger.of(context);
      _showSnack(messenger, '已设置保存目录：$selected');
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

  void _showSnack(ScaffoldMessengerState messenger, String text) {
    messenger.showSnackBar(SnackBar(content: Text(text)));
  }
}

/// 画框 3×3 画布：承载拖拽目标
class _FrameCanvasBoard extends ConsumerWidget {
  const _FrameCanvasBoard({
    required this.accentColor,
    required this.collectionId,
    required this.slots,
    required this.collectiblesById,
    required this.rootDirectory,
    required this.editingSlotIndex,
    required this.onEditingSlotChanged,
  });

  final Color accentColor;
  final int collectionId;
  final List<HighlightSlotEntity> slots;
  final Map<int, CollectibleEntity> collectiblesById;
  final String? rootDirectory;
  final int? editingSlotIndex;
  final ValueChanged<int?> onEditingSlotChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final slotByIndex = {for (final slot in slots) slot.slotIndex: slot};
    final assignSlot = ref.read(assignHighlightSlotUsecaseProvider);
    return AspectRatio(
      aspectRatio: 1,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: accentColor.withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(10),
        ),
        child: GridView.builder(
          padding: const EdgeInsets.all(8),
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemCount: 9,
          itemBuilder: (context, index) {
            final slot = slotByIndex[index];
            final occupant = slot?.collectibleId == null
                ? null
                : collectiblesById[slot!.collectibleId!];
            final isLocked = slot?.isLocked ?? false;
            return GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () => onEditingSlotChanged(null),
              onLongPress: occupant != null && !isLocked
                  ? () => onEditingSlotChanged(index)
                  : null,
              child: DragTarget<CollectibleEntity>(
                onWillAcceptWithDetails: (details) {
                  final candidate = details.data;
                  return isLocked ? false : candidate.id != null;
                },
                onAcceptWithDetails: (details) async {
                  final collectibleId = details.data.id;
                  if (collectibleId == null) return;
                  await assignSlot(
                    collectionId: collectionId,
                    slotIndex: index,
                    collectibleId: collectibleId,
                  );
                  onEditingSlotChanged(null);
                },
                builder: (context, candidateData, rejectedData) {
                  final isHighlighted = candidateData.isNotEmpty;
                  final showRemove =
                      editingSlotIndex == index &&
                      occupant != null &&
                      !isLocked;
                  return _CanvasSlotTile(
                    slotIndex: index,
                    accentColor: accentColor,
                    collectible: occupant,
                    rootDirectory: rootDirectory,
                    isHighlighted: isHighlighted,
                    isLocked: isLocked,
                    showRemove: showRemove,
                    onRemove: showRemove
                        ? () async {
                            await assignSlot(
                              collectionId: collectionId,
                              slotIndex: index,
                              collectibleId: null,
                            );
                            onEditingSlotChanged(null);
                          }
                        : null,
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

class _CanvasSlotTile extends StatelessWidget {
  const _CanvasSlotTile({
    required this.slotIndex,
    required this.accentColor,
    required this.collectible,
    required this.rootDirectory,
    required this.isHighlighted,
    required this.isLocked,
    required this.showRemove,
    required this.onRemove,
  });

  final int slotIndex;
  final Color accentColor;
  final CollectibleEntity? collectible;
  final String? rootDirectory;
  final bool isHighlighted;
  final bool isLocked;
  final bool showRemove;
  final VoidCallback? onRemove;

  @override
  Widget build(BuildContext context) {
    final bgColor = isHighlighted
        ? accentColor.withValues(alpha: 0.25)
        : accentColor.withValues(alpha: 0.12);
    return AnimatedContainer(
      duration: const Duration(milliseconds: 160),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Stack(
          fit: StackFit.expand,
          children: [
            if (collectible != null)
              _CanvasImagePreview(
                collectible: collectible!,
                rootDirectory: rootDirectory,
              )
            else
              _CanvasPlaceholder(slotIndex: slotIndex),
            if (isLocked)
              Positioned(
                right: 8,
                top: 8,
                child: Icon(
                  Icons.lock,
                  color: Colors.white.withValues(alpha: 0.9),
                ),
              ),
            if (showRemove)
              Positioned(
                right: 4,
                top: 4,
                child: IconButton(
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.black.withValues(alpha: 0.6),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    minimumSize: const Size(28, 28),
                  ),
                  padding: EdgeInsets.zero,
                  onPressed: onRemove,
                  icon: const Icon(
                    Icons.delete_outline,
                    size: 16,
                    color: Colors.white,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _CanvasImagePreview extends StatelessWidget {
  const _CanvasImagePreview({
    required this.collectible,
    required this.rootDirectory,
  });

  final CollectibleEntity collectible;
  final String? rootDirectory;

  @override
  Widget build(BuildContext context) {
    final absolutePath = _resolveAbsolutePath(
      rootDirectory,
      collectible.relativePath,
    );
    if (absolutePath == null) {
      return const _CanvasMissingIndicator(message: '未设置目录');
    }
    final file = File(absolutePath);
    if (!file.existsSync()) {
      return const _CanvasMissingIndicator(message: '文件缺失');
    }
    return Image.file(file, fit: BoxFit.cover);
  }
}

class _CanvasPlaceholder extends StatelessWidget {
  const _CanvasPlaceholder({required this.slotIndex});

  final int slotIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withValues(alpha: 0.04),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.image, color: Colors.white70),
            const SizedBox(height: 4),
          ],
        ),
      ),
    );
  }
}

class _CanvasMissingIndicator extends StatelessWidget {
  const _CanvasMissingIndicator({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withValues(alpha: 0.35),
      child: Center(
        child: Text(
          message,
          style: const TextStyle(color: Colors.white, fontSize: 12),
        ),
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

class _CapturedCanvas {
  const _CapturedCanvas({
    required this.bytes,
    required this.width,
    required this.height,
  });

  final Uint8List bytes;
  final int width;
  final int height;
}

class CanvasCaptureException implements Exception {
  const CanvasCaptureException(this.message);

  final String message;

  @override
  String toString() => message;
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
        final absolutePath = _resolveAbsolutePath(
          rootDirectory,
          item.relativePath,
        );
        final file = absolutePath != null ? File(absolutePath) : null;
        final exists = file?.existsSync() ?? false;
        return _DraggableCollectibleTile(
          item: item,
          file: exists ? file : null,
          missingLabel: absolutePath == null ? '未设置目录' : '文件缺失',
          onTap: () {
            if (item.id != null) {
              context.push(AppRoute.collectibleDetailPathWithId(item.id!));
            }
          },
        );
      },
    );
  }
}

class _DraggableCollectibleTile extends StatelessWidget {
  const _DraggableCollectibleTile({
    required this.item,
    required this.file,
    required this.missingLabel,
    required this.onTap,
  });

  final CollectibleEntity item;
  final File? file;
  final String missingLabel;
  final VoidCallback onTap;

  bool get _canDrag => (item.id != null) && item.allowHighlight;

  @override
  Widget build(BuildContext context) {
    final placeholder = Container(
      color: Colors.grey.shade300,
      child: Center(
        child: Text(
          missingLabel,
          style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
          textAlign: TextAlign.center,
        ),
      ),
    );
    final tile = ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: file != null
          ? Stack(
              fit: StackFit.expand,
              children: [
                Image.file(file!, fit: BoxFit.cover),
                Positioned.fill(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(onTap: onTap),
                  ),
                ),
              ],
            )
          : GestureDetector(onTap: onTap, child: placeholder),
    );
    if (!_canDrag) {
      return tile;
    }
    return LongPressDraggable<CollectibleEntity>(
      data: item,
      dragAnchorStrategy: pointerDragAnchorStrategy,
      feedback: _DragPreview(file: file, label: item.displayName),
      maxSimultaneousDrags: 1,
      childWhenDragging: Opacity(opacity: 0.2, child: tile),
      child: tile,
    );
  }
}

class _DragPreview extends StatelessWidget {
  const _DragPreview({required this.file, required this.label});

  final File? file;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: SizedBox(
        width: 120,
        height: 120,
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            // border: Border.all(color: Colors.white, width: 2),
            // boxShadow: const [
            //   BoxShadow(
            //     color: Colors.black38,
            //     blurRadius: 12,
            //     offset: Offset(0, 6),
            //   ),
            // ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Stack(
              fit: StackFit.expand,
              children: [
                if (file != null)
                  Image.file(file!, fit: BoxFit.cover)
                else
                  Container(
                    color: Colors.grey.shade400,
                    child: const Icon(
                      Icons.image_not_supported_outlined,
                      color: Colors.white,
                    ),
                  ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    color: Colors.black54,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    child: Text(
                      label,
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
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

Map<int, CollectibleEntity> _indexCollectibles(List<CollectibleEntity> items) {
  final map = <int, CollectibleEntity>{};
  for (final item in items) {
    final id = item.id;
    if (id != null) {
      map[id] = item;
    }
  }
  return map;
}

String? _resolveAbsolutePath(String? rootDirectory, String relativePath) {
  if (rootDirectory == null || rootDirectory.isEmpty) {
    return null;
  }
  return p.join(rootDirectory, relativePath);
}
