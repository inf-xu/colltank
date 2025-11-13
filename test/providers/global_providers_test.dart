import 'dart:ffi';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqlite3/open.dart' as sqlite_open;

import 'package:colltank/app/providers/global_providers.dart';
import 'package:colltank/core/database/app_database.dart';
import 'package:colltank/features/collections/domain/entities/collection_models.dart';

void main() {
  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
    if (Platform.isLinux) {
      sqlite_open.open.overrideForAll(
        () => DynamicLibrary.open('libsqlite3.so.0'),
      );
    }
  });

  test('Provider graph wiring works together', () async {
    final memoryDb = AppDatabase.memory();
    final container = ProviderContainer(
      overrides: [
        appDatabaseProvider.overrideWithValue(memoryDb),
      ],
    );
    addTearDown(() async {
      await memoryDb.close();
      container.dispose();
    });

    final createCollection = container.read(createCollectionUsecaseProvider);
    final listCollections =
        container.read(collectionsRepositoryProvider);

    final now = DateTime(2024, 1, 1, 10);
    final entity = CollectionEntity(
      name: 'Provider 测试',
      description: '确保依赖注入正常',
      sortIndex: 0,
      frameStyleId: await _insertFrameStyle(
        container.read(appDatabaseProvider),
      ),
      accentColor: '#FFA726',
      createdAt: now,
      updatedAt: now,
    );

    final id = await createCollection.call(entity);
    final list = await listCollections.fetchCollectionsWithCount();
    expect(list.single.id, id);
  });
}

Future<int> _insertFrameStyle(AppDatabase db) {
  return db.into(db.frameStyles).insert(
        FrameStylesCompanion.insert(
          name: '测试画框',
          assetPath: 'assets/frame/test.png',
        ),
      );
}
