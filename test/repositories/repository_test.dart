import 'dart:ffi';
import 'dart:io';

import 'package:async/async.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqlite3/open.dart' as sqlite_open;

import 'package:colltank/core/database/app_database.dart';
import 'package:colltank/features/collections/data/repositories/collections/collections_repository.dart';
import 'package:colltank/features/collections/data/repositories/collectibles/collectibles_repository.dart';
import 'package:colltank/features/collections/data/repositories/export/export_logs_repository.dart';
import 'package:colltank/features/collections/data/repositories/highlight_slots/highlight_slots_repository.dart';
import 'package:colltank/features/collections/data/repositories/metrics/metrics_repository.dart';
import 'package:colltank/features/collections/domain/entities/collection_models.dart';
import 'package:colltank/features/settings/data/repositories/preferences/preferences_repository.dart';

void main() {
  setUpAll(() {
    if (Platform.isLinux) {
      sqlite_open.open.overrideForAll(
        () => DynamicLibrary.open('libsqlite3.so.0'),
      );
    }
  });

  late AppDatabase database;
  late CollectionsRepository collectionsRepository;
  late CollectiblesRepository collectiblesRepository;
  late HighlightSlotsRepository highlightSlotsRepository;
  late MetricsRepository metricsRepository;
  late ExportLogsRepository exportLogsRepository;
  late PreferencesRepository preferencesRepository;
  late int frameStyleId;

  setUp(() async {
    database = AppDatabase.memory();
    collectionsRepository = CollectionsRepository(database.collectionsDao);
    collectiblesRepository = CollectiblesRepository(database.collectiblesDao);
    highlightSlotsRepository =
        HighlightSlotsRepository(database.highlightSlotsDao);
    metricsRepository = MetricsRepository(database.metricsDao);
    exportLogsRepository = ExportLogsRepository(database.exportLogsDao);
    preferencesRepository = PreferencesRepository(database.preferencesDao);
    frameStyleId = await _insertFrameStyle(database);
  });

  tearDown(() async {
    await database.close();
  });

  group('CollectionsRepository', () {
    test('fetch & watch collections with count', () async {
      final collection = _buildCollection('旅行集', frameStyleId);
      await collectionsRepository.createCollection(collection);
      await collectiblesRepository.insertCollectible(
        _buildCollectible(
          collectionId: 1,
          name: '相机',
        ),
      );

      final summary = await collectionsRepository.fetchCollectionsWithCount();
      expect(summary.single.itemCount, 1);

      final queue =
          StreamQueue(collectionsRepository.watchCollectionsWithCount());
      final initial = await queue.next;
      expect(initial, isNotEmpty);

      await collectionsRepository
          .createCollection(_buildCollection('日历集', frameStyleId));
      final updated = await queue.next;
      await queue.cancel();
      expect(updated.length, 2);
    });
  });

  group('CollectiblesRepository', () {
    test('paginate and watch collectibles', () async {
      final collectionId =
          await collectionsRepository.createCollection(_buildCollection(
        '收藏夹',
        frameStyleId,
      ));
      await collectiblesRepository.insertMany([
        _buildCollectible(
          collectionId: collectionId,
          name: '展示',
          sortWeight: 10,
          allowHighlight: true,
        ),
        _buildCollectible(
          collectionId: collectionId,
          name: '隐藏',
          sortWeight: 1,
          allowHighlight: false,
          isArchived: true,
        ),
      ]);

      final highlightOnly = await collectiblesRepository.paginateByCollection(
        collectionId: collectionId,
        allowHighlight: true,
      );
      expect(highlightOnly.single.displayName, '展示');

      final queue =
          StreamQueue(collectiblesRepository.watchByCollection(collectionId));
      final watchInitial = await queue.next;
      expect(watchInitial.length, 2);

      await collectiblesRepository.updateAllowHighlight(
        highlightOnly.single.id!,
        false,
      );
      final watchUpdated = await queue.next;
      await queue.cancel();
      expect(watchUpdated.first.allowHighlight, isFalse);
    });
  });

  group('HighlightSlotsRepository', () {
    test('reset and watch slots', () async {
      final collectionId =
          await collectionsRepository.createCollection(_buildCollection(
        '画框',
        frameStyleId,
      ));
      await highlightSlotsRepository.resetSlots(collectionId);

      final queue =
          StreamQueue(highlightSlotsRepository.watchSlots(collectionId));
      final initial = await queue.next;
      expect(initial, hasLength(9));

      await highlightSlotsRepository.upsertSlot(
        collectionId: collectionId,
        slotIndex: 0,
        collectibleId: 1,
        isLocked: true,
      );
      final next = await queue.next;
      await queue.cancel();
      expect(next.first.collectibleId, 1);
      expect(next.first.isLocked, isTrue);
    });
  });

  group('MetricsRepository', () {
    test('increment metrics and snapshots', () async {
      final collectionId =
          await collectionsRepository.createCollection(_buildCollection(
        '指标集',
        frameStyleId,
      ));
      final statDate = DateTime(2024, 2, 1, 9);
      await metricsRepository.incrementDailyMetric(
        collectionId: collectionId,
        statDate: statDate,
        firstCollectibleId: 1,
      );
      await metricsRepository.incrementDailyMetric(
        collectionId: collectionId,
        statDate: statDate,
        deltaCount: 2,
        lastCollectibleId: 3,
      );

      final rows = await metricsRepository.metricsForYear(
        collectionId: collectionId,
        year: 2024,
      );
      expect(rows.single.itemCount, 3);

      await metricsRepository.upsertStorageSnapshot(
        collectionId: collectionId,
        totalBytes: 4096,
        thumbnailBytes: 512,
        itemsCount: 5,
        computedAt: DateTime(2024, 2, 2),
      );

      final snapshots = await metricsRepository.latestSnapshots(
        collectionId: collectionId,
        limit: 1,
      );
      expect(snapshots.single.itemsCount, 5);
    });
  });

  group('ExportLogsRepository', () {
    test('logExport + latestForCollection', () async {
      final collectionId =
          await collectionsRepository.createCollection(_buildCollection(
        '导出集',
        frameStyleId,
      ));

      await exportLogsRepository.logExport(
        collectionId: collectionId,
        exportPath: '/tmp/1.png',
        fileName: '1.png',
        createdAt: DateTime(2024, 1, 1, 10),
      );
      await exportLogsRepository.logExport(
        collectionId: collectionId,
        exportPath: '/tmp/2.png',
        fileName: '2.png',
        createdAt: DateTime(2024, 1, 1, 12),
      );

      final latest =
          await exportLogsRepository.latestForCollection(collectionId);
      expect(latest?.fileName, '2.png');
    });
  });

  group('PreferencesRepository', () {
    test('loadOrCreate & update fields', () async {
      final prefs = await preferencesRepository.loadOrCreate();
      expect(prefs.rootDirectory, isEmpty);

      await preferencesRepository.updateRootDirectory('/tmp/storage');
      await preferencesRepository.updateImportMode('move');
      await preferencesRepository.updateLastExportDir('/tmp/export');

      final updated = await preferencesRepository.loadOrCreate();
      expect(updated.rootDirectory, '/tmp/storage');
      expect(updated.importMode, 'move');
      expect(updated.lastExportDir, '/tmp/export');
    });
  });
}

