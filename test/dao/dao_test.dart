import 'dart:ffi';
import 'dart:io';

import 'package:async/async.dart';
import 'package:drift/drift.dart' show Value;
import 'package:flutter_test/flutter_test.dart';
import 'package:sqlite3/open.dart' as sqlite_open;

import 'package:colltank/core/database/app_database.dart';

void main() {
  setUpAll(() {
    if (Platform.isLinux) {
      sqlite_open.open.overrideForAll(
        () => DynamicLibrary.open('libsqlite3.so.0'),
      );
    }
  });

  late AppDatabase database;
  late int frameStyleId;

  setUp(() async {
    database = AppDatabase.memory();
    frameStyleId = await _insertFrameStyle(database);
  });

  tearDown(() async {
    await database.close();
  });

  group('CollectionsDao', () {
    test('fetchCollectionRowsWithCount 聚合物品数量并支持排序', () async {
      final collectionId =
          await _insertCollection(database, frameStyleId, '旅行集');
      await database.collectiblesDao.insertCollectible(
        _collectibleCompanion(collectionId, '相机'),
      );

      final rows = await database.collectionsDao.fetchCollectionRowsWithCount();
      expect(rows, hasLength(1));
      expect(rows.first.row.name, '旅行集');
      expect(rows.first.itemCount, 1);

      final anotherId =
          await _insertCollection(database, frameStyleId, '日历集');
      await database.collectionsDao
          .reorderCollections([anotherId, collectionId]);
      final ordered = await database.collectionsDao.allCollectionsRaw();
      expect(ordered.first.id, anotherId);
    });

    test('updateFrameStyle 与 updateCoverPreview 生效', () async {
      final collectionId =
          await _insertCollection(database, frameStyleId, '画框集');
      await database.collectionsDao.updateFrameStyle(
        collectionId: collectionId,
        frameStyleId: frameStyleId,
      );
      await database.collectionsDao.updateCoverPreview(
        collectionId: collectionId,
        previewPath: '/tmp/preview.png',
      );
      final updated = await database.collectionsDao.findById(collectionId);
      expect(updated?.frameStyleId, frameStyleId);
      expect(updated?.coverPreviewPath, '/tmp/preview.png');
    });
  });

  group('CollectiblesDao', () {
    test('paginateByCollection 过滤 allowHighlight、归档状态', () async {
      final collectionId =
          await _insertCollection(database, frameStyleId, '收藏');
      final created = DateTime(2024, 3, 10, 10);
      await database.collectiblesDao.insertMany([
        _collectibleCompanion(collectionId, '可展示',
            allowHighlight: true, sortWeight: 5, capturedAt: created),
        _collectibleCompanion(collectionId, '隐藏',
            allowHighlight: false, isArchived: true, sortWeight: 1),
      ]);

      final highlightOnly = await database.collectiblesDao.paginateByCollection(
        collectionId: collectionId,
        allowHighlight: true,
      );
      expect(highlightOnly, hasLength(1));
      expect(highlightOnly.first.displayName, '可展示');

      final archived = await database.collectiblesDao.paginateByCollection(
        collectionId: collectionId,
        isArchived: true,
      );
      expect(archived.single.isArchived, isTrue);
    });

    test('update helpers 正确写入字段', () async {
      final collectionId =
          await _insertCollection(database, frameStyleId, '收藏2');
      final id = await database.collectiblesDao
          .insertCollectible(_collectibleCompanion(collectionId, '相片'));

      await database.collectiblesDao.updateAllowHighlight(id, false);
      await database.collectiblesDao.updateSortWeight(id: id, sortWeight: 99);
      await database.collectiblesDao.updateThumbnailPath(id, '/thumb.png');

      final rows = await database.collectiblesDao.listByCollection(collectionId);
      expect(rows.single.allowHighlight, isFalse);
      expect(rows.single.sortWeight, 99);
      expect(rows.single.thumbnailPath, '/thumb.png');
    });
  });

  group('HighlightSlotsDao', () {
    test('resetSlots 初始化九宫格并可 watch', () async {
      final collectionId =
          await _insertCollection(database, frameStyleId, '画框');
      await database.highlightSlotsDao.resetSlots(collectionId);

      final queue =
          StreamQueue(database.highlightSlotsDao.watchSlots(collectionId));
      final initial = await queue.next;
      expect(initial, hasLength(9));
      expect(initial.first.slotIndex, 0);

      await database.highlightSlotsDao.upsertSlot(
        collectionId: collectionId,
        slotIndex: 0,
        collectibleId: 1,
        isLocked: true,
      );
      final updated = await queue.next;
      await queue.cancel();
      expect(updated.first.collectibleId, 1);
      expect(updated.first.isLocked, isTrue);
    });
  });

  group('MetricsDao', () {
    test('incrementDailyMetric 新增并累加指标', () async {
      final collectionId =
          await _insertCollection(database, frameStyleId, '指标集');
      final metricsDao = database.metricsDao;
      final statDate = DateTime(2024, 1, 15, 9);

      await metricsDao.incrementDailyMetric(
        collectionId: collectionId,
        statDate: statDate,
        deltaCount: 1,
        firstCollectibleId: 1,
        lastCollectibleId: 1,
      );
      await metricsDao.incrementDailyMetric(
        collectionId: collectionId,
        statDate: statDate,
        deltaCount: 2,
        lastCollectibleId: 2,
      );

      final rows =
          await metricsDao.metricsForYear(collectionId: collectionId, year: 2024);
      expect(rows.single.itemCount, 3);
      expect(rows.single.lastCollectibleId, 2);
    });

    test('upsertStorageSnapshot 与 latestSnapshots', () async {
      final collectionId =
          await _insertCollection(database, frameStyleId, '指标集2');
      final metricsDao = database.metricsDao;
      await metricsDao.upsertStorageSnapshot(
        collectionId: collectionId,
        totalBytes: 4096,
        thumbnailBytes: 512,
        itemsCount: 5,
        computedAt: DateTime(2024, 1, 1, 12),
      );
      await metricsDao.upsertStorageSnapshot(
        collectionId: collectionId,
        totalBytes: 8192,
        thumbnailBytes: 1024,
        itemsCount: 8,
        computedAt: DateTime(2024, 1, 2, 12),
      );

      final snapshots =
          await metricsDao.latestSnapshots(collectionId: collectionId, limit: 1);
      expect(snapshots.single.totalBytes, 8192);
      expect(snapshots.single.itemsCount, 8);
    });
  });

  group('ExportLogsDao', () {
    test('latestForCollection 返回最新记录', () async {
      final collectionId =
          await _insertCollection(database, frameStyleId, '导出集');
      await database.exportLogsDao.insertLog(
        ExportLogsCompanion.insert(
          collectionId: collectionId,
          exportPath: '/export/1.png',
          fileName: '1.png',
          resolutionPx: const Value('1024x1024'),
          fileSizeBytes: const Value(2048),
          createdAt: Value(DateTime(2024, 1, 1, 10)),
        ),
      );
      await database.exportLogsDao.insertLog(
        ExportLogsCompanion.insert(
          collectionId: collectionId,
          exportPath: '/export/2.png',
          fileName: '2.png',
          resolutionPx: const Value('2048x2048'),
          fileSizeBytes: const Value(4096),
          createdAt: Value(DateTime(2024, 1, 1, 12)),
        ),
      );

      final latest =
          await database.exportLogsDao.latestForCollection(collectionId);
      expect(latest?.fileName, '2.png');
      expect(latest?.fileSizeBytes, 4096);
    });
  });

  group('PreferencesDao', () {
    test('loadOrCreate 仅保留单行并可更新', () async {
      final prefs = await database.preferencesDao.loadOrCreate();
      expect(prefs.rootDirectory, isEmpty);

      await database.preferencesDao.updateRootDirectory('/tmp/storage');
      await database.preferencesDao.updateImportMode('move');
      await database.preferencesDao.updateLastExportDir('/tmp/export');

      final updated = await database.preferencesDao.loadOrCreate();
      expect(updated.rootDirectory, '/tmp/storage');
      expect(updated.importMode, 'move');
      expect(updated.lastExportDir, '/tmp/export');
    });
  });
}

