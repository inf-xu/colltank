// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'collection_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// AppDatabase Provider：默认使用内存数据库，便于测试与热启动

@ProviderFor(appDatabase)
const appDatabaseProvider = AppDatabaseProvider._();

/// AppDatabase Provider：默认使用内存数据库，便于测试与热启动

final class AppDatabaseProvider
    extends $FunctionalProvider<AppDatabase, AppDatabase, AppDatabase>
    with $Provider<AppDatabase> {
  /// AppDatabase Provider：默认使用内存数据库，便于测试与热启动
  const AppDatabaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appDatabaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appDatabaseHash();

  @$internal
  @override
  $ProviderElement<AppDatabase> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AppDatabase create(Ref ref) {
    return appDatabase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppDatabase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppDatabase>(value),
    );
  }
}

String _$appDatabaseHash() => r'bbd4bfb4d0d582503e9a67fafb26cfddb49172d7';

/// CollectionsDao Provider，供不同 Notifier 共享

@ProviderFor(collectionsDao)
const collectionsDaoProvider = CollectionsDaoProvider._();

/// CollectionsDao Provider，供不同 Notifier 共享

final class CollectionsDaoProvider
    extends $FunctionalProvider<CollectionsDao, CollectionsDao, CollectionsDao>
    with $Provider<CollectionsDao> {
  /// CollectionsDao Provider，供不同 Notifier 共享
  const CollectionsDaoProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'collectionsDaoProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$collectionsDaoHash();

  @$internal
  @override
  $ProviderElement<CollectionsDao> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  CollectionsDao create(Ref ref) {
    return collectionsDao(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CollectionsDao value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CollectionsDao>(value),
    );
  }
}

String _$collectionsDaoHash() => r'54adf2441fbe63db3d0e722c6a92bb5c7583fda2';

/// CollectiblesDao Provider

@ProviderFor(collectiblesDao)
const collectiblesDaoProvider = CollectiblesDaoProvider._();

/// CollectiblesDao Provider

final class CollectiblesDaoProvider
    extends
        $FunctionalProvider<CollectiblesDao, CollectiblesDao, CollectiblesDao>
    with $Provider<CollectiblesDao> {
  /// CollectiblesDao Provider
  const CollectiblesDaoProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'collectiblesDaoProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$collectiblesDaoHash();

  @$internal
  @override
  $ProviderElement<CollectiblesDao> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  CollectiblesDao create(Ref ref) {
    return collectiblesDao(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CollectiblesDao value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CollectiblesDao>(value),
    );
  }
}

String _$collectiblesDaoHash() => r'958482080e0e4424f344dc86027fdb7a867784f9';

/// 负责首页类别状态的 AsyncNotifier

@ProviderFor(CollectionListController)
const collectionListControllerProvider = CollectionListControllerProvider._();

/// 负责首页类别状态的 AsyncNotifier
final class CollectionListControllerProvider
    extends
        $AsyncNotifierProvider<
          CollectionListController,
          List<CollectionEntity>
        > {
  /// 负责首页类别状态的 AsyncNotifier
  const CollectionListControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'collectionListControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$collectionListControllerHash();

  @$internal
  @override
  CollectionListController create() => CollectionListController();
}

String _$collectionListControllerHash() =>
    r'b9987974fd6a2501b6555654d3e8b9fd30af534f';

/// 负责首页类别状态的 AsyncNotifier

abstract class _$CollectionListController
    extends $AsyncNotifier<List<CollectionEntity>> {
  FutureOr<List<CollectionEntity>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref
            as $Ref<AsyncValue<List<CollectionEntity>>, List<CollectionEntity>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<CollectionEntity>>,
                List<CollectionEntity>
              >,
              AsyncValue<List<CollectionEntity>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

/// 返回指定类别下的全部收藏物列表

@ProviderFor(collectiblesByCollection)
const collectiblesByCollectionProvider = CollectiblesByCollectionFamily._();

/// 返回指定类别下的全部收藏物列表

final class CollectiblesByCollectionProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<CollectibleEntity>>,
          List<CollectibleEntity>,
          FutureOr<List<CollectibleEntity>>
        >
    with
        $FutureModifier<List<CollectibleEntity>>,
        $FutureProvider<List<CollectibleEntity>> {
  /// 返回指定类别下的全部收藏物列表
  const CollectiblesByCollectionProvider._({
    required CollectiblesByCollectionFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'collectiblesByCollectionProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$collectiblesByCollectionHash();

  @override
  String toString() {
    return r'collectiblesByCollectionProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<CollectibleEntity>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<CollectibleEntity>> create(Ref ref) {
    final argument = this.argument as int;
    return collectiblesByCollection(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is CollectiblesByCollectionProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$collectiblesByCollectionHash() =>
    r'f690f1cdf079115192ca224ce78493f4f8c88611';

/// 返回指定类别下的全部收藏物列表

final class CollectiblesByCollectionFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<CollectibleEntity>>, int> {
  const CollectiblesByCollectionFamily._()
    : super(
        retry: null,
        name: r'collectiblesByCollectionProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// 返回指定类别下的全部收藏物列表

  CollectiblesByCollectionProvider call(int collectionId) =>
      CollectiblesByCollectionProvider._(argument: collectionId, from: this);

  @override
  String toString() => r'collectiblesByCollectionProvider';
}
