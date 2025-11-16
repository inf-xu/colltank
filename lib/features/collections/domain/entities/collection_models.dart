import 'package:drift/drift.dart' hide JsonKey;
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/database/app_database.dart';

part 'collection_models.freezed.dart';

/// 收集罐实体，供 UI 与 Riverpod 状态复用
@freezed
abstract class CollectionEntity with _$CollectionEntity {
  const factory CollectionEntity({
    int? id,
    required String name,
    String? description,
    required int sortIndex,
    required int frameStyleId,
    String? coverPreviewPath,
    DateTime? coverUpdatedAt,
    required String accentColor,
    required DateTime createdAt,
    required DateTime updatedAt,
    @Default(0) int itemCount,
  }) = _CollectionEntity;
}

/// 收藏物品实体
@freezed
abstract class CollectibleEntity with _$CollectibleEntity {
  const factory CollectibleEntity({
    int? id,
    required int collectionId,
    required String relativePath,
    String? thumbnailPath,
    String? fileHash,
    required int fileSizeBytes,
    required String displayName,
    String? story,
    required int moodCodePoint,
    required String moodFontFamily,
    String? moodPackage,
    required String moodColor,
    required DateTime capturedAt,
    required DateTime capturedDate,
    required bool allowHighlight,
    required int sortWeight,
    required bool isArchived,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _CollectibleEntity;
}

/// 九宫格槽位实体
@freezed
abstract class HighlightSlotEntity with _$HighlightSlotEntity {
  const factory HighlightSlotEntity({
    int? id,
    required int collectionId,
    required int slotIndex,
    int? collectibleId,
    required bool isLocked,
    required DateTime updatedAt,
  }) = _HighlightSlotEntity;
}

/// Drift → Freezed 的映射便于 Riverpod 直接消费
extension CollectionRowMapper on CollectionRow {
  CollectionEntity toEntity({required int itemCount}) {
    return CollectionEntity(
      id: id,
      name: name,
      description: description,
      sortIndex: sortIndex,
      frameStyleId: frameStyleId,
      coverPreviewPath: coverPreviewPath,
      coverUpdatedAt: coverUpdatedAt,
      accentColor: accentColor,
      createdAt: createdAt,
      updatedAt: updatedAt,
      itemCount: itemCount,
    );
  }
}

extension CollectionEntityCompanion on CollectionEntity {
  CollectionsCompanion toCompanion() {
    return CollectionsCompanion(
      id: id == null ? const Value.absent() : Value(id!),
      name: Value(name),
      description: Value(description),
      sortIndex: Value(sortIndex),
      frameStyleId: Value(frameStyleId),
      coverPreviewPath: Value(coverPreviewPath),
      coverUpdatedAt: Value(coverUpdatedAt),
      accentColor: Value(accentColor),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }
}

extension CollectibleRowMapper on CollectibleRow {
  CollectibleEntity toEntity() {
    return CollectibleEntity(
      id: id,
      collectionId: collectionId,
      relativePath: relativePath,
      thumbnailPath: thumbnailPath,
      fileHash: fileHash,
      fileSizeBytes: fileSizeBytes,
      displayName: displayName,
      story: story,
      moodCodePoint: moodCodePoint,
      moodFontFamily: moodFontFamily,
      moodPackage: moodPackage,
      moodColor: moodColor,
      capturedAt: capturedAt,
      capturedDate: capturedDate,
      allowHighlight: allowHighlight,
      sortWeight: sortWeight,
      isArchived: isArchived,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

extension CollectibleEntityCompanion on CollectibleEntity {
  CollectiblesCompanion toCompanion() {
    return CollectiblesCompanion(
      id: id == null ? const Value.absent() : Value(id!),
      collectionId: Value(collectionId),
      relativePath: Value(relativePath),
      thumbnailPath: Value(thumbnailPath),
      fileHash: Value(fileHash),
      fileSizeBytes: Value(fileSizeBytes),
      displayName: Value(displayName),
      story: Value(story),
      moodCodePoint: Value(moodCodePoint),
      moodFontFamily: Value(moodFontFamily),
      moodPackage: Value(moodPackage),
      moodColor: Value(moodColor),
      capturedAt: Value(capturedAt),
      capturedDate: Value(capturedDate),
      allowHighlight: Value(allowHighlight),
      sortWeight: Value(sortWeight),
      isArchived: Value(isArchived),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }
}

extension SlotRowMapper on HighlightSlotRow {
  HighlightSlotEntity toEntity() {
    return HighlightSlotEntity(
      id: id,
      collectionId: collectionId,
      slotIndex: slotIndex,
      collectibleId: collectibleId,
      isLocked: isLocked,
      updatedAt: updatedAt,
    );
  }
}

extension DailyCollectibleCountMapper on DailyCollectibleCountRow {
  DailyCollectibleCount toEntity() {
    return DailyCollectibleCount(date: date, count: count);
  }
}

extension CollectibleWithCollectionMapper on CollectibleWithCollectionRow {
  CollectibleWithCollection toEntity() {
    return CollectibleWithCollection(
      collection: collection.toEntity(itemCount: 0),
      collectible: collectible.toEntity(),
    );
  }
}

/// 日历/统计使用的日粒度计数模型
@freezed
abstract class DailyCollectibleCount with _$DailyCollectibleCount {
  const factory DailyCollectibleCount({
    required DateTime date,
    required int count,
  }) = _DailyCollectibleCount;
}

/// 收藏记录附带所属收集罐，方便日历页面按类别分组
@freezed
abstract class CollectibleWithCollection with _$CollectibleWithCollection {
  const factory CollectibleWithCollection({
    required CollectionEntity collection,
    required CollectibleEntity collectible,
  }) = _CollectibleWithCollection;
}
