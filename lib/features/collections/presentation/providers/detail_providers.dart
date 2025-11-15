import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/providers/global_providers.dart';
import '../../domain/entities/collection_models.dart';

/// 详情页所需的单个收集罐信息
final collectionDetailProvider = FutureProvider.family<CollectionEntity?, int>((
  ref,
  collectionId,
) async {
  final repository = ref.watch(collectionsRepositoryProvider);
  return repository.findById(collectionId);
});

/// 当前收集罐下的图片流
final collectionGalleryProvider =
    StreamProvider.family<List<CollectibleEntity>, int>((ref, collectionId) {
      final repository = ref.watch(collectiblesRepositoryProvider);
      return repository.watchByCollection(collectionId);
    });
