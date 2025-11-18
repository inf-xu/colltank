import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:permission_handler/permission_handler.dart';

import '../../../../app/providers/global_providers.dart';
import 'package:colltank/shared/providers/preferences_providers.dart';
import '../../domain/entities/collection_models.dart';
import '../widgets/manual_crop_page.dart';

/// 图片导入结果模型
class CollectibleImportResult {
  CollectibleImportResult({
    required this.relativePath,
    required this.absolutePath,
  });

  final String relativePath;
  final String absolutePath;
}

/// 负责申请权限→裁剪→落盘→写库的服务
class CollectibleImportService {
  CollectibleImportService(this.ref) : _picker = ImagePicker();

  final WidgetRef ref;
  final ImagePicker _picker;

  Future<CollectibleImportResult> importFromGallery({
    required NavigatorState navigator,
    required int collectionId,
  }) async {
    final rootDirectory = await _loadRootDirectory();
    await _ensureMediaPermission(includeCamera: false);
    final picked = await _picker.pickImage(source: ImageSource.gallery);
    if (picked == null) {
      throw const UserAbortedImportException();
    }
    final originalBytes = await picked.readAsBytes();
    final croppedBytes = await _requestManualCrop(
      navigator: navigator,
      sourceBytes: originalBytes,
    );
    final savedFile = await _persistFile(
      bytes: croppedBytes,
      rootDirectory: rootDirectory,
      collectionId: collectionId,
    );
    await _insertCollectible(
      collectionId: collectionId,
      relativePath: savedFile.relativePath,
      absolutePath: savedFile.absolutePath,
      displayName: _resolveDisplayName(picked.path),
    );
    return CollectibleImportResult(
      relativePath: savedFile.relativePath,
      absolutePath: savedFile.absolutePath,
    );
  }

  Future<CollectibleImportResult> importFromCamera({
    required NavigatorState navigator,
    required int collectionId,
  }) async {
    final rootDirectory = await _loadRootDirectory();
    await _ensureMediaPermission(includeCamera: true);
    final picked = await _picker.pickImage(source: ImageSource.camera);
    if (picked == null) {
      throw const UserAbortedImportException();
    }
    final originalBytes = await picked.readAsBytes();
    final croppedBytes = await _requestManualCrop(
      navigator: navigator,
      sourceBytes: originalBytes,
    );
    final savedFile = await _persistFile(
      bytes: croppedBytes,
      rootDirectory: rootDirectory,
      collectionId: collectionId,
    );
    await _insertCollectible(
      collectionId: collectionId,
      relativePath: savedFile.relativePath,
      absolutePath: savedFile.absolutePath,
      displayName: _resolveDisplayName(picked.path),
    );
    return CollectibleImportResult(
      relativePath: savedFile.relativePath,
      absolutePath: savedFile.absolutePath,
    );
  }

  /// 打开目录选择器并更新偏好
  Future<String?> selectRootDirectory() async {
    final selected = await FilePicker.platform.getDirectoryPath(
      dialogTitle: '请选择收集罐图片存储目录',
    );
    if (selected == null) {
      return null;
    }
    final normalized = _normalizeDocumentTreePath(selected);
    if (normalized == null) {
      throw const RootDirectoryMissingException();
    }
    final updater = ref.read(updateRootDirectoryUsecaseProvider);
    await updater.call(normalized);
    ref.invalidate(appPreferencesProvider);
    return normalized;
  }

  Future<String> _loadRootDirectory() async {
    final repository = ref.read(preferencesRepositoryProvider);
    final prefs = await repository.loadOrCreate();
    if (prefs.rootDirectory.isEmpty) {
      throw const RootDirectoryMissingException();
    }
    final directory = Directory(prefs.rootDirectory);
    if (!directory.existsSync()) {
      await directory.create(recursive: true);
    }
    return directory.path;
  }

  Future<void> _ensureMediaPermission({required bool includeCamera}) async {
    if (!Platform.isAndroid && !Platform.isIOS) {
      return;
    }
    final permissions = <Permission>{};
    if (Platform.isAndroid) {
      permissions.addAll({
        Permission.photos,
        Permission.videos,
        Permission.manageExternalStorage,
      });
      if (includeCamera) {
        permissions.add(Permission.camera);
      }
    } else if (Platform.isIOS) {
      permissions.add(Permission.photos);
      if (includeCamera) {
        permissions.add(Permission.camera);
      }
    }
    final results = await permissions.toList().request();
    final granted = results.values.any(
      (status) => status.isGranted || status.isLimited,
    );
    if (!granted) {
      throw const MediaPermissionDeniedException();
    }
  }

