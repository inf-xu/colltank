import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/database/app_database.dart';
import '../domain/entities/collection_models.dart';

part 'collection_providers.g.dart';

/// AppDatabase Provider：默认使用内存数据库，便于测试与热启动
@Riverpod(keepAlive: true)
AppDatabase appDatabase(Ref ref) {
  final database = AppDatabase.memory();
  ref.onDispose(database.close);
  return database;
}

/// CollectionsDao Provider，供不同 Notifier 共享
@riverpod
CollectionsDao collectionsDao(Ref ref) {
  return ref.watch(appDatabaseProvider).collectionsDao;
}

/// CollectiblesDao Provider
@riverpod
CollectiblesDao collectiblesDao(Ref ref) {
  return ref.watch(appDatabaseProvider).collectiblesDao;
}

/// 负责首页类别状态的 AsyncNotifier
@riverpod
class CollectionListController extends _$CollectionListController {
  @override
  Future<List<CollectionEntity>> build() async {
    final dao = ref.watch(collectionsDaoProvider);
    final rows = await dao.fetchCollectionRowsWithCount();
    return rows.map((row) => row.row.toEntity(itemCount: row.itemCount)).toList();
  }

  /// 创建或更新类别后刷新状态
  Future<void> saveCollection(CollectionEntity entity) async {
    final dao = ref.watch(collectionsDaoProvider);
    if (entity.id == null) {
      await dao.insertCollection(entity.toCompanion());
    } else {
      await (dao.update(dao.collections)
            ..where((tbl) => tbl.id.equals(entity.id!)))
          .write(entity.toCompanion());
    }
    state = AsyncData(await build());
  }
}

/// 返回指定类别下的全部收藏物列表
@riverpod
Future<List<CollectibleEntity>> collectiblesByCollection(
  Ref ref,
  int collectionId,
) async {
  final dao = ref.watch(collectiblesDaoProvider);
  final rows = await dao.listByCollection(collectionId);
  return rows.map((e) => e.toEntity()).toList();
}
