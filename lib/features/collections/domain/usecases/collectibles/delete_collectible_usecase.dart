import '../../entities/collection_models.dart';
import '../../../data/repositories/collectibles/collectibles_repository.dart';
import '../../../data/repositories/metrics/metrics_repository.dart';

/// 删除收藏并同步热力图指标
class DeleteCollectibleUsecase {
  DeleteCollectibleUsecase(
    this._collectiblesRepository,
    this._metricsRepository,
  );

  final CollectiblesRepository _collectiblesRepository;
  final MetricsRepository _metricsRepository;

  Future<void> call(CollectibleEntity collectible) async {
    final id = collectible.id;
    if (id == null) {
      return;
    }
    await _collectiblesRepository.deleteByIds([id]);
    await _metricsRepository.incrementDailyMetric(
      collectionId: collectible.collectionId,
      statDate: collectible.capturedAt,
      deltaCount: -1,
    );
  }
}
