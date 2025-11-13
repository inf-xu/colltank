// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'collection_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CollectionEntity {

 int? get id; String get name; String? get description; int get sortIndex; int get frameStyleId; String? get coverPreviewPath; DateTime? get coverUpdatedAt; String get accentColor; DateTime get createdAt; DateTime get updatedAt; int get itemCount;
/// Create a copy of CollectionEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CollectionEntityCopyWith<CollectionEntity> get copyWith => _$CollectionEntityCopyWithImpl<CollectionEntity>(this as CollectionEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CollectionEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.sortIndex, sortIndex) || other.sortIndex == sortIndex)&&(identical(other.frameStyleId, frameStyleId) || other.frameStyleId == frameStyleId)&&(identical(other.coverPreviewPath, coverPreviewPath) || other.coverPreviewPath == coverPreviewPath)&&(identical(other.coverUpdatedAt, coverUpdatedAt) || other.coverUpdatedAt == coverUpdatedAt)&&(identical(other.accentColor, accentColor) || other.accentColor == accentColor)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.itemCount, itemCount) || other.itemCount == itemCount));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,description,sortIndex,frameStyleId,coverPreviewPath,coverUpdatedAt,accentColor,createdAt,updatedAt,itemCount);

@override
String toString() {
  return 'CollectionEntity(id: $id, name: $name, description: $description, sortIndex: $sortIndex, frameStyleId: $frameStyleId, coverPreviewPath: $coverPreviewPath, coverUpdatedAt: $coverUpdatedAt, accentColor: $accentColor, createdAt: $createdAt, updatedAt: $updatedAt, itemCount: $itemCount)';
}


}

/// @nodoc
abstract mixin class $CollectionEntityCopyWith<$Res>  {
  factory $CollectionEntityCopyWith(CollectionEntity value, $Res Function(CollectionEntity) _then) = _$CollectionEntityCopyWithImpl;
@useResult
$Res call({
 int? id, String name, String? description, int sortIndex, int frameStyleId, String? coverPreviewPath, DateTime? coverUpdatedAt, String accentColor, DateTime createdAt, DateTime updatedAt, int itemCount
});




}
/// @nodoc
class _$CollectionEntityCopyWithImpl<$Res>
    implements $CollectionEntityCopyWith<$Res> {
  _$CollectionEntityCopyWithImpl(this._self, this._then);

  final CollectionEntity _self;
  final $Res Function(CollectionEntity) _then;

/// Create a copy of CollectionEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? name = null,Object? description = freezed,Object? sortIndex = null,Object? frameStyleId = null,Object? coverPreviewPath = freezed,Object? coverUpdatedAt = freezed,Object? accentColor = null,Object? createdAt = null,Object? updatedAt = null,Object? itemCount = null,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,sortIndex: null == sortIndex ? _self.sortIndex : sortIndex // ignore: cast_nullable_to_non_nullable
as int,frameStyleId: null == frameStyleId ? _self.frameStyleId : frameStyleId // ignore: cast_nullable_to_non_nullable
as int,coverPreviewPath: freezed == coverPreviewPath ? _self.coverPreviewPath : coverPreviewPath // ignore: cast_nullable_to_non_nullable
as String?,coverUpdatedAt: freezed == coverUpdatedAt ? _self.coverUpdatedAt : coverUpdatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,accentColor: null == accentColor ? _self.accentColor : accentColor // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,itemCount: null == itemCount ? _self.itemCount : itemCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [CollectionEntity].
extension CollectionEntityPatterns on CollectionEntity {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CollectionEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CollectionEntity() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CollectionEntity value)  $default,){
final _that = this;
switch (_that) {
case _CollectionEntity():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CollectionEntity value)?  $default,){
final _that = this;
switch (_that) {
case _CollectionEntity() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? id,  String name,  String? description,  int sortIndex,  int frameStyleId,  String? coverPreviewPath,  DateTime? coverUpdatedAt,  String accentColor,  DateTime createdAt,  DateTime updatedAt,  int itemCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CollectionEntity() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.sortIndex,_that.frameStyleId,_that.coverPreviewPath,_that.coverUpdatedAt,_that.accentColor,_that.createdAt,_that.updatedAt,_that.itemCount);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? id,  String name,  String? description,  int sortIndex,  int frameStyleId,  String? coverPreviewPath,  DateTime? coverUpdatedAt,  String accentColor,  DateTime createdAt,  DateTime updatedAt,  int itemCount)  $default,) {final _that = this;
switch (_that) {
case _CollectionEntity():
return $default(_that.id,_that.name,_that.description,_that.sortIndex,_that.frameStyleId,_that.coverPreviewPath,_that.coverUpdatedAt,_that.accentColor,_that.createdAt,_that.updatedAt,_that.itemCount);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? id,  String name,  String? description,  int sortIndex,  int frameStyleId,  String? coverPreviewPath,  DateTime? coverUpdatedAt,  String accentColor,  DateTime createdAt,  DateTime updatedAt,  int itemCount)?  $default,) {final _that = this;
switch (_that) {
case _CollectionEntity() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.sortIndex,_that.frameStyleId,_that.coverPreviewPath,_that.coverUpdatedAt,_that.accentColor,_that.createdAt,_that.updatedAt,_that.itemCount);case _:
  return null;

}
}

}

