import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/routes.dart';
import '../../../../app/providers/global_providers.dart';
import '../../../../shared/utils/color_utils.dart';
import '../../domain/entities/collection_models.dart';
import '../../presentation/providers/home_providers.dart';

/// 全局抽屉：展示全部收集罐并支持拖拽排序
class CollectionsDrawer extends ConsumerStatefulWidget {
  const CollectionsDrawer({super.key});

  @override
  ConsumerState<CollectionsDrawer> createState() => _CollectionsDrawerState();
}

class _CollectionsDrawerState extends ConsumerState<CollectionsDrawer> {
  List<CollectionEntity> _orderedCollections = const [];

  void _syncCollections(List<CollectionEntity> latest) {
    if (_orderedCollections.length != latest.length) {
      _orderedCollections = List.of(latest);
      return;
    }
    for (var i = 0; i < latest.length; i++) {
      if (_orderedCollections[i].id != latest[i].id) {
        _orderedCollections = List.of(latest);
        return;
      }
    }
  }

  Future<void> _handleReorder(int oldIndex, int newIndex) async {
    if (newIndex > oldIndex) newIndex -= 1;
    setState(() {
      final moved = _orderedCollections.removeAt(oldIndex);
      _orderedCollections.insert(newIndex, moved);
    });
    final orderedIds = _orderedCollections
        .map((e) => e.id)
        .whereType<int>()
        .toList();
    if (orderedIds.length != _orderedCollections.length) return;
    final usecase = ref.read(reorderCollectionsUsecaseProvider);
    await usecase.call(orderedIds);
  }

  @override
  Widget build(BuildContext context) {
    final collectionsAsync = ref.watch(homeCollectionsProvider);
    return Drawer(
      child: SafeArea(
        child: collectionsAsync.when(
          data: (collections) {
            _syncCollections(collections);
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
                  child: Text(
                    '收集罐',
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Divider(),
                ),
                Expanded(
                  child: _orderedCollections.isEmpty
                      ? Center(child: Text('暂无收集罐'))
                      : ReorderableListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          itemCount: _orderedCollections.length,
                          onReorder: _handleReorder,
                          buildDefaultDragHandles: false,
                          proxyDecorator: (child, index, animation) {
                            final curved = CurvedAnimation(
                              parent: animation,
                              curve: Curves.easeOut,
                            );
                            return AnimatedBuilder(
                              animation: curved,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(14),
                                child: Material(
                                  color: Colors.transparent,
                                  child: child,
                                ),
                              ),
                              builder: (context, child) {
                                final scale = 1 + curved.value * 0.02;
                                return Transform.scale(
                                  scale: scale,
                                  child: child,
                                );
                              },
                            );
                          },
                          itemBuilder: (context, index) {
                            final item = _orderedCollections[index];
                            return Padding(
                              key: ValueKey(item.id ?? index),
                              padding: EdgeInsets.zero,
                              child: _DrawerCollectionCard(
                                collection: item,
                                onTap: () {
                                  Navigator.of(context).pop();
                                  context.push(
                                    AppRoute.detailPathWithId(item.id ?? 0),
                                  );
                                },
                                dragHandle: ReorderableDragStartListener(
                                  index: index,
                                  child: const Icon(
                                    Icons.drag_indicator,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ],
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) => Center(child: Text('加载失败：$error')),
        ),
      ),
    );
  }
}

class _DrawerCollectionCard extends StatelessWidget {
  const _DrawerCollectionCard({
    required this.collection,
    required this.onTap,
    this.dragHandle,
  });

  final CollectionEntity collection;
  final VoidCallback onTap;
  final Widget? dragHandle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bodyStyle = theme.textTheme.bodyMedium;
    final subStyle = theme.textTheme.bodySmall?.copyWith(color: Colors.grey);
    final borderRadius = BorderRadius.circular(10);
    final accentColor = parseHexColor(collection.accentColor);
    return Card(
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: borderRadius),
      child: InkWell(
        borderRadius: borderRadius,
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                accentColor.withValues(alpha: 0.18),
                accentColor.withValues(alpha: 0.08),
              ],
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 10,
                height: 10,
                margin: const EdgeInsets.only(right: 12),
                decoration: BoxDecoration(
                  color: accentColor,
                  shape: BoxShape.circle,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(collection.name, style: bodyStyle),
                    const SizedBox(height: 2),
                    Text('共 ${collection.itemCount} 件', style: subStyle),
                  ],
                ),
              ),
              dragHandle ??
                  const Icon(Icons.drag_indicator, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}
