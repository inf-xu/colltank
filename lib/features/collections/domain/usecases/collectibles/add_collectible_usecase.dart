import '../../entities/collection_models.dart';
import '../../../data/repositories/collectibles/collectibles_repository.dart';
import '../../../data/repositories/metrics/metrics_repository.dart';

/// 导入/新增收藏物：入库并刷新指标
class AddCollectibleUsecase {
  AddCollectibleUsecase(
    this._collectiblesRepository,
    this._metricsRepository,
  );

  final CollectiblesRepository _collectiblesRepository;
  final MetricsRepository _metricsRepository;

  Future<int> call(CollectibleEntity entity) async {
    final id = await _collectiblesRepository.insertCollectible(entity);
    await _metricsRepository.incrementDailyMetric(
      collectionId: entity.collectionId,
      statDate: entity.capturedAt,
      deltaCount: 1,
      firstCollectibleId: id,
      lastCollectibleId: id,
    );
    return id;
  }
}
