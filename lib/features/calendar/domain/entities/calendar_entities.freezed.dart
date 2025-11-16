// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'calendar_entities.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CalendarCollectionGroup {

 int get collectionId; String get collectionName; String get accentColor; List<CollectibleEntity> get items;
/// Create a copy of CalendarCollectionGroup
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CalendarCollectionGroupCopyWith<CalendarCollectionGroup> get copyWith => _$CalendarCollectionGroupCopyWithImpl<CalendarCollectionGroup>(this as CalendarCollectionGroup, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CalendarCollectionGroup&&(identical(other.collectionId, collectionId) || other.collectionId == collectionId)&&(identical(other.collectionName, collectionName) || other.collectionName == collectionName)&&(identical(other.accentColor, accentColor) || other.accentColor == accentColor)&&const DeepCollectionEquality().equals(other.items, items));
}


@override
int get hashCode => Object.hash(runtimeType,collectionId,collectionName,accentColor,const DeepCollectionEquality().hash(items));

@override
String toString() {
  return 'CalendarCollectionGroup(collectionId: $collectionId, collectionName: $collectionName, accentColor: $accentColor, items: $items)';
}


}

/// @nodoc
abstract mixin class $CalendarCollectionGroupCopyWith<$Res>  {
  factory $CalendarCollectionGroupCopyWith(CalendarCollectionGroup value, $Res Function(CalendarCollectionGroup) _then) = _$CalendarCollectionGroupCopyWithImpl;
@useResult
$Res call({
 int collectionId, String collectionName, String accentColor, List<CollectibleEntity> items
});




}
/// @nodoc
class _$CalendarCollectionGroupCopyWithImpl<$Res>
    implements $CalendarCollectionGroupCopyWith<$Res> {
  _$CalendarCollectionGroupCopyWithImpl(this._self, this._then);

  final CalendarCollectionGroup _self;
  final $Res Function(CalendarCollectionGroup) _then;

/// Create a copy of CalendarCollectionGroup
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? collectionId = null,Object? collectionName = null,Object? accentColor = null,Object? items = null,}) {
  return _then(_self.copyWith(
collectionId: null == collectionId ? _self.collectionId : collectionId // ignore: cast_nullable_to_non_nullable
as int,collectionName: null == collectionName ? _self.collectionName : collectionName // ignore: cast_nullable_to_non_nullable
as String,accentColor: null == accentColor ? _self.accentColor : accentColor // ignore: cast_nullable_to_non_nullable
as String,items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<CollectibleEntity>,
  ));
}

}


/// Adds pattern-matching-related methods to [CalendarCollectionGroup].
extension CalendarCollectionGroupPatterns on CalendarCollectionGroup {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CalendarCollectionGroup value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CalendarCollectionGroup() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CalendarCollectionGroup value)  $default,){
final _that = this;
switch (_that) {
case _CalendarCollectionGroup():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CalendarCollectionGroup value)?  $default,){
final _that = this;
switch (_that) {
case _CalendarCollectionGroup() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int collectionId,  String collectionName,  String accentColor,  List<CollectibleEntity> items)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CalendarCollectionGroup() when $default != null:
return $default(_that.collectionId,_that.collectionName,_that.accentColor,_that.items);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int collectionId,  String collectionName,  String accentColor,  List<CollectibleEntity> items)  $default,) {final _that = this;
switch (_that) {
case _CalendarCollectionGroup():
return $default(_that.collectionId,_that.collectionName,_that.accentColor,_that.items);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int collectionId,  String collectionName,  String accentColor,  List<CollectibleEntity> items)?  $default,) {final _that = this;
switch (_that) {
case _CalendarCollectionGroup() when $default != null:
return $default(_that.collectionId,_that.collectionName,_that.accentColor,_that.items);case _:
  return null;

}
}

}

/// @nodoc


class _CalendarCollectionGroup implements CalendarCollectionGroup {
  const _CalendarCollectionGroup({required this.collectionId, required this.collectionName, required this.accentColor, required final  List<CollectibleEntity> items}): _items = items;
  

@override final  int collectionId;
@override final  String collectionName;
@override final  String accentColor;
 final  List<CollectibleEntity> _items;
@override List<CollectibleEntity> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}


/// Create a copy of CalendarCollectionGroup
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CalendarCollectionGroupCopyWith<_CalendarCollectionGroup> get copyWith => __$CalendarCollectionGroupCopyWithImpl<_CalendarCollectionGroup>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CalendarCollectionGroup&&(identical(other.collectionId, collectionId) || other.collectionId == collectionId)&&(identical(other.collectionName, collectionName) || other.collectionName == collectionName)&&(identical(other.accentColor, accentColor) || other.accentColor == accentColor)&&const DeepCollectionEquality().equals(other._items, _items));
}


@override
int get hashCode => Object.hash(runtimeType,collectionId,collectionName,accentColor,const DeepCollectionEquality().hash(_items));

@override
String toString() {
  return 'CalendarCollectionGroup(collectionId: $collectionId, collectionName: $collectionName, accentColor: $accentColor, items: $items)';
}


}

/// @nodoc
abstract mixin class _$CalendarCollectionGroupCopyWith<$Res> implements $CalendarCollectionGroupCopyWith<$Res> {
  factory _$CalendarCollectionGroupCopyWith(_CalendarCollectionGroup value, $Res Function(_CalendarCollectionGroup) _then) = __$CalendarCollectionGroupCopyWithImpl;
@override @useResult
$Res call({
 int collectionId, String collectionName, String accentColor, List<CollectibleEntity> items
});




}
/// @nodoc
class __$CalendarCollectionGroupCopyWithImpl<$Res>
    implements _$CalendarCollectionGroupCopyWith<$Res> {
  __$CalendarCollectionGroupCopyWithImpl(this._self, this._then);

  final _CalendarCollectionGroup _self;
  final $Res Function(_CalendarCollectionGroup) _then;

/// Create a copy of CalendarCollectionGroup
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? collectionId = null,Object? collectionName = null,Object? accentColor = null,Object? items = null,}) {
  return _then(_CalendarCollectionGroup(
collectionId: null == collectionId ? _self.collectionId : collectionId // ignore: cast_nullable_to_non_nullable
as int,collectionName: null == collectionName ? _self.collectionName : collectionName // ignore: cast_nullable_to_non_nullable
as String,accentColor: null == accentColor ? _self.accentColor : accentColor // ignore: cast_nullable_to_non_nullable
as String,items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<CollectibleEntity>,
  ));
}


}

// dart format on
