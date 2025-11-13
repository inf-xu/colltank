part of 'package:colltank/core/database/app_database.dart';

/// 导出日志 DAO：记录 3×3 拼贴导出历史
@DriftAccessor(tables: [ExportLogs])
class ExportLogsDao extends DatabaseAccessor<AppDatabase>
    with _$ExportLogsDaoMixin {
  ExportLogsDao(AppDatabase db) : super(db);

  Future<int> insertLog(ExportLogsCompanion companion) =>
      into(exportLogs).insert(companion);

  Future<ExportLogRow?> latestForCollection(int collectionId) {
    final query = (select(exportLogs)
          ..where((tbl) => tbl.collectionId.equals(collectionId))
          ..orderBy([(tbl) => OrderingTerm.desc(tbl.createdAt)])
          ..limit(1));
    return query.getSingleOrNull();
  }

  Future<List<ExportLogRow>> logsForCollection(
    int collectionId, {
    int limit = 20,
  }) {
    final query = select(exportLogs)
      ..where((tbl) => tbl.collectionId.equals(collectionId))
      ..orderBy([(tbl) => OrderingTerm.desc(tbl.createdAt)])
      ..limit(limit);
    return query.get();
  }
}
