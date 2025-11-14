import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/database/app_database.dart';
import '../../features/collections/data/repositories/collections/collections_repository.dart';
import '../../features/collections/data/repositories/collectibles/collectibles_repository.dart';
import '../../features/collections/data/repositories/highlight_slots/highlight_slots_repository.dart';
import '../../features/collections/data/repositories/metrics/metrics_repository.dart';
import '../../features/collections/data/repositories/export/export_logs_repository.dart';
import '../../features/settings/data/repositories/preferences/preferences_repository.dart';
import '../../features/collections/domain/usecases/collections/create_collection_usecase.dart';
import '../../features/collections/domain/usecases/collections/delete_collection_usecase.dart';
import '../../features/collections/domain/usecases/collections/reorder_collections_usecase.dart';
import '../../features/collections/domain/usecases/collections/switch_frame_style_usecase.dart';
import '../../features/collections/domain/usecases/collections/update_cover_preview_usecase.dart';
import '../../features/collections/domain/usecases/collections/update_collection_usecase.dart';
import '../../features/collections/domain/usecases/collectibles/add_collectible_usecase.dart';
import '../../features/collections/domain/usecases/collectibles/toggle_collectible_highlight_usecase.dart';
import '../../features/collections/domain/usecases/highlight_slots/assign_highlight_slot_usecase.dart';
import '../../features/collections/domain/usecases/highlight_slots/reset_highlight_slots_usecase.dart';
import '../../features/collections/domain/usecases/export/log_export_usecase.dart';
import '../../features/settings/domain/usecases/preferences/update_import_mode_usecase.dart';
import '../../features/settings/domain/usecases/preferences/update_root_directory_usecase.dart';

/// 数据库实例 Provider
final appDatabaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
});

// ---------------- Repository Providers ----------------

final collectionsRepositoryProvider = Provider<CollectionsRepository>((ref) {
  final dao = ref.watch(appDatabaseProvider).collectionsDao;
  return CollectionsRepository(dao);
});

final collectiblesRepositoryProvider =
    Provider<CollectiblesRepository>((ref) {
  final dao = ref.watch(appDatabaseProvider).collectiblesDao;
  return CollectiblesRepository(dao);
});

final highlightSlotsRepositoryProvider =
    Provider<HighlightSlotsRepository>((ref) {
  final dao = ref.watch(appDatabaseProvider).highlightSlotsDao;
  return HighlightSlotsRepository(dao);
});

final metricsRepositoryProvider = Provider<MetricsRepository>((ref) {
  final dao = ref.watch(appDatabaseProvider).metricsDao;
  return MetricsRepository(dao);
});

final exportLogsRepositoryProvider = Provider<ExportLogsRepository>((ref) {
  final dao = ref.watch(appDatabaseProvider).exportLogsDao;
  return ExportLogsRepository(dao);
});

final preferencesRepositoryProvider =
    Provider<PreferencesRepository>((ref) {
  final dao = ref.watch(appDatabaseProvider).preferencesDao;
  return PreferencesRepository(dao);
});

// ---------------- Usecase Providers ----------------

final createCollectionUsecaseProvider =
    Provider<CreateCollectionUsecase>((ref) {
  return CreateCollectionUsecase(
    ref.watch(collectionsRepositoryProvider),
    ref.watch(highlightSlotsRepositoryProvider),
  );
});

final deleteCollectionUsecaseProvider =
    Provider<DeleteCollectionUsecase>((ref) {
  return DeleteCollectionUsecase(
    ref.watch(collectionsRepositoryProvider),
  );
});

final reorderCollectionsUsecaseProvider =
    Provider<ReorderCollectionsUsecase>((ref) {
  return ReorderCollectionsUsecase(
    ref.watch(collectionsRepositoryProvider),
  );
});

final switchFrameStyleUsecaseProvider =
    Provider<SwitchFrameStyleUsecase>((ref) {
  return SwitchFrameStyleUsecase(
    ref.watch(collectionsRepositoryProvider),
  );
});

final updateCoverPreviewUsecaseProvider =
    Provider<UpdateCoverPreviewUsecase>((ref) {
  return UpdateCoverPreviewUsecase(
    ref.watch(collectionsRepositoryProvider),
  );
});

final updateCollectionUsecaseProvider =
    Provider<UpdateCollectionUsecase>((ref) {
  return UpdateCollectionUsecase(
    ref.watch(collectionsRepositoryProvider),
  );
});

final addCollectibleUsecaseProvider =
    Provider<AddCollectibleUsecase>((ref) {
  return AddCollectibleUsecase(
    ref.watch(collectiblesRepositoryProvider),
    ref.watch(metricsRepositoryProvider),
  );
});

final toggleCollectibleHighlightUsecaseProvider =
    Provider<ToggleCollectibleHighlightUsecase>((ref) {
  return ToggleCollectibleHighlightUsecase(
    ref.watch(collectiblesRepositoryProvider),
  );
});

final assignHighlightSlotUsecaseProvider =
    Provider<AssignHighlightSlotUsecase>((ref) {
  return AssignHighlightSlotUsecase(
    ref.watch(highlightSlotsRepositoryProvider),
  );
});

final resetHighlightSlotsUsecaseProvider =
    Provider<ResetHighlightSlotsUsecase>((ref) {
  return ResetHighlightSlotsUsecase(
    ref.watch(highlightSlotsRepositoryProvider),
  );
});

final logExportUsecaseProvider = Provider<LogExportUsecase>((ref) {
  return LogExportUsecase(
    ref.watch(exportLogsRepositoryProvider),
    ref.watch(preferencesRepositoryProvider),
  );
});

final updateImportModeUsecaseProvider =
    Provider<UpdateImportModeUsecase>((ref) {
  return UpdateImportModeUsecase(
    ref.watch(preferencesRepositoryProvider),
  );
});

final updateRootDirectoryUsecaseProvider =
    Provider<UpdateRootDirectoryUsecase>((ref) {
  return UpdateRootDirectoryUsecase(
    ref.watch(preferencesRepositoryProvider),
  );
});
