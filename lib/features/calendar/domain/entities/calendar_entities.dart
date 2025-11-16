import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../collections/domain/entities/collection_models.dart';

part 'calendar_entities.freezed.dart';

/// 日历页面用的按类别聚合模型
@freezed
abstract class CalendarCollectionGroup with _$CalendarCollectionGroup {
  const factory CalendarCollectionGroup({
    required int collectionId,
    required String collectionName,
    required String accentColor,
    required List<CollectibleEntity> items,
  }) = _CalendarCollectionGroup;
}
