import 'dart:typed_data';

import 'package:crop_your_image/crop_your_image.dart';
import 'package:flutter/material.dart';

/// 手动裁剪页面：提供可视化 1:1 裁剪体验
class CollectibleManualCropPage extends StatefulWidget {
  const CollectibleManualCropPage({super.key, required this.imageBytes});

  final Uint8List imageBytes;

  @override
  State<CollectibleManualCropPage> createState() =>
      _CollectibleManualCropPageState();
}

class _CollectibleManualCropPageState
    extends State<CollectibleManualCropPage> {
  final CropController _controller = CropController();
  bool _isCropping = false;
  String? _errorMessage;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: _isCropping
              ? null
              : () {
                  Navigator.of(context).pop();
                },
        ),
        title: const Text('调整裁剪范围'),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: TextButton(
              onPressed: _isCropping ? null : _handleCropRequest,
              child: _isCropping
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('完成'),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                decoration: BoxDecoration(
                  color: scheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  '拖动方框可调整 1:1 裁剪范围，双指缩放可微调细节，裁剪结果将同步写入收集罐。',
                  style: TextStyle(height: 1.4),
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Crop(
                      controller: _controller,
                      image: widget.imageBytes,
                      onCropped: _handleCropResult,
                      aspectRatio: 1,
                      baseColor: Colors.black,
                      maskColor: Colors.black.withValues(alpha: 0.55),
                      progressIndicator: const Center(
                        child: CircularProgressIndicator(),
                      ),
                      interactive: true,
                      withCircleUi: false,
                    ),
                  ),
                ),
              ),
              if (_errorMessage != null) ...[
                const SizedBox(height: 12),
                Text(
                  _errorMessage!,
                  style: TextStyle(
                    color: scheme.error,
                    fontSize: 13,
                  ),
                ),
              ],
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: _isCropping ? null : _handleResetCrop,
                      icon: const Icon(Icons.refresh),
                      label: const Text('重置裁剪'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: FilledButton.icon(
                      onPressed: _isCropping ? null : _handleCropRequest,
                      icon: const Icon(Icons.check_circle_outline),
                      label: const Text('确认裁剪'),
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

  /// 触发裁剪流程，交由 CropController 统一裁剪逻辑
  void _handleCropRequest() {
    setState(() {
      _isCropping = true;
      _errorMessage = null;
    });
    _controller.crop();
  }

  /// 当裁剪完成/失败时的回调，负责返回结果或提示用户
  void _handleCropResult(CropResult result) {
    if (!mounted) {
      return;
    }
    switch (result) {
      case CropSuccess(:final croppedImage):
        Navigator.of(context).pop(croppedImage);
      case CropFailure(:final cause):
        setState(() {
          _isCropping = false;
          _errorMessage = '裁剪失败：$cause';
        });
    }
  }

  /// 重置裁剪区域，方便用户重新开始
  void _handleResetCrop() {
    _controller.image = widget.imageBytes;
    setState(() {
      _errorMessage = null;
    });
  }
}