/// @nodoc


class _CollectionEntity implements CollectionEntity {
  const _CollectionEntity({this.id, required this.name, this.description, required this.sortIndex, required this.frameStyleId, this.coverPreviewPath, this.coverUpdatedAt, required this.accentColor, required this.createdAt, required this.updatedAt, this.itemCount = 0});
  

@override final  int? id;
@override final  String name;
@override final  String? description;
@override final  int sortIndex;
@override final  int frameStyleId;
@override final  String? coverPreviewPath;
@override final  DateTime? coverUpdatedAt;
@override final  String accentColor;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;
@override@JsonKey() final  int itemCount;

/// Create a copy of CollectionEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CollectionEntityCopyWith<_CollectionEntity> get copyWith => __$CollectionEntityCopyWithImpl<_CollectionEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CollectionEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.sortIndex, sortIndex) || other.sortIndex == sortIndex)&&(identical(other.frameStyleId, frameStyleId) || other.frameStyleId == frameStyleId)&&(identical(other.coverPreviewPath, coverPreviewPath) || other.coverPreviewPath == coverPreviewPath)&&(identical(other.coverUpdatedAt, coverUpdatedAt) || other.coverUpdatedAt == coverUpdatedAt)&&(identical(other.accentColor, accentColor) || other.accentColor == accentColor)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.itemCount, itemCount) || other.itemCount == itemCount));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,description,sortIndex,frameStyleId,coverPreviewPath,coverUpdatedAt,accentColor,createdAt,updatedAt,itemCount);

@override
String toString() {
  return 'CollectionEntity(id: $id, name: $name, description: $description, sortIndex: $sortIndex, frameStyleId: $frameStyleId, coverPreviewPath: $coverPreviewPath, coverUpdatedAt: $coverUpdatedAt, accentColor: $accentColor, createdAt: $createdAt, updatedAt: $updatedAt, itemCount: $itemCount)';
}


}

