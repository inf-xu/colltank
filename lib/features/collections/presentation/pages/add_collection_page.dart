import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/providers/global_providers.dart';
import '../../../../core/database/app_database.dart';
import '../../../../shared/utils/color_utils.dart';
import '../../../collections/domain/entities/collection_models.dart';
import '../../../collections/domain/exceptions/collection_exceptions.dart';

class AddCollectionPage extends ConsumerStatefulWidget {
  const AddCollectionPage({super.key, this.initialCollection});

  final CollectionEntity? initialCollection;

  @override
  ConsumerState<AddCollectionPage> createState() => _AddCollectionPageState();
}

class _AddCollectionPageState extends ConsumerState<AddCollectionPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descController = TextEditingController();
  late String _selectedColor;
  String? _customColorHex;
  bool _isSaving = false;
  bool _isDeleting = false;
  CollectionEntity? _editing;

  static const List<String> _colorOptions = [
    '#FFA726',
    '#FF7043',
    '#26C6DA',
    '#AB47BC',
    '#66BB6A',
    '#8D6E63',
  ];

  bool get _isEdit => _editing != null;

  @override
  void initState() {
    super.initState();
    _editing = widget.initialCollection;
    _selectedColor = _editing?.accentColor ?? _colorOptions.first;
    if (!_colorOptions.contains(_selectedColor)) {
      _customColorHex = _selectedColor;
    }
    _nameController.text = _editing?.name ?? '';
    _descController.text = _editing?.description ?? '';
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descController.dispose();
    super.dispose();
  }

  Future<void> _handleSubmit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isSaving = true);
    final trimmedName = _nameController.text.trim();
    final trimmedDesc = _descController.text.trim();
    final descriptionValue = trimmedDesc.isEmpty ? null : trimmedDesc;
    final now = DateTime.now();
    try {
      if (_isEdit) {
        final updated = _editing!.copyWith(
          name: trimmedName,
          description: descriptionValue,
          accentColor: _selectedColor,
          updatedAt: now,
        );
        final usecase = ref.read(updateCollectionUsecaseProvider);
        await usecase.call(updated);
      } else {
        final frameStyleId = await _ensureDefaultFrameStyle(ref);
        final entity = CollectionEntity(
          name: trimmedName,
          description: descriptionValue,
          sortIndex: now.millisecondsSinceEpoch,
          frameStyleId: frameStyleId,
          accentColor: _selectedColor,
          createdAt: now,
          updatedAt: now,
        );
        final usecase = ref.read(createCollectionUsecaseProvider);
        await usecase.call(entity);
      }
      if (!mounted) return;
      Navigator.of(context).pop(true);
    } on CollectionNameExistsException catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('“${error.name}” 已存在，请更换名称')));
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${_isEdit ? '更新' : '创建'}失败：$error')),
      );
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
  }

  Future<void> _handleDelete() async {
    if (!_isEdit || _editing == null || _isDeleting) return;
    final confirmed =
        await showDialog<bool>(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('删除收集罐'),
              content: Text('确定要删除“${_editing!.name}”吗？该操作无法撤销。'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text('取消'),
                ),
                FilledButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: const Text('删除'),
                ),
              ],
            );
          },
        ) ??
        false;
    if (!mounted) return;
    if (!confirmed) return;
    final targetId = _editing!.id;
    if (targetId == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('当前收集罐缺少 ID，无法删除')));
      return;
    }
    setState(() => _isDeleting = true);
    try {
      final usecase = ref.read(deleteCollectionUsecaseProvider);
      await usecase.call(targetId);
      if (!mounted) return;
      Navigator.of(context).pop(true);
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('删除失败：$error')));
    } finally {
      if (mounted) {
        setState(() => _isDeleting = false);
      }
    }
  }

  Widget _buildColorOption(String hex) {
    final theme = Theme.of(context);
    final color = parseHexColor(hex);
    final selected = _selectedColor == hex;
    return GestureDetector(
      onTap: () => setState(() => _selectedColor = hex),
      child: AnimatedScale(
        duration: const Duration(milliseconds: 160),
        scale: selected ? 1.1 : 1,
        child: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            border: Border.all(
              color: selected
                  ? theme.colorScheme.onPrimary
                  : Colors.transparent,
              width: 3,
            ),
            boxShadow: [
              BoxShadow(
                color: color.withValues(alpha: selected ? 0.45 : 0.2),
                blurRadius: selected ? 14 : 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: selected
              ? const Icon(Icons.check, color: Colors.white, size: 20)
              : null,
        ),
      ),
    );
  }

  Widget _buildCustomColorButton(ThemeData theme) {
    final customColor = _customColorHex != null
        ? parseHexColor(_customColorHex!)
        : null;
    final selected = customColor != null && _selectedColor == _customColorHex;
    return GestureDetector(
      onTap: _openCustomColorPicker,
      child: AnimatedScale(
        duration: const Duration(milliseconds: 160),
        scale: selected ? 1.05 : 1,
        child: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: customColor ?? theme.colorScheme.surfaceContainerHighest,
            border: Border.all(
              color: selected
                  ? theme.colorScheme.primary
                  : theme.colorScheme.outlineVariant,
              width: 2,
            ),
          ),
          child: Icon(
            Icons.colorize,
            color: selected
                ? theme.colorScheme.primary
                : theme.colorScheme.onSurfaceVariant,
            size: 22,
          ),
        ),
      ),
    );
  }

  Future<void> _openCustomColorPicker() async {
    final picked = await _showCustomColorPicker(
      _customColorHex ?? _selectedColor,
    );
    if (picked == null) return;
    setState(() {
      _customColorHex = picked;
      _selectedColor = picked;
    });
  }

  Future<String?> _showCustomColorPicker(String initialHex) async {
    var hsvColor = HSVColor.fromColor(parseHexColor(initialHex));
    return showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('自定义颜色'),
          content: StatefulBuilder(
            builder: (context, setStateDialog) {
              final previewColor = hsvColor.toColor();
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: double.infinity,
                    height: 48,
                    decoration: BoxDecoration(
                      color: previewColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildColorSlider(
                    label: '色相',
                    valueLabel: '${hsvColor.hue.toStringAsFixed(0)}°',
                    value: hsvColor.hue,
                    min: 0,
                    max: 360,
                    onChanged: (value) => setStateDialog(
                      () => hsvColor = hsvColor.withHue(value),
                    ),
                  ),
                  _buildColorSlider(
                    label: '饱和度',
                    valueLabel: '${(hsvColor.saturation * 100).round()}%',
                    value: hsvColor.saturation,
                    min: 0,
                    max: 1,
                    onChanged: (value) => setStateDialog(
                      () => hsvColor = hsvColor.withSaturation(value),
                    ),
                  ),
                  _buildColorSlider(
                    label: '明度',
                    valueLabel: '${(hsvColor.value * 100).round()}%',
                    value: hsvColor.value,
                    min: 0,
                    max: 1,
                    onChanged: (value) => setStateDialog(
                      () => hsvColor = hsvColor.withValue(value),
                    ),
                  ),
                ],
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('取消'),
            ),
            FilledButton(
              onPressed: () =>
                  Navigator.of(context).pop(_colorToHex(hsvColor.toColor())),
              child: const Text('应用'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildColorSlider({
    required String label,
    required double value,
    required double min,
    required double max,
    required ValueChanged<double> onChanged,
    String? valueLabel,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text(label), Text(valueLabel ?? value.toStringAsFixed(0))],
        ),
        Slider(value: value, min: min, max: max, onChanged: onChanged),
      ],
    );
  }

  String _colorToHex(Color color) {
    final argb = color.toARGB32();
    final rgb = (argb & 0x00FFFFFF).toRadixString(16).padLeft(6, '0');
    return '#${rgb.toUpperCase()}';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorPalette = <String>[
      ..._colorOptions,
      if (_customColorHex != null && !_colorOptions.contains(_customColorHex))
        _customColorHex!,
      if (!_colorOptions.contains(_selectedColor)) _selectedColor,
    ];
    final orderedPalette = colorPalette.toSet().toList();
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEdit ? '更新收集罐' : '新建收集罐'),
        centerTitle: true,
        actions: [
          if (_isEdit)
            IconButton(
              onPressed: _isDeleting ? null : _handleDelete,
              icon: _isDeleting
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.delete_outline),
            ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                Center(
                  child: Tooltip(
                    message: _isEdit ? '当前为编辑模式' : '下方添加收集罐信息',
                    child: CircleAvatar(
                      radius: 36,
                      backgroundColor: Colors.amber.withValues(alpha: 0.2),
                      child: Icon(
                        _isEdit ? Icons.edit : Icons.add,
                        color: Colors.amber,
                        size: 32,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: '类别名称（限制20字）',
                    border: OutlineInputBorder(),
                    floatingLabelAlignment: FloatingLabelAlignment.start,
                    alignLabelWithHint: true,
                  ),
                  readOnly: _isEdit,
                  enabled: !_isEdit,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return '请输入类别名称';
                    }
                    if (value.characters.length > 20) {
                      return '名称不应超过20个字符';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _descController,
                  decoration: const InputDecoration(
                    labelText: '描述（可选，限制80字）',
                    border: OutlineInputBorder(),
                    floatingLabelAlignment: FloatingLabelAlignment.start,
                    alignLabelWithHint: true,
                  ),
                  minLines: 3,
                  maxLines: 5,
                  inputFormatters: [
                    const _MaxLinesInputFormatter(4),
                    LengthLimitingTextInputFormatter(80),
                  ],
                  validator: (value) {
                    final text = value?.trim() ?? '';
                    if (text.length > 80) {
                      return '描述不应超过80个字';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('卡片主题颜色', style: theme.textTheme.titleMedium),
                    Text('（尽量选择深色系）', style: theme.textTheme.titleSmall?.copyWith(color: Colors.grey))
                  ],
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    ...orderedPalette.map((hex) => _buildColorOption(hex)),
                    _buildCustomColorButton(theme),
                  ],
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    onPressed: _isSaving ? null : _handleSubmit,
                    child: _isSaving
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : Text(_isEdit ? '更新' : '保存', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<int> _ensureDefaultFrameStyle(WidgetRef ref) async {
    final db = ref.read(appDatabaseProvider);
    final existing = await (db.select(
      db.frameStyles,
    )..limit(1)).getSingleOrNull();
    if (existing != null) return existing.id;
    return db
        .into(db.frameStyles)
        .insert(
          FrameStylesCompanion.insert(
            name: '默认画框',
            assetPath: 'assets/frame/default.png',
            gridLineColor: const Value('#FFFFFFFF'),
            backgroundColor: const Value('#FF101010'),
          ),
        );
  }
}

/// 限制多行文本的行数，以防描述超过设计高度
class _MaxLinesInputFormatter extends TextInputFormatter {
  const _MaxLinesInputFormatter(this.maxLines);

  final int maxLines;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final lines = '\n'.allMatches(newValue.text).length + 1;
    if (lines > maxLines) {
      return oldValue;
    }
    return newValue;
  }
}
