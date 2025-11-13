import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'app_database.g.dart';

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

/// 收集罐 DAO：封装数据聚合与 Freezed 映射
@DriftAccessor(tables: [Collections, Collectibles])
class CollectionsDao extends DatabaseAccessor<AppDatabase>
    with _$CollectionsDaoMixin {
  CollectionsDao(AppDatabase db) : super(db);

  Future<int> insertCollection(CollectionsCompanion companion) =>
      into(collections).insert(companion);

  Future<List<CollectionRow>> allCollectionsRaw() =>
      (select(collections)..orderBy([(tbl) => OrderingTerm.desc(tbl.sortIndex)]))
          .get();

  Future<List<MapEntry<int, int>>> _collectCounts() async {
    final countExpr = collectibles.id.count();
    final rows = await (selectOnly(collectibles)
          ..addColumns([collectibles.collectionId, countExpr])
          ..groupBy([collectibles.collectionId]))
        .get();
    return rows
        .map(
          (row) => MapEntry(
            row.read(collectibles.collectionId)!,
            row.read(countExpr) ?? 0,
          ),
        )
        .toList();
  }

  Future<List<CollectionRowWithCount>> fetchCollectionRowsWithCount() async {
    final rawRows = await allCollectionsRaw();
    final countMap = <int, int>{};
    for (final entry in await _collectCounts()) {
      countMap[entry.key] = entry.value;
    }
    return rawRows
        .map(
          (data) => CollectionRowWithCount(
            row: data,
            itemCount: countMap[data.id] ?? 0,
          ),
        )
        .toList();
  }
}

/// 收藏物品 DAO：负责插入与按类别查询
@DriftAccessor(tables: [Collectibles])
class CollectiblesDao extends DatabaseAccessor<AppDatabase>
    with _$CollectiblesDaoMixin {
  CollectiblesDao(AppDatabase db) : super(db);

  Future<int> insertCollectible(CollectiblesCompanion companion) =>
      into(collectibles).insert(companion);

  Future<List<CollectibleRow>> listByCollection(int collectionId) {
    return (select(collectibles)
          ..where((tbl) => tbl.collectionId.equals(collectionId)))
        .get();
  }
}

/// 画框槽位 DAO：保证槽位唯一并支持 upsert
@DriftAccessor(tables: [HighlightSlots])
class HighlightSlotsDao extends DatabaseAccessor<AppDatabase>
    with _$HighlightSlotsDaoMixin {
  HighlightSlotsDao(AppDatabase db) : super(db);

  Future<void> upsertSlot({
    required int collectionId,
    required int slotIndex,
    int? collectibleId,
    bool isLocked = false,
  }) async {
    final record = HighlightSlotsCompanion(
      collectionId: Value(collectionId),
      slotIndex: Value(slotIndex),
      collectibleId: Value(collectibleId),
      isLocked: Value(isLocked),
      updatedAt: Value(DateTime.now()),
    );
    await into(highlightSlots).insertOnConflictUpdate(record);
  }

  Future<List<HighlightSlotRow>> listSlots(int collectionId) {
    return (select(highlightSlots)
          ..where((tbl) => tbl.collectionId.equals(collectionId))
          ..orderBy([(tbl) => OrderingTerm.asc(tbl.slotIndex)]))
        .get();
  }
}

/// DAO 查询结果的轻量封装，避免核心层直接依赖 UI 实体
class CollectionRowWithCount {
  const CollectionRowWithCount({
    required this.row,
    required this.itemCount,
  });

  final CollectionRow row;
  final int itemCount;
}
