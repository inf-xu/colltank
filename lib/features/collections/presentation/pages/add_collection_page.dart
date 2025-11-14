import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
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
  bool _isSaving = false;
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
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('“${error.name}” 已存在，请更换名称')),
      );
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${_isEdit ? '更新' : '创建'}失败：$error'),
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorPalette = {
      _selectedColor,
      ..._colorOptions,
    }.toList();
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEdit ? '更新收集罐' : '新建收集罐'),
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
                const SizedBox(height: 24),
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: '类别名称',
                    border: OutlineInputBorder(),
                  ),
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
                    labelText: '描述（可选）',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                ),
                const SizedBox(height: 24),
                Text(
                  '卡片主题颜色',
                  style: theme.textTheme.titleSmall,
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: colorPalette.map((hex) {
                    final color = parseHexColor(hex);
                    final selected = _selectedColor == hex;
                    return GestureDetector(
                      onTap: () => setState(() => _selectedColor = hex),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: color,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: selected ? Colors.white : Colors.transparent,
                            width: 3,
                          ),
                          boxShadow: [
                            if (selected)
                              BoxShadow(
                                color: color.withValues(alpha: 0.4),
                                blurRadius: 12,
                              ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isSaving ? null : _handleSubmit,
                    child: _isSaving
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : Text(_isEdit ? '更新' : '保存'),
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
    final existing =
        await (db.select(db.frameStyles)..limit(1)).getSingleOrNull();
    if (existing != null) return existing.id;
    return db.into(db.frameStyles).insert(
          FrameStylesCompanion.insert(
            name: '默认画框',
            assetPath: 'assets/frame/default.png',
            gridLineColor: const Value('#FFFFFFFF'),
            backgroundColor: const Value('#FF101010'),
          ),
        );
  }
}
