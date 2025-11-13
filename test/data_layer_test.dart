import 'dart:ffi';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod/riverpod.dart';
import 'package:sqlite3/open.dart' as sqlite_open;

import 'package:colltank/core/database/app_database.dart';
import 'package:colltank/features/collections/domain/entities/collection_models.dart';
import 'package:colltank/features/collections/providers/collection_providers.dart';

void main() {
  setUpAll(() async {
    if (Platform.isLinux) {
      sqlite_open.open.overrideForAll(
        () => DynamicLibrary.open('libsqlite3.so.0'),
      );
    }
  });
  group('Drift 数据表验证', () {
    late AppDatabase database;

    setUp(() {
      database = AppDatabase.memory();
    });

    tearDown(() async {
      await database.close();
    });

    test('collections 与 collectibles 读写成功', () async {
      final now = DateTime(2024, 1, 1, 12);
      final collection = CollectionEntity(
        name: '相机收藏',
        description: '记录胶片机与镜头',
        sortIndex: 1,
        frameStyleId: 1,
        accentColor: '#FFA726',
        createdAt: now,
        updatedAt: now,
      );

      final collectionId =
          await database.collectionsDao.insertCollection(collection.toCompanion());

      final collectible = CollectibleEntity(
        collectionId: collectionId,
        relativePath: '$collectionId/1.jpg',
        thumbnailPath: null,
        fileHash: 'hash',
        fileSizeBytes: 2048,
        displayName: 'Leica M6',
        story: '第一台胶片机',
        moodCodePoint: 0xf3f7,
        moodFontFamily: 'CupertinoIcons',
        moodPackage: null,
        moodColor: '#FFAA00',
        capturedAt: now,
        capturedDate: DateTime(2024, 1, 1),
        allowHighlight: true,
        sortWeight: 0,
        isArchived: false,
        createdAt: now,
        updatedAt: now,
      );

      await database.collectiblesDao.insertCollectible(collectible.toCompanion());

      final rows =
          await database.collectionsDao.fetchCollectionRowsWithCount();

      expect(rows, hasLength(1));
      expect(rows.first.row.name, '相机收藏');
      expect(rows.first.itemCount, 1);
    });
  });

  group('Riverpod 状态管理', () {
    test('CollectionListController 能够写入并读取状态', () async {
      final testDb = AppDatabase.memory();
      final container = ProviderContainer(
        overrides: [
          appDatabaseProvider.overrideWithValue(testDb),
        ],
      );

      addTearDown(() async {
        await testDb.close();
        container.dispose();
      });

      final notifier =
          container.read(collectionListControllerProvider.notifier);
      final now = DateTime(2024, 2, 10);
      final collection = CollectionEntity(
        name: '旅行明信片',
        description: '记录世界各地的明信片',
        sortIndex: 0,
        frameStyleId: 1,
        accentColor: '#FF7043',
        createdAt: now,
        updatedAt: now,
      );

      await notifier.saveCollection(collection);

      final list = await container.read(collectionListControllerProvider.future);
      expect(list, hasLength(1));
      expect(list.first.name, '旅行明信片');
    });
  });
}
