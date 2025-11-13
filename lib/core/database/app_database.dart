import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'app_database.g.dart';
part 'daos/collections/collections_dao.dart';
part 'daos/collectibles/collectibles_dao.dart';
part 'daos/highlight_slots/highlight_slots_dao.dart';
part 'daos/metrics/metrics_dao.dart';
part 'daos/export/export_logs_dao.dart';
part 'daos/preferences/preferences_dao.dart';

/// 默认使用 LazyDatabase，将数据库文件放在应用文档目录
LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final docsDir = await getApplicationDocumentsDirectory();
    final dbFile = File(p.join(docsDir.path, 'colltank.sqlite'));
    return NativeDatabase.createInBackground(dbFile);
  });
}

@DriftDatabase(
  tables: [
    Collections,
    FrameStyles,
    Collectibles,
    HighlightSlots,
    CollectionDailyMetrics,
    ExportLogs,
    StorageSnapshots,
    AppPreferences,
  ],
  daos: [
    CollectionsDao,
    CollectiblesDao,
    HighlightSlotsDao,
    MetricsDao,
    ExportLogsDao,
    PreferencesDao,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : this._(_openConnection());

  AppDatabase._(QueryExecutor executor) : super(executor);

  AppDatabase.memory() : this._(NativeDatabase.memory());

  @override
  int get schemaVersion => 1;

  /// DAO 实例暴露给业务层使用
  late final CollectionsDao collectionsDao = CollectionsDao(this);
  late final CollectiblesDao collectiblesDao = CollectiblesDao(this);
  late final HighlightSlotsDao highlightSlotsDao = HighlightSlotsDao(this);
  late final MetricsDao metricsDao = MetricsDao(this);
  late final ExportLogsDao exportLogsDao = ExportLogsDao(this);
  late final PreferencesDao preferencesDao = PreferencesDao(this);
}

/// 收集罐类别表
@DataClassName('CollectionRow')
class Collections extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get description => text().nullable()();
  IntColumn get sortIndex => integer().withDefault(const Constant(0))();
  IntColumn get frameStyleId =>
      integer().references(FrameStyles, #id, onDelete: KeyAction.cascade)();
  TextColumn get coverPreviewPath => text().nullable()();
  DateTimeColumn get coverUpdatedAt => dateTime().nullable()();
  TextColumn get accentColor => text().withDefault(const Constant('#FFA726'))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  List<String> get customConstraints => ['UNIQUE(name)'];

}

/// 画框模板表
@DataClassName('FrameStyleRow')
class FrameStyles extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get assetPath => text()();
  TextColumn get overlayMaskPath => text().nullable()();
  TextColumn get gridLineColor => text().withDefault(const Constant('#FFFFFFFF'))();
  TextColumn get backgroundColor => text().withDefault(const Constant('#FF000000'))();
  TextColumn get metadataJson => text().withDefault(const Constant('{}'))();
  TextColumn get supportedLayout =>
      text().withDefault(const Constant('["3x3"]'))();
  BoolColumn get isBuiltin => boolean().withDefault(const Constant(true))();
}

/// 收藏物品表
@DataClassName('CollectibleRow')
class Collectibles extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get collectionId =>
      integer().references(Collections, #id, onDelete: KeyAction.cascade)();
  TextColumn get relativePath => text()();
  TextColumn get thumbnailPath => text().nullable()();
  TextColumn get fileHash => text().nullable()();
  IntColumn get fileSizeBytes => integer().withDefault(const Constant(0))();
  TextColumn get displayName => text()();
  TextColumn get story => text().nullable()();
  IntColumn get moodCodePoint => integer().withDefault(const Constant(0))();
  TextColumn get moodFontFamily => text().withDefault(const Constant('CupertinoIcons'))();
  TextColumn get moodPackage => text().nullable()();
  TextColumn get moodColor => text().withDefault(const Constant('#FFFFFFFF'))();
  DateTimeColumn get capturedAt => dateTime()();
  DateTimeColumn get capturedDate => dateTime()();
  BoolColumn get allowHighlight => boolean().withDefault(const Constant(true))();
  IntColumn get sortWeight => integer().withDefault(const Constant(0))();
  BoolColumn get isArchived => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

}

/// 画框九宫格槽位表
@DataClassName('HighlightSlotRow')
class HighlightSlots extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get collectionId =>
      integer().references(Collections, #id, onDelete: KeyAction.cascade)();
  IntColumn get slotIndex => integer()();
  IntColumn get collectibleId =>
      integer().nullable().references(Collectibles, #id, onDelete: KeyAction.setNull)();
  BoolColumn get isLocked => boolean().withDefault(const Constant(false))();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  List<String> get customConstraints => ['UNIQUE(collection_id, slot_index)'];
}

/// 日指标表
@DataClassName('CollectionDailyMetricRow')
class CollectionDailyMetrics extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get collectionId =>
      integer().nullable().references(Collections, #id, onDelete: KeyAction.cascade)();
  DateTimeColumn get statDate => dateTime()();
  IntColumn get itemCount => integer().withDefault(const Constant(0))();
  IntColumn get firstCollectibleId =>
      integer().nullable().references(Collectibles, #id, onDelete: KeyAction.setNull)();
  IntColumn get lastCollectibleId =>
      integer().nullable().references(Collectibles, #id, onDelete: KeyAction.setNull)();
  DateTimeColumn get lastSyncedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  List<String> get customConstraints => ['UNIQUE(collection_id, stat_date)'];
}

/// 画框导出日志
@DataClassName('ExportLogRow')
class ExportLogs extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get collectionId =>
      integer().references(Collections, #id, onDelete: KeyAction.cascade)();
  TextColumn get exportPath => text()();
  TextColumn get fileName => text()();
  TextColumn get resolutionPx => text().withDefault(const Constant('2048x2048'))();
  IntColumn get fileSizeBytes => integer().withDefault(const Constant(0))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

}

/// 存储占用快照
@DataClassName('StorageSnapshotRow')
class StorageSnapshots extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get collectionId =>
      integer().nullable().references(Collections, #id, onDelete: KeyAction.cascade)();
  IntColumn get totalBytes => integer().withDefault(const Constant(0))();
  IntColumn get thumbnailBytes => integer().withDefault(const Constant(0))();
  IntColumn get itemsCount => integer().withDefault(const Constant(0))();
  DateTimeColumn get computedAt => dateTime().withDefault(currentDateAndTime)();
}

/// 应用偏好设置
@DataClassName('AppPreferenceRow')
class AppPreferences extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get rootDirectory => text().withDefault(const Constant(''))();
  TextColumn get importMode => text().withDefault(const Constant('copy'))();
  TextColumn get lastExportDir => text().nullable()();
  DateTimeColumn get lastDirectoryCheckAt => dateTime().nullable()();
  IntColumn get totalStorageBytes => integer().nullable()();
  BoolColumn get analyticsOptIn => boolean().withDefault(const Constant(false))();
}
