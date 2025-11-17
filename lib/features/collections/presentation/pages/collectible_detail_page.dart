import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as p;

import '../../../../shared/utils/color_utils.dart';
import 'package:colltank/shared/providers/preferences_providers.dart';
import '../../domain/entities/collection_models.dart';
import '../providers/detail_providers.dart';
import '../../../../app/providers/global_providers.dart';
import '../../../../shared/utils/mood_icon_utils.dart';

class CollectibleDetailPage extends ConsumerWidget {
  const CollectibleDetailPage({super.key, required this.collectibleId});

  final int collectibleId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final collectibleAsync = ref.watch(
      collectibleDetailProvider(collectibleId),
    );
    final prefsAsync = ref.watch(appPreferencesProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('收藏详情'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: () async {
              final collectible = collectibleAsync.value;
              if (collectible == null) return;
              final confirmed =
                  await showDialog<bool>(
                    context: context,
                    builder: (dialogContext) {
                      return AlertDialog(
                        title: const Text('移除收藏'),
                        content: Text('确定要删除「${collectible.displayName}」吗？'),
                        actions: [
                          TextButton(
                            onPressed: () =>
                                Navigator.of(dialogContext).pop(false),
                            child: const Text('取消'),
                          ),
                          FilledButton(
                            onPressed: () =>
                                Navigator.of(dialogContext).pop(true),
                            child: const Text('删除'),
                          ),
                        ],
                      );
                    },
                  ) ??
                  false;
              if (!confirmed || !context.mounted) return;
              final repo = ref.read(collectiblesRepositoryProvider);
              await repo.deleteByIds([collectible.id!]);
              if (!context.mounted) return;
              Navigator.of(context).pop();
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('收藏已删除')));
            },
          ),
        ],
      ),
      body: SafeArea(
        child: collectibleAsync.when(
          data: (collectible) {
            if (collectible == null) {
              return const Center(child: Text('未找到该收藏'));
            }
            final rootDir = prefsAsync.maybeWhen(
              data: (prefs) => prefs.rootDirectory,
              orElse: () => null,
            );
            return _CollectibleDetailBody(
              collectible: collectible,
              rootDirectory: rootDir,
              onEdit: () => _showEditSheet(
                context,
                ref: ref,
                collectible: collectible,
                rootDirectory: rootDir,
              ),
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) => Center(child: Text('加载失败：$error')),
        ),
      ),
    );
  }
}

class _CollectibleDetailBody extends StatelessWidget {
  const _CollectibleDetailBody({
    required this.collectible,
    required this.rootDirectory,
    required this.onEdit,
  });

  final CollectibleEntity collectible;
  final String? rootDirectory;
  final Future<void> Function() onEdit;

  @override
  Widget build(BuildContext context) {
    final absolutePath = _resolveAbsolutePath(
      rootDirectory,
      collectible.relativePath,
    );
    final availablePath =
        (absolutePath != null && File(absolutePath).existsSync())
        ? absolutePath
        : null;
    final preset = findMoodPreset(collectible.moodCodePoint);
    final defaultColor =
        preset?.color ??
        (collectible.moodColor.isEmpty ? '#FFFFC107' : collectible.moodColor);
    final moodColor = parseHexColor(defaultColor);
    final moodIcon = resolveMoodIcon(
      codePoint: collectible.moodCodePoint,
      fontFamily: collectible.moodFontFamily,
      fontPackage: collectible.moodPackage,
    );
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        AspectRatio(
          aspectRatio: 1,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: availablePath != null
                ? Image.file(File(availablePath), fit: BoxFit.cover)
                : Container(
                    color: Colors.grey.shade200,
                    child: const Center(child: Text('图片不可用')),
                  ),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          collectible.displayName,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: TextButton.icon(
            onPressed: onEdit,
            icon: const Icon(Icons.edit_outlined),
            label: const Text('编辑'),
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 12,
          runSpacing: 8,
          children: [
            _InfoChip(
              icon: Icons.calendar_today_outlined,
              label: '收藏时间',
              value: collectible.capturedAt.toLocal().toString(),
            ),
            _InfoChip(
              icon: Icons.data_usage_outlined,
              label: '文件大小',
              value: _formatBytes(collectible.fileSizeBytes),
            ),
            _InfoChip(
              icon: Icons.layers_outlined,
              label: '可用于画框',
              value: collectible.allowHighlight ? '是' : '否',
            ),
          ],
        ),
        const SizedBox(height: 16),
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: CircleAvatar(
            backgroundColor: moodColor.withValues(alpha: 0.2),
            child: Icon(moodIcon, color: moodColor),
          ),
          title: const Text('心情'),
          subtitle: Text(collectible.moodColor),
        ),
        const SizedBox(height: 12),
        Text('物语', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        Text(
          (collectible.story?.trim().isNotEmpty ?? false)
              ? collectible.story!
              : '暂无描述',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(height: 1.5),
        ),
      ],
    );
  }

  String _formatBytes(int bytes) {
    const units = ['B', 'KB', 'MB', 'GB'];
    double value = bytes.toDouble();
    int index = 0;
    while (value >= 1024 && index < units.length - 1) {
      value /= 1024;
      index++;
    }
    return '${value.toStringAsFixed(1)} ${units[index]}';
  }
}