Future<int> _insertFrameStyle(AppDatabase database) {
  return database.into(database.frameStyles).insert(
        FrameStylesCompanion.insert(
          name: '默认画框',
          assetPath: 'assets/frame/default.png',
        ),
      );
}

Future<int> _insertCollection(
  AppDatabase database,
  int frameStyleId,
  String name,
) {
  return database.collectionsDao.insertCollection(
    CollectionsCompanion.insert(
      name: name,
      frameStyleId: frameStyleId,
    ),
  );
}

CollectiblesCompanion _collectibleCompanion(
  int collectionId,
  String name, {
  bool allowHighlight = true,
  bool isArchived = false,
  int sortWeight = 0,
  DateTime? capturedAt,
}) {
  final captured = capturedAt ?? DateTime(2024, 1, 1, 10);
  return CollectiblesCompanion.insert(
    collectionId: collectionId,
    relativePath: '$collectionId/$name.png',
    fileSizeBytes: Value(2048),
    displayName: name,
    moodCodePoint: Value(0xf3f7),
    moodFontFamily: Value('CupertinoIcons'),
    moodColor: Value('#FFAA00'),
    capturedAt: captured,
    capturedDate: DateTime(captured.year, captured.month, captured.day),
    allowHighlight: Value(allowHighlight),
    sortWeight: Value(sortWeight),
    isArchived: Value(isArchived),
  );
}