  Future<_SavedFile> _persistFile({
    required Uint8List bytes,
    required String rootDirectory,
    required int collectionId,
  }) async {
    final collectionDir = Directory(p.join(rootDirectory, '$collectionId'));
    if (!await collectionDir.exists()) {
      await collectionDir.create(recursive: true);
    }
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final fileName = 'collectible_$timestamp.jpg';
    final absolutePath = p.join(collectionDir.path, fileName);
    final file = File(absolutePath);
    await file.writeAsBytes(bytes, flush: true);
    final relative = '$collectionId/$fileName';
    return _SavedFile(absolutePath: absolutePath, relativePath: relative);
  }

  Future<void> _insertCollectible({
    required int collectionId,
    required String relativePath,
    required String absolutePath,
    required String displayName,
  }) async {
    final addUsecase = ref.read(addCollectibleUsecaseProvider);
    final now = DateTime.now();
    final capturedDate = DateTime(now.year, now.month, now.day);
    final file = File(absolutePath);
    final fileSize = await file.length();
    final entity = CollectibleEntity(
      collectionId: collectionId,
      relativePath: relativePath,
      thumbnailPath: relativePath,
      fileSizeBytes: fileSize,
      displayName: displayName,
      moodCodePoint: Icons.favorite.codePoint,
      moodFontFamily: Icons.favorite.fontFamily ?? 'CupertinoIcons',
      moodPackage: Icons.favorite.fontPackage,
      moodColor: '#FFEF5350',
      capturedAt: now,
      capturedDate: capturedDate,
      allowHighlight: true,
      sortWeight: now.millisecondsSinceEpoch,
      isArchived: false,
      createdAt: now,
      updatedAt: now,
      fileHash: null,
      story: null,
    );
    await addUsecase.call(entity);
  }

  Future<Uint8List> _requestManualCrop({
    required NavigatorState navigator,
    required Uint8List sourceBytes,
  }) async {
    if (!navigator.mounted) {
      throw const UserAbortedImportException();
    }
    final cropped = await navigator.push<Uint8List>(
      MaterialPageRoute(
        builder: (_) => CollectibleManualCropPage(imageBytes: sourceBytes),
        fullscreenDialog: true,
      ),
    );
    if (cropped == null) {
      throw const UserAbortedImportException();
    }
    return cropped;
  }

  String _resolveDisplayName(String path) {
    final base = p.basenameWithoutExtension(path);
    return base.isEmpty ? '新收藏' : base;
  }

  String? _normalizeDocumentTreePath(String raw) {
    if (raw.isEmpty) return null;
    const prefix = 'content://com.android.externalstorage.documents/tree/';
    if (!raw.startsWith(prefix)) {
      return raw;
    }
    final uri = Uri.parse(raw);
    if (uri.pathSegments.isEmpty) {
      return null;
    }
    final treeSegment = uri.pathSegments.last;
    final decoded = Uri.decodeComponent(treeSegment); // e.g. primary:colltank
    final parts = decoded.split(':');
    if (parts.isEmpty) {
      return null;
    }
    final volume = parts.first;
    final relative = parts.length > 1 ? parts.sublist(1).join(':') : '';
    final base = volume == 'primary'
        ? '/storage/emulated/0'
        : '/storage/$volume';
    if (relative.isEmpty) {
      return base;
    }
    final cleanRelative = Uri.decodeComponent(relative);
    return p.normalize('$base/$cleanRelative');
  }
}

class _SavedFile {
  _SavedFile({required this.absolutePath, required this.relativePath});

  final String absolutePath;
  final String relativePath;
}

class RootDirectoryMissingException implements Exception {
  const RootDirectoryMissingException();

  @override
  String toString() => '尚未设置图片根目录';
}

class MediaPermissionDeniedException implements Exception {
  const MediaPermissionDeniedException();

  @override
  String toString() => '未授予照片访问权限';
}

class UserAbortedImportException implements Exception {
  const UserAbortedImportException();

  @override
  String toString() => '用户取消导入';
}
