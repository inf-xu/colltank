import 'package:flutter/material.dart';

/// 收集罐详情页：画框 + 功能按钮 + 瀑布流占位
class CollectionDetailPage extends StatelessWidget {
  const CollectionDetailPage({super.key, required this.collectionId});

  final int collectionId;

  void _showWorkInProgress(BuildContext context, String label) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('$label 功能开发中')));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final accent = theme.colorScheme.primary;
    const description = '把散落日常的咖啡杯、唱片和旅途小票都收进同一个罐子里，按心情排列，慢慢酿出专属的收藏仪式感。';
    return Scaffold(
      appBar: AppBar(
        title: Text('收集罐 #$collectionId'),
        centerTitle: true,
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.transparent,
        forceMaterialTransparency: true,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
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
                  onPressed: () => _showWorkInProgress(context, '切换画框'),
                  icon: const Icon(Icons.photo_filter_outlined),
                  label: const Text('切换画框'),
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    shadowColor: Colors.transparent,
                  ),
                  onPressed: () => _showWorkInProgress(context, '导出拼贴'),
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
          SizedBox(height: 18),
          Expanded(
            flex: 4,
            child: GridView.builder(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 32),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Center(child: Text('瀑布流 $index')),
                );
              },
              itemCount: 9,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add_photo_alternate),
      ),
    );
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