/// @nodoc
abstract mixin class _$CollectionEntityCopyWith<$Res> implements $CollectionEntityCopyWith<$Res> {
  factory _$CollectionEntityCopyWith(_CollectionEntity value, $Res Function(_CollectionEntity) _then) = __$CollectionEntityCopyWithImpl;
@override @useResult
$Res call({
 int? id, String name, String? description, int sortIndex, int frameStyleId, String? coverPreviewPath, DateTime? coverUpdatedAt, String accentColor, DateTime createdAt, DateTime updatedAt, int itemCount
});




}
/// @nodoc
class __$CollectionEntityCopyWithImpl<$Res>
    implements _$CollectionEntityCopyWith<$Res> {
  __$CollectionEntityCopyWithImpl(this._self, this._then);

  final _CollectionEntity _self;
  final $Res Function(_CollectionEntity) _then;

/// Create a copy of CollectionEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? name = null,Object? description = freezed,Object? sortIndex = null,Object? frameStyleId = null,Object? coverPreviewPath = freezed,Object? coverUpdatedAt = freezed,Object? accentColor = null,Object? createdAt = null,Object? updatedAt = null,Object? itemCount = null,}) {
  return _then(_CollectionEntity(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,sortIndex: null == sortIndex ? _self.sortIndex : sortIndex // ignore: cast_nullable_to_non_nullable
as int,frameStyleId: null == frameStyleId ? _self.frameStyleId : frameStyleId // ignore: cast_nullable_to_non_nullable
as int,coverPreviewPath: freezed == coverPreviewPath ? _self.coverPreviewPath : coverPreviewPath // ignore: cast_nullable_to_non_nullable
as String?,coverUpdatedAt: freezed == coverUpdatedAt ? _self.coverUpdatedAt : coverUpdatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,accentColor: null == accentColor ? _self.accentColor : accentColor // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,itemCount: null == itemCount ? _self.itemCount : itemCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$CollectibleEntity {

 int? get id; int get collectionId; String get relativePath; String? get thumbnailPath; String? get fileHash; int get fileSizeBytes; String get displayName; String? get story; int get moodCodePoint; String get moodFontFamily; String? get moodPackage; String get moodColor; DateTime get capturedAt; DateTime get capturedDate; bool get allowHighlight; int get sortWeight; bool get isArchived; DateTime get createdAt; DateTime get updatedAt;
/// Create a copy of CollectibleEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CollectibleEntityCopyWith<CollectibleEntity> get copyWith => _$CollectibleEntityCopyWithImpl<CollectibleEntity>(this as CollectibleEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CollectibleEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.collectionId, collectionId) || other.collectionId == collectionId)&&(identical(other.relativePath, relativePath) || other.relativePath == relativePath)&&(identical(other.thumbnailPath, thumbnailPath) || other.thumbnailPath == thumbnailPath)&&(identical(other.fileHash, fileHash) || other.fileHash == fileHash)&&(identical(other.fileSizeBytes, fileSizeBytes) || other.fileSizeBytes == fileSizeBytes)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.story, story) || other.story == story)&&(identical(other.moodCodePoint, moodCodePoint) || other.moodCodePoint == moodCodePoint)&&(identical(other.moodFontFamily, moodFontFamily) || other.moodFontFamily == moodFontFamily)&&(identical(other.moodPackage, moodPackage) || other.moodPackage == moodPackage)&&(identical(other.moodColor, moodColor) || other.moodColor == moodColor)&&(identical(other.capturedAt, capturedAt) || other.capturedAt == capturedAt)&&(identical(other.capturedDate, capturedDate) || other.capturedDate == capturedDate)&&(identical(other.allowHighlight, allowHighlight) || other.allowHighlight == allowHighlight)&&(identical(other.sortWeight, sortWeight) || other.sortWeight == sortWeight)&&(identical(other.isArchived, isArchived) || other.isArchived == isArchived)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode => Object.hashAll([runtimeType,id,collectionId,relativePath,thumbnailPath,fileHash,fileSizeBytes,displayName,story,moodCodePoint,moodFontFamily,moodPackage,moodColor,capturedAt,capturedDate,allowHighlight,sortWeight,isArchived,createdAt,updatedAt]);

@override
String toString() {
  return 'CollectibleEntity(id: $id, collectionId: $collectionId, relativePath: $relativePath, thumbnailPath: $thumbnailPath, fileHash: $fileHash, fileSizeBytes: $fileSizeBytes, displayName: $displayName, story: $story, moodCodePoint: $moodCodePoint, moodFontFamily: $moodFontFamily, moodPackage: $moodPackage, moodColor: $moodColor, capturedAt: $capturedAt, capturedDate: $capturedDate, allowHighlight: $allowHighlight, sortWeight: $sortWeight, isArchived: $isArchived, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $CollectibleEntityCopyWith<$Res>  {
  factory $CollectibleEntityCopyWith(CollectibleEntity value, $Res Function(CollectibleEntity) _then) = _$CollectibleEntityCopyWithImpl;
@useResult
$Res call({
 int? id, int collectionId, String relativePath, String? thumbnailPath, String? fileHash, int fileSizeBytes, String displayName, String? story, int moodCodePoint, String moodFontFamily, String? moodPackage, String moodColor, DateTime capturedAt, DateTime capturedDate, bool allowHighlight, int sortWeight, bool isArchived, DateTime createdAt, DateTime updatedAt
});




}
/// @nodoc
class _$CollectibleEntityCopyWithImpl<$Res>
    implements $CollectibleEntityCopyWith<$Res> {
  _$CollectibleEntityCopyWithImpl(this._self, this._then);

  final CollectibleEntity _self;
  final $Res Function(CollectibleEntity) _then;

/// Create a copy of CollectibleEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? collectionId = null,Object? relativePath = null,Object? thumbnailPath = freezed,Object? fileHash = freezed,Object? fileSizeBytes = null,Object? displayName = null,Object? story = freezed,Object? moodCodePoint = null,Object? moodFontFamily = null,Object? moodPackage = freezed,Object? moodColor = null,Object? capturedAt = null,Object? capturedDate = null,Object? allowHighlight = null,Object? sortWeight = null,Object? isArchived = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,collectionId: null == collectionId ? _self.collectionId : collectionId // ignore: cast_nullable_to_non_nullable
as int,relativePath: null == relativePath ? _self.relativePath : relativePath // ignore: cast_nullable_to_non_nullable
as String,thumbnailPath: freezed == thumbnailPath ? _self.thumbnailPath : thumbnailPath // ignore: cast_nullable_to_non_nullable
as String?,fileHash: freezed == fileHash ? _self.fileHash : fileHash // ignore: cast_nullable_to_non_nullable
as String?,fileSizeBytes: null == fileSizeBytes ? _self.fileSizeBytes : fileSizeBytes // ignore: cast_nullable_to_non_nullable
as int,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,story: freezed == story ? _self.story : story // ignore: cast_nullable_to_non_nullable
as String?,moodCodePoint: null == moodCodePoint ? _self.moodCodePoint : moodCodePoint // ignore: cast_nullable_to_non_nullable
as int,moodFontFamily: null == moodFontFamily ? _self.moodFontFamily : moodFontFamily // ignore: cast_nullable_to_non_nullable
as String,moodPackage: freezed == moodPackage ? _self.moodPackage : moodPackage // ignore: cast_nullable_to_non_nullable
as String?,moodColor: null == moodColor ? _self.moodColor : moodColor // ignore: cast_nullable_to_non_nullable
as String,capturedAt: null == capturedAt ? _self.capturedAt : capturedAt // ignore: cast_nullable_to_non_nullable
as DateTime,capturedDate: null == capturedDate ? _self.capturedDate : capturedDate // ignore: cast_nullable_to_non_nullable
as DateTime,allowHighlight: null == allowHighlight ? _self.allowHighlight : allowHighlight // ignore: cast_nullable_to_non_nullable
as bool,sortWeight: null == sortWeight ? _self.sortWeight : sortWeight // ignore: cast_nullable_to_non_nullable
as int,isArchived: null == isArchived ? _self.isArchived : isArchived // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [CollectibleEntity].
extension CollectibleEntityPatterns on CollectibleEntity {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CollectibleEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CollectibleEntity() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CollectibleEntity value)  $default,){
final _that = this;
switch (_that) {
case _CollectibleEntity():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CollectibleEntity value)?  $default,){
final _that = this;
switch (_that) {
case _CollectibleEntity() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? id,  int collectionId,  String relativePath,  String? thumbnailPath,  String? fileHash,  int fileSizeBytes,  String displayName,  String? story,  int moodCodePoint,  String moodFontFamily,  String? moodPackage,  String moodColor,  DateTime capturedAt,  DateTime capturedDate,  bool allowHighlight,  int sortWeight,  bool isArchived,  DateTime createdAt,  DateTime updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CollectibleEntity() when $default != null:
return $default(_that.id,_that.collectionId,_that.relativePath,_that.thumbnailPath,_that.fileHash,_that.fileSizeBytes,_that.displayName,_that.story,_that.moodCodePoint,_that.moodFontFamily,_that.moodPackage,_that.moodColor,_that.capturedAt,_that.capturedDate,_that.allowHighlight,_that.sortWeight,_that.isArchived,_that.createdAt,_that.updatedAt);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? id,  int collectionId,  String relativePath,  String? thumbnailPath,  String? fileHash,  int fileSizeBytes,  String displayName,  String? story,  int moodCodePoint,  String moodFontFamily,  String? moodPackage,  String moodColor,  DateTime capturedAt,  DateTime capturedDate,  bool allowHighlight,  int sortWeight,  bool isArchived,  DateTime createdAt,  DateTime updatedAt)  $default,) {final _that = this;
switch (_that) {
case _CollectibleEntity():
return $default(_that.id,_that.collectionId,_that.relativePath,_that.thumbnailPath,_that.fileHash,_that.fileSizeBytes,_that.displayName,_that.story,_that.moodCodePoint,_that.moodFontFamily,_that.moodPackage,_that.moodColor,_that.capturedAt,_that.capturedDate,_that.allowHighlight,_that.sortWeight,_that.isArchived,_that.createdAt,_that.updatedAt);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? id,  int collectionId,  String relativePath,  String? thumbnailPath,  String? fileHash,  int fileSizeBytes,  String displayName,  String? story,  int moodCodePoint,  String moodFontFamily,  String? moodPackage,  String moodColor,  DateTime capturedAt,  DateTime capturedDate,  bool allowHighlight,  int sortWeight,  bool isArchived,  DateTime createdAt,  DateTime updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _CollectibleEntity() when $default != null:
return $default(_that.id,_that.collectionId,_that.relativePath,_that.thumbnailPath,_that.fileHash,_that.fileSizeBytes,_that.displayName,_that.story,_that.moodCodePoint,_that.moodFontFamily,_that.moodPackage,_that.moodColor,_that.capturedAt,_that.capturedDate,_that.allowHighlight,_that.sortWeight,_that.isArchived,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc


class _CollectibleEntity implements CollectibleEntity {
  const _CollectibleEntity({this.id, required this.collectionId, required this.relativePath, this.thumbnailPath, this.fileHash, required this.fileSizeBytes, required this.displayName, this.story, required this.moodCodePoint, required this.moodFontFamily, this.moodPackage, required this.moodColor, required this.capturedAt, required this.capturedDate, required this.allowHighlight, required this.sortWeight, required this.isArchived, required this.createdAt, required this.updatedAt});
  

@override final  int? id;
@override final  int collectionId;
@override final  String relativePath;
@override final  String? thumbnailPath;
@override final  String? fileHash;
@override final  int fileSizeBytes;
@override final  String displayName;
@override final  String? story;
@override final  int moodCodePoint;
@override final  String moodFontFamily;
@override final  String? moodPackage;
@override final  String moodColor;
@override final  DateTime capturedAt;
@override final  DateTime capturedDate;
@override final  bool allowHighlight;
@override final  int sortWeight;
@override final  bool isArchived;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;

/// Create a copy of CollectibleEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CollectibleEntityCopyWith<_CollectibleEntity> get copyWith => __$CollectibleEntityCopyWithImpl<_CollectibleEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CollectibleEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.collectionId, collectionId) || other.collectionId == collectionId)&&(identical(other.relativePath, relativePath) || other.relativePath == relativePath)&&(identical(other.thumbnailPath, thumbnailPath) || other.thumbnailPath == thumbnailPath)&&(identical(other.fileHash, fileHash) || other.fileHash == fileHash)&&(identical(other.fileSizeBytes, fileSizeBytes) || other.fileSizeBytes == fileSizeBytes)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.story, story) || other.story == story)&&(identical(other.moodCodePoint, moodCodePoint) || other.moodCodePoint == moodCodePoint)&&(identical(other.moodFontFamily, moodFontFamily) || other.moodFontFamily == moodFontFamily)&&(identical(other.moodPackage, moodPackage) || other.moodPackage == moodPackage)&&(identical(other.moodColor, moodColor) || other.moodColor == moodColor)&&(identical(other.capturedAt, capturedAt) || other.capturedAt == capturedAt)&&(identical(other.capturedDate, capturedDate) || other.capturedDate == capturedDate)&&(identical(other.allowHighlight, allowHighlight) || other.allowHighlight == allowHighlight)&&(identical(other.sortWeight, sortWeight) || other.sortWeight == sortWeight)&&(identical(other.isArchived, isArchived) || other.isArchived == isArchived)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode => Object.hashAll([runtimeType,id,collectionId,relativePath,thumbnailPath,fileHash,fileSizeBytes,displayName,story,moodCodePoint,moodFontFamily,moodPackage,moodColor,capturedAt,capturedDate,allowHighlight,sortWeight,isArchived,createdAt,updatedAt]);

@override
String toString() {
  return 'CollectibleEntity(id: $id, collectionId: $collectionId, relativePath: $relativePath, thumbnailPath: $thumbnailPath, fileHash: $fileHash, fileSizeBytes: $fileSizeBytes, displayName: $displayName, story: $story, moodCodePoint: $moodCodePoint, moodFontFamily: $moodFontFamily, moodPackage: $moodPackage, moodColor: $moodColor, capturedAt: $capturedAt, capturedDate: $capturedDate, allowHighlight: $allowHighlight, sortWeight: $sortWeight, isArchived: $isArchived, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$CollectibleEntityCopyWith<$Res> implements $CollectibleEntityCopyWith<$Res> {
  factory _$CollectibleEntityCopyWith(_CollectibleEntity value, $Res Function(_CollectibleEntity) _then) = __$CollectibleEntityCopyWithImpl;
@override @useResult
$Res call({
 int? id, int collectionId, String relativePath, String? thumbnailPath, String? fileHash, int fileSizeBytes, String displayName, String? story, int moodCodePoint, String moodFontFamily, String? moodPackage, String moodColor, DateTime capturedAt, DateTime capturedDate, bool allowHighlight, int sortWeight, bool isArchived, DateTime createdAt, DateTime updatedAt
});




}
/// @nodoc
class __$CollectibleEntityCopyWithImpl<$Res>
    implements _$CollectibleEntityCopyWith<$Res> {
  __$CollectibleEntityCopyWithImpl(this._self, this._then);

  final _CollectibleEntity _self;
  final $Res Function(_CollectibleEntity) _then;

/// Create a copy of CollectibleEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? collectionId = null,Object? relativePath = null,Object? thumbnailPath = freezed,Object? fileHash = freezed,Object? fileSizeBytes = null,Object? displayName = null,Object? story = freezed,Object? moodCodePoint = null,Object? moodFontFamily = null,Object? moodPackage = freezed,Object? moodColor = null,Object? capturedAt = null,Object? capturedDate = null,Object? allowHighlight = null,Object? sortWeight = null,Object? isArchived = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_CollectibleEntity(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,collectionId: null == collectionId ? _self.collectionId : collectionId // ignore: cast_nullable_to_non_nullable
as int,relativePath: null == relativePath ? _self.relativePath : relativePath // ignore: cast_nullable_to_non_nullable
as String,thumbnailPath: freezed == thumbnailPath ? _self.thumbnailPath : thumbnailPath // ignore: cast_nullable_to_non_nullable
as String?,fileHash: freezed == fileHash ? _self.fileHash : fileHash // ignore: cast_nullable_to_non_nullable
as String?,fileSizeBytes: null == fileSizeBytes ? _self.fileSizeBytes : fileSizeBytes // ignore: cast_nullable_to_non_nullable
as int,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,story: freezed == story ? _self.story : story // ignore: cast_nullable_to_non_nullable
as String?,moodCodePoint: null == moodCodePoint ? _self.moodCodePoint : moodCodePoint // ignore: cast_nullable_to_non_nullable
as int,moodFontFamily: null == moodFontFamily ? _self.moodFontFamily : moodFontFamily // ignore: cast_nullable_to_non_nullable
as String,moodPackage: freezed == moodPackage ? _self.moodPackage : moodPackage // ignore: cast_nullable_to_non_nullable
as String?,moodColor: null == moodColor ? _self.moodColor : moodColor // ignore: cast_nullable_to_non_nullable
as String,capturedAt: null == capturedAt ? _self.capturedAt : capturedAt // ignore: cast_nullable_to_non_nullable
as DateTime,capturedDate: null == capturedDate ? _self.capturedDate : capturedDate // ignore: cast_nullable_to_non_nullable
as DateTime,allowHighlight: null == allowHighlight ? _self.allowHighlight : allowHighlight // ignore: cast_nullable_to_non_nullable
as bool,sortWeight: null == sortWeight ? _self.sortWeight : sortWeight // ignore: cast_nullable_to_non_nullable
as int,isArchived: null == isArchived ? _self.isArchived : isArchived // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

/// @nodoc
mixin _$HighlightSlotEntity {

 int? get id; int get collectionId; int get slotIndex; int? get collectibleId; bool get isLocked; DateTime get updatedAt;
/// Create a copy of HighlightSlotEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HighlightSlotEntityCopyWith<HighlightSlotEntity> get copyWith => _$HighlightSlotEntityCopyWithImpl<HighlightSlotEntity>(this as HighlightSlotEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HighlightSlotEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.collectionId, collectionId) || other.collectionId == collectionId)&&(identical(other.slotIndex, slotIndex) || other.slotIndex == slotIndex)&&(identical(other.collectibleId, collectibleId) || other.collectibleId == collectibleId)&&(identical(other.isLocked, isLocked) || other.isLocked == isLocked)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,collectionId,slotIndex,collectibleId,isLocked,updatedAt);

@override
String toString() {
  return 'HighlightSlotEntity(id: $id, collectionId: $collectionId, slotIndex: $slotIndex, collectibleId: $collectibleId, isLocked: $isLocked, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $HighlightSlotEntityCopyWith<$Res>  {
  factory $HighlightSlotEntityCopyWith(HighlightSlotEntity value, $Res Function(HighlightSlotEntity) _then) = _$HighlightSlotEntityCopyWithImpl;
@useResult
$Res call({
 int? id, int collectionId, int slotIndex, int? collectibleId, bool isLocked, DateTime updatedAt
});




}
/// @nodoc
class _$HighlightSlotEntityCopyWithImpl<$Res>
    implements $HighlightSlotEntityCopyWith<$Res> {
  _$HighlightSlotEntityCopyWithImpl(this._self, this._then);

  final HighlightSlotEntity _self;
  final $Res Function(HighlightSlotEntity) _then;

/// Create a copy of HighlightSlotEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? collectionId = null,Object? slotIndex = null,Object? collectibleId = freezed,Object? isLocked = null,Object? updatedAt = null,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,collectionId: null == collectionId ? _self.collectionId : collectionId // ignore: cast_nullable_to_non_nullable
as int,slotIndex: null == slotIndex ? _self.slotIndex : slotIndex // ignore: cast_nullable_to_non_nullable
as int,collectibleId: freezed == collectibleId ? _self.collectibleId : collectibleId // ignore: cast_nullable_to_non_nullable
as int?,isLocked: null == isLocked ? _self.isLocked : isLocked // ignore: cast_nullable_to_non_nullable
as bool,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [HighlightSlotEntity].
extension HighlightSlotEntityPatterns on HighlightSlotEntity {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HighlightSlotEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HighlightSlotEntity() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HighlightSlotEntity value)  $default,){
final _that = this;
switch (_that) {
case _HighlightSlotEntity():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HighlightSlotEntity value)?  $default,){
final _that = this;
switch (_that) {
case _HighlightSlotEntity() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? id,  int collectionId,  int slotIndex,  int? collectibleId,  bool isLocked,  DateTime updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HighlightSlotEntity() when $default != null:
return $default(_that.id,_that.collectionId,_that.slotIndex,_that.collectibleId,_that.isLocked,_that.updatedAt);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? id,  int collectionId,  int slotIndex,  int? collectibleId,  bool isLocked,  DateTime updatedAt)  $default,) {final _that = this;
switch (_that) {
case _HighlightSlotEntity():
return $default(_that.id,_that.collectionId,_that.slotIndex,_that.collectibleId,_that.isLocked,_that.updatedAt);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? id,  int collectionId,  int slotIndex,  int? collectibleId,  bool isLocked,  DateTime updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _HighlightSlotEntity() when $default != null:
return $default(_that.id,_that.collectionId,_that.slotIndex,_that.collectibleId,_that.isLocked,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc


class _HighlightSlotEntity implements HighlightSlotEntity {
  const _HighlightSlotEntity({this.id, required this.collectionId, required this.slotIndex, this.collectibleId, required this.isLocked, required this.updatedAt});
  

@override final  int? id;
@override final  int collectionId;
@override final  int slotIndex;
@override final  int? collectibleId;
@override final  bool isLocked;
@override final  DateTime updatedAt;

/// Create a copy of HighlightSlotEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HighlightSlotEntityCopyWith<_HighlightSlotEntity> get copyWith => __$HighlightSlotEntityCopyWithImpl<_HighlightSlotEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HighlightSlotEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.collectionId, collectionId) || other.collectionId == collectionId)&&(identical(other.slotIndex, slotIndex) || other.slotIndex == slotIndex)&&(identical(other.collectibleId, collectibleId) || other.collectibleId == collectibleId)&&(identical(other.isLocked, isLocked) || other.isLocked == isLocked)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,collectionId,slotIndex,collectibleId,isLocked,updatedAt);

@override
String toString() {
  return 'HighlightSlotEntity(id: $id, collectionId: $collectionId, slotIndex: $slotIndex, collectibleId: $collectibleId, isLocked: $isLocked, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$HighlightSlotEntityCopyWith<$Res> implements $HighlightSlotEntityCopyWith<$Res> {
  factory _$HighlightSlotEntityCopyWith(_HighlightSlotEntity value, $Res Function(_HighlightSlotEntity) _then) = __$HighlightSlotEntityCopyWithImpl;
@override @useResult
$Res call({
 int? id, int collectionId, int slotIndex, int? collectibleId, bool isLocked, DateTime updatedAt
});




}
/// @nodoc
class __$HighlightSlotEntityCopyWithImpl<$Res>
    implements _$HighlightSlotEntityCopyWith<$Res> {
  __$HighlightSlotEntityCopyWithImpl(this._self, this._then);

  final _HighlightSlotEntity _self;
  final $Res Function(_HighlightSlotEntity) _then;

/// Create a copy of HighlightSlotEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? collectionId = null,Object? slotIndex = null,Object? collectibleId = freezed,Object? isLocked = null,Object? updatedAt = null,}) {
  return _then(_HighlightSlotEntity(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,collectionId: null == collectionId ? _self.collectionId : collectionId // ignore: cast_nullable_to_non_nullable
as int,slotIndex: null == slotIndex ? _self.slotIndex : slotIndex // ignore: cast_nullable_to_non_nullable
as int,collectibleId: freezed == collectibleId ? _self.collectibleId : collectibleId // ignore: cast_nullable_to_non_nullable
as int?,isLocked: null == isLocked ? _self.isLocked : isLocked // ignore: cast_nullable_to_non_nullable
as bool,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
