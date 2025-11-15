import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/providers/global_providers.dart';
import '../../domain/entities/collection_models.dart';

/// 详情页所需的单个收集罐信息（实时监听）
final collectionDetailProvider = StreamProvider.family<CollectionEntity?, int>((
  ref,
  collectionId,
) {
  final repository = ref.watch(collectionsRepositoryProvider);
  return repository.watchById(collectionId);
});

/// 当前收集罐下的图片流
final collectionGalleryProvider =
    StreamProvider.family<List<CollectibleEntity>, int>((ref, collectionId) {
      final repository = ref.watch(collectiblesRepositoryProvider);
      return repository.watchByCollection(collectionId);
    });

/// 画框九宫格槽位监听
final collectionHighlightSlotsProvider =
    StreamProvider.family<List<HighlightSlotEntity>, int>((
      ref,
      collectionId,
    ) {
      final repository = ref.watch(highlightSlotsRepositoryProvider);
      return repository.watchSlots(collectionId);
    });

/// 单个收藏物详情
final collectibleDetailProvider =
    StreamProvider.family<CollectibleEntity?, int>((ref, collectibleId) {
      final repository = ref.watch(collectiblesRepositoryProvider);
      return repository.watchById(collectibleId);
    });
