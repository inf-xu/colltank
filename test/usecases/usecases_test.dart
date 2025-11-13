import 'dart:ffi';
import 'dart:io';

import 'package:async/async.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqlite3/open.dart' as sqlite_open;

import 'package:colltank/core/database/app_database.dart';
import 'package:colltank/features/collections/data/repositories/collections/collections_repository.dart';
import 'package:colltank/features/collections/data/repositories/collectibles/collectibles_repository.dart';
import 'package:colltank/features/collections/data/repositories/highlight_slots/highlight_slots_repository.dart';
import 'package:colltank/features/collections/data/repositories/metrics/metrics_repository.dart';
import 'package:colltank/features/collections/data/repositories/export/export_logs_repository.dart';
import 'package:colltank/features/collections/domain/entities/collection_models.dart';
import 'package:colltank/features/collections/domain/usecases/collections/create_collection_usecase.dart';
import 'package:colltank/features/collections/domain/usecases/collections/delete_collection_usecase.dart';
import 'package:colltank/features/collections/domain/usecases/collections/reorder_collections_usecase.dart';
import 'package:colltank/features/collections/domain/usecases/collections/switch_frame_style_usecase.dart';
import 'package:colltank/features/collections/domain/usecases/collections/update_cover_preview_usecase.dart';
import 'package:colltank/features/collections/domain/usecases/collectibles/add_collectible_usecase.dart';
import 'package:colltank/features/collections/domain/usecases/collectibles/toggle_collectible_highlight_usecase.dart';
import 'package:colltank/features/collections/domain/usecases/highlight_slots/assign_highlight_slot_usecase.dart';
import 'package:colltank/features/collections/domain/usecases/highlight_slots/reset_highlight_slots_usecase.dart';
import 'package:colltank/features/collections/domain/usecases/export/log_export_usecase.dart';
import 'package:colltank/features/settings/data/repositories/preferences/preferences_repository.dart';
import 'package:colltank/features/settings/domain/usecases/preferences/update_import_mode_usecase.dart';
import 'package:colltank/features/settings/domain/usecases/preferences/update_root_directory_usecase.dart';

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

  late CollectionsRepository collectionsRepository;
  late CollectiblesRepository collectiblesRepository;
  late HighlightSlotsRepository highlightSlotsRepository;
  late MetricsRepository metricsRepository;
  late ExportLogsRepository exportLogsRepository;
  late PreferencesRepository preferencesRepository;

  setUp(() async {
    database = AppDatabase.memory();
    frameStyleId = await _insertFrameStyle(database);
    collectionsRepository = CollectionsRepository(database.collectionsDao);
    collectiblesRepository = CollectiblesRepository(database.collectiblesDao);
    highlightSlotsRepository =
        HighlightSlotsRepository(database.highlightSlotsDao);
    metricsRepository = MetricsRepository(database.metricsDao);
    exportLogsRepository = ExportLogsRepository(database.exportLogsDao);
    preferencesRepository = PreferencesRepository(database.preferencesDao);
  });

  tearDown(() async {
    await database.close();
  });

  group('Collections usecases', () {
    test('create collection initializes highlight slots', () async {
      final usecase = CreateCollectionUsecase(
        collectionsRepository,
        highlightSlotsRepository,
      );
      final id = await usecase.call(_collection('旅行', frameStyleId));
      final slots = await highlightSlotsRepository.listSlots(id);
      expect(slots, hasLength(9));
    });

    test('delete + reorder + switch style + cover preview', () async {
      final create = CreateCollectionUsecase(
        collectionsRepository,
        highlightSlotsRepository,
      );
      final delete = DeleteCollectionUsecase(collectionsRepository);
      final reorder = ReorderCollectionsUsecase(collectionsRepository);
      final switchStyle = SwitchFrameStyleUsecase(collectionsRepository);
      final updateCover =
          UpdateCoverPreviewUsecase(collectionsRepository);

      final id1 = await create.call(_collection('A', frameStyleId));
      final id2 = await create.call(_collection('B', frameStyleId));
      await reorder([id2, id1]);
      final ordered = await collectionsRepository.fetchCollectionsWithCount();
      expect(ordered.first.name, 'B');

      await switchStyle.call(collectionId: id1, frameStyleId: frameStyleId);
      await updateCover.call(collectionId: id1, previewPath: '/tmp/a.png');
      final detail = await collectionsRepository.findById(id1);
      expect(detail?.coverPreviewPath, '/tmp/a.png');

      await delete.call(id2);
      final list = await collectionsRepository.fetchCollectionsWithCount();
      expect(list.length, 1);
    });
  });

  group('Collectibles usecases', () {
    test('add collectible updates metrics & toggle highlight', () async {
      final create = CreateCollectionUsecase(
        collectionsRepository,
        highlightSlotsRepository,
      );
      final add = AddCollectibleUsecase(
        collectiblesRepository,
        metricsRepository,
      );
      final toggle =
          ToggleCollectibleHighlightUsecase(collectiblesRepository);

      final collectionId = await create.call(_collection('收藏', frameStyleId));
      final now = DateTime(2024, 1, 10, 9);
      final entity = _collectible(
        collectionId: collectionId,
        name: '相机',
        capturedAt: now,
      );
      final collectibleId = await add.call(entity);
      await toggle.call(collectibleId: collectibleId, allowHighlight: false);

      final rows =
          await collectiblesRepository.listByCollection(collectionId);
      expect(rows.single.allowHighlight, isFalse);

      final metrics = await metricsRepository.metricsForYear(
        collectionId: collectionId,
        year: 2024,
      );
      expect(metrics.single.itemCount, 1);
    });
  });

  group('Highlight slot usecases', () {
    test('assign slot then reset', () async {
      final create = CreateCollectionUsecase(
        collectionsRepository,
        highlightSlotsRepository,
      );
      final assign =
          AssignHighlightSlotUsecase(highlightSlotsRepository);
      final reset =
          ResetHighlightSlotsUsecase(highlightSlotsRepository);

      final collectionId = await create.call(_collection('画框', frameStyleId));
      await assign.call(
        collectionId: collectionId,
        slotIndex: 0,
        collectibleId: 1,
        isLocked: true,
      );
      var slots = await highlightSlotsRepository.listSlots(collectionId);
      expect(slots.first.collectibleId, 1);

      await reset.call(collectionId);
      slots = await highlightSlotsRepository.listSlots(collectionId);
      expect(slots.first.collectibleId, isNull);
    });
  });

  group('Export usecase', () {
    test('log export updates preferences', () async {
      final create = CreateCollectionUsecase(
        collectionsRepository,
        highlightSlotsRepository,
      );
      final logExport = LogExportUsecase(
        exportLogsRepository,
        preferencesRepository,
      );
      final collectionId = await create.call(_collection('导出', frameStyleId));
      await logExport.call(
        collectionId: collectionId,
        exportPath: '/tmp/1.png',
        fileName: '1.png',
        directory: '/tmp',
        fileSizeBytes: 2048,
      );
      final latest =
          await exportLogsRepository.latestForCollection(collectionId);
      expect(latest?.fileName, '1.png');

      final prefs = await preferencesRepository.loadOrCreate();
      expect(prefs.lastExportDir, '/tmp');
    });
  });

  group('Preference usecases', () {
    test('update import mode/root dir', () async {
      final updateMode =
          UpdateImportModeUsecase(preferencesRepository);
      final updateRoot =
          UpdateRootDirectoryUsecase(preferencesRepository);
      await updateMode.call('move');
      await updateRoot.call('/storage');

      final prefs = await preferencesRepository.loadOrCreate();
      expect(prefs.importMode, 'move');
      expect(prefs.rootDirectory, '/storage');
    });
  });
}

CollectionEntity _collection(String name, int frameStyleId) {
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

CollectibleEntity _collectible({
  required int collectionId,
  required String name,
  DateTime? capturedAt,
}) {
  final captured = capturedAt ?? DateTime(2024, 1, 1, 10);
  return CollectibleEntity(
    collectionId: collectionId,
    relativePath: '$collectionId/$name.png',
    thumbnailPath: null,
    fileHash: null,
    fileSizeBytes: 1024,
    displayName: name,
    story: null,
    moodCodePoint: 0xf3f7,
    moodFontFamily: 'CupertinoIcons',
    moodPackage: null,
    moodColor: '#FFAA00',
    capturedAt: captured,
    capturedDate: DateTime(captured.year, captured.month, captured.day),
    allowHighlight: true,
    sortWeight: 0,
    isArchived: false,
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