CollectionEntity _buildCollection(String name, int frameStyleId) {
  final now = DateTime(2024, 1, 1, 12);
  return CollectionEntity(
    name: name,
    description: '描述 $name',
    sortIndex: 0,
    frameStyleId: frameStyleId,
    accentColor: '#FFA726',
    createdAt: now,
    updatedAt: now,
  );
}

CollectibleEntity _buildCollectible({
  required int collectionId,
  required String name,
  bool allowHighlight = true,
  bool isArchived = false,
  int sortWeight = 0,
  DateTime? capturedAt,
}) {
  final captured = capturedAt ?? DateTime(2024, 1, 1, 10);
  return CollectibleEntity(
    collectionId: collectionId,
    relativePath: '$collectionId/$name.png',
    thumbnailPath: null,
    fileHash: null,
    fileSizeBytes: 2048,
    displayName: name,
    story: null,
    moodCodePoint: 0xf3f7,
    moodFontFamily: 'CupertinoIcons',
    moodPackage: null,
    moodColor: '#FFAA00',
    capturedAt: captured,
    capturedDate: DateTime(captured.year, captured.month, captured.day),
    allowHighlight: allowHighlight,
    sortWeight: sortWeight,
    isArchived: isArchived,
    createdAt: captured,
    updatedAt: captured,
  );
}

Future<int> _insertFrameStyle(AppDatabase database) {
  return database.into(database.frameStyles).insert(
        FrameStylesCompanion.insert(
          name: '默认画框',
          assetPath: 'assets/frame/default.png',
        ),
      );
}