class _InfoChip extends StatelessWidget {
  const _InfoChip({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16),
          const SizedBox(width: 6),
          Text('$label：$value', style: Theme.of(context).textTheme.bodySmall),
        ],
      ),
    );
  }
}

String? _resolveAbsolutePath(String? rootDirectory, String relativePath) {
  if (rootDirectory == null || rootDirectory.isEmpty) {
    return null;
  }
  return p.join(rootDirectory, relativePath);
}

Future<void> _showEditSheet(
  BuildContext context, {
  required WidgetRef ref,
  required CollectibleEntity collectible,
  required String? rootDirectory,
}) async {
  final nameController = TextEditingController(text: collectible.displayName);
  final storyController = TextEditingController(text: collectible.story ?? '');
  final moodOptions = kMoodPresets;
  var selectedCodePoint = collectible.moodCodePoint;
  var selectedFontFamily = collectible.moodFontFamily;
  var selectedFontPackage = collectible.moodPackage;
  var selectedColor = collectible.moodColor;

  await showModalBottomSheet<void>(
    context: context,
    showDragHandle: true,
    isScrollControlled: true,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return Padding(
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
              bottom: MediaQuery.of(context).viewInsets.bottom + 20,
              top: 16,
            ),
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height * 0.6,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '编辑收藏详情',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: nameController,
                      decoration: const InputDecoration(labelText: '物品昵称'),
                    ),
                    const SizedBox(height: 12),
                    const Text('物语'),
                    const SizedBox(height: 6),
                    TextField(
                      controller: storyController,
                      maxLines: 4,
                      decoration: const InputDecoration(
                        hintText: '记录一点心情吧',
                        alignLabelWithHint: true,
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text('心情图标'),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 12,
                      runSpacing: 8,
                      children: moodOptions.map((preset) {
                        final icon = preset.icon;
                        final color = preset.color;
                        final isSelected =
                            icon.codePoint == selectedCodePoint &&
                            color == selectedColor;
                        return ChoiceChip(
                          label: Icon(icon, color: parseHexColor(color)),
                          selected: isSelected,
                          onSelected: (_) {
                            setState(() {
                              selectedCodePoint = icon.codePoint;
                              selectedFontFamily =
                                  icon.fontFamily ?? 'MaterialIcons';
                              selectedFontPackage = icon.fontPackage;
                              selectedColor = color;
                            });
                          },
                          selectedColor: parseHexColor(
                            color,
                          ).withValues(alpha: 0.2),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: const Text('取消'),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: FilledButton(
                            onPressed: () async {
                              final repo = ref.read(
                                collectiblesRepositoryProvider,
                              );
                              await repo.updateMeta(
                                id: collectible.id!,
                                displayName: nameController.text.trim().isEmpty
                                    ? '未命名收藏'
                                    : nameController.text.trim(),
                                story: storyController.text.trim(),
                                moodCodePoint: selectedCodePoint,
                                moodFontFamily: selectedFontFamily.isEmpty
                                    ? 'MaterialIcons'
                                    : selectedFontFamily,
                                moodPackage:
                                    (selectedFontPackage == null ||
                                        selectedFontPackage!.isEmpty)
                                    ? null
                                    : selectedFontPackage,
                                moodColor: selectedColor,
                              );
                              if (!context.mounted) return;
                              Navigator.of(context).pop();
                              if (!context.mounted) return;
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('已更新物品信息')),
                              );
                            },
                            child: const Text('保存'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    },
  );
}
