import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gal/gal.dart';
import 'package:path/path.dart' as p;

import '../../../../app/providers/global_providers.dart';

/// 拼贴导出服务：负责相册写入 + Drift 记录
class CollageExportService {
  CollageExportService(this.ref);

  final WidgetRef ref;

  Future<CollageExportResult> saveToGallery({
    required int collectionId,
    required Uint8List bytes,
    required int width,
    required int height,
  }) async {
    final access = await Gal.hasAccess();
    final granted = access || await Gal.requestAccess();
    if (!granted) {
      throw const CollageExportException('请在系统设置授予照片写入权限');
    }
    final fileName = _buildFileName(collectionId);
    await Gal.putImageBytes(
      bytes,
      name: fileName.replaceAll('.png', ''),
      album: 'CollTank',
    );
    final pseudoPath = p.join('gallery', fileName);
    final logUsecase = ref.read(logExportUsecaseProvider);
    await logUsecase(
      collectionId: collectionId,
      exportPath: pseudoPath,
      fileName: fileName,
      directory: 'gallery',
      resolutionPx: '${width}x$height',
      fileSizeBytes: bytes.length,
    );
    return CollageExportResult(filePath: pseudoPath, fileName: fileName);
  }

  String _buildFileName(int collectionId) {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    return 'colltank_${collectionId}_$timestamp.png';
  }
}

class CollageExportResult {
  CollageExportResult({required this.filePath, required this.fileName});

  final String filePath;
  final String fileName;
}

class CollageExportException implements Exception {
  const CollageExportException(this.message);

  final String message;

  @override
  String toString() => message;
}
