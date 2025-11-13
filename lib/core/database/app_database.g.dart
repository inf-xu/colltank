// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $FrameStylesTable extends FrameStyles
    with TableInfo<$FrameStylesTable, FrameStyleRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FrameStylesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _assetPathMeta = const VerificationMeta(
    'assetPath',
  );
  @override
  late final GeneratedColumn<String> assetPath = GeneratedColumn<String>(
    'asset_path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _overlayMaskPathMeta = const VerificationMeta(
    'overlayMaskPath',
  );
  @override
  late final GeneratedColumn<String> overlayMaskPath = GeneratedColumn<String>(
    'overlay_mask_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _gridLineColorMeta = const VerificationMeta(
    'gridLineColor',
  );
  @override
  late final GeneratedColumn<String> gridLineColor = GeneratedColumn<String>(
    'grid_line_color',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('#FFFFFFFF'),
  );
  static const VerificationMeta _backgroundColorMeta = const VerificationMeta(
    'backgroundColor',
  );
  @override
  late final GeneratedColumn<String> backgroundColor = GeneratedColumn<String>(
    'background_color',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('#FF000000'),
  );
  static const VerificationMeta _metadataJsonMeta = const VerificationMeta(
    'metadataJson',
  );
  @override
  late final GeneratedColumn<String> metadataJson = GeneratedColumn<String>(
    'metadata_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('{}'),
  );
  static const VerificationMeta _supportedLayoutMeta = const VerificationMeta(
    'supportedLayout',
  );
  @override
  late final GeneratedColumn<String> supportedLayout = GeneratedColumn<String>(
    'supported_layout',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('["3x3"]'),
  );
  static const VerificationMeta _isBuiltinMeta = const VerificationMeta(
    'isBuiltin',
  );
  @override
  late final GeneratedColumn<bool> isBuiltin = GeneratedColumn<bool>(
    'is_builtin',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_builtin" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    assetPath,
    overlayMaskPath,
    gridLineColor,
    backgroundColor,
    metadataJson,
    supportedLayout,
    isBuiltin,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'frame_styles';
  @override
  VerificationContext validateIntegrity(
    Insertable<FrameStyleRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('asset_path')) {
      context.handle(
        _assetPathMeta,
        assetPath.isAcceptableOrUnknown(data['asset_path']!, _assetPathMeta),
      );
    } else if (isInserting) {
      context.missing(_assetPathMeta);
    }
    if (data.containsKey('overlay_mask_path')) {
      context.handle(
        _overlayMaskPathMeta,
        overlayMaskPath.isAcceptableOrUnknown(
          data['overlay_mask_path']!,
          _overlayMaskPathMeta,
        ),
      );
    }
    if (data.containsKey('grid_line_color')) {
      context.handle(
        _gridLineColorMeta,
        gridLineColor.isAcceptableOrUnknown(
          data['grid_line_color']!,
          _gridLineColorMeta,
        ),
      );
    }
    if (data.containsKey('background_color')) {
      context.handle(
        _backgroundColorMeta,
        backgroundColor.isAcceptableOrUnknown(
          data['background_color']!,
          _backgroundColorMeta,
        ),
      );
    }
    if (data.containsKey('metadata_json')) {
      context.handle(
        _metadataJsonMeta,
        metadataJson.isAcceptableOrUnknown(
          data['metadata_json']!,
          _metadataJsonMeta,
        ),
      );
    }
    if (data.containsKey('supported_layout')) {
      context.handle(
        _supportedLayoutMeta,
        supportedLayout.isAcceptableOrUnknown(
          data['supported_layout']!,
          _supportedLayoutMeta,
        ),
      );
    }
    if (data.containsKey('is_builtin')) {
      context.handle(
        _isBuiltinMeta,
        isBuiltin.isAcceptableOrUnknown(data['is_builtin']!, _isBuiltinMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FrameStyleRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FrameStyleRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      assetPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}asset_path'],
      )!,
      overlayMaskPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}overlay_mask_path'],
      ),
      gridLineColor: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}grid_line_color'],
      )!,
      backgroundColor: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}background_color'],
      )!,
      metadataJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}metadata_json'],
      )!,
      supportedLayout: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}supported_layout'],
      )!,
      isBuiltin: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_builtin'],
      )!,
    );
  }

  @override
  $FrameStylesTable createAlias(String alias) {
    return $FrameStylesTable(attachedDatabase, alias);
  }
}

class FrameStyleRow extends DataClass implements Insertable<FrameStyleRow> {
  final int id;
  final String name;
  final String assetPath;
  final String? overlayMaskPath;
  final String gridLineColor;
  final String backgroundColor;
  final String metadataJson;
  final String supportedLayout;
  final bool isBuiltin;
  const FrameStyleRow({
    required this.id,
    required this.name,
    required this.assetPath,
    this.overlayMaskPath,
    required this.gridLineColor,
    required this.backgroundColor,
    required this.metadataJson,
    required this.supportedLayout,
    required this.isBuiltin,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['asset_path'] = Variable<String>(assetPath);
    if (!nullToAbsent || overlayMaskPath != null) {
      map['overlay_mask_path'] = Variable<String>(overlayMaskPath);
    }
    map['grid_line_color'] = Variable<String>(gridLineColor);
    map['background_color'] = Variable<String>(backgroundColor);
    map['metadata_json'] = Variable<String>(metadataJson);
    map['supported_layout'] = Variable<String>(supportedLayout);
    map['is_builtin'] = Variable<bool>(isBuiltin);
    return map;
  }

  FrameStylesCompanion toCompanion(bool nullToAbsent) {
    return FrameStylesCompanion(
      id: Value(id),
      name: Value(name),
      assetPath: Value(assetPath),
      overlayMaskPath: overlayMaskPath == null && nullToAbsent
          ? const Value.absent()
          : Value(overlayMaskPath),
      gridLineColor: Value(gridLineColor),
      backgroundColor: Value(backgroundColor),
      metadataJson: Value(metadataJson),
      supportedLayout: Value(supportedLayout),
      isBuiltin: Value(isBuiltin),
    );
  }

  factory FrameStyleRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FrameStyleRow(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      assetPath: serializer.fromJson<String>(json['assetPath']),
      overlayMaskPath: serializer.fromJson<String?>(json['overlayMaskPath']),
      gridLineColor: serializer.fromJson<String>(json['gridLineColor']),
      backgroundColor: serializer.fromJson<String>(json['backgroundColor']),
      metadataJson: serializer.fromJson<String>(json['metadataJson']),
      supportedLayout: serializer.fromJson<String>(json['supportedLayout']),
      isBuiltin: serializer.fromJson<bool>(json['isBuiltin']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'assetPath': serializer.toJson<String>(assetPath),
      'overlayMaskPath': serializer.toJson<String?>(overlayMaskPath),
      'gridLineColor': serializer.toJson<String>(gridLineColor),
      'backgroundColor': serializer.toJson<String>(backgroundColor),
      'metadataJson': serializer.toJson<String>(metadataJson),
      'supportedLayout': serializer.toJson<String>(supportedLayout),
      'isBuiltin': serializer.toJson<bool>(isBuiltin),
    };
  }

  FrameStyleRow copyWith({
    int? id,
    String? name,
    String? assetPath,
    Value<String?> overlayMaskPath = const Value.absent(),
    String? gridLineColor,
    String? backgroundColor,
    String? metadataJson,
    String? supportedLayout,
    bool? isBuiltin,
  }) => FrameStyleRow(
    id: id ?? this.id,
    name: name ?? this.name,
    assetPath: assetPath ?? this.assetPath,
    overlayMaskPath: overlayMaskPath.present
        ? overlayMaskPath.value
        : this.overlayMaskPath,
    gridLineColor: gridLineColor ?? this.gridLineColor,
    backgroundColor: backgroundColor ?? this.backgroundColor,
    metadataJson: metadataJson ?? this.metadataJson,
    supportedLayout: supportedLayout ?? this.supportedLayout,
    isBuiltin: isBuiltin ?? this.isBuiltin,
  );
  FrameStyleRow copyWithCompanion(FrameStylesCompanion data) {
    return FrameStyleRow(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      assetPath: data.assetPath.present ? data.assetPath.value : this.assetPath,
      overlayMaskPath: data.overlayMaskPath.present
          ? data.overlayMaskPath.value
          : this.overlayMaskPath,
      gridLineColor: data.gridLineColor.present
          ? data.gridLineColor.value
          : this.gridLineColor,
      backgroundColor: data.backgroundColor.present
          ? data.backgroundColor.value
          : this.backgroundColor,
      metadataJson: data.metadataJson.present
          ? data.metadataJson.value
          : this.metadataJson,
      supportedLayout: data.supportedLayout.present
          ? data.supportedLayout.value
          : this.supportedLayout,
      isBuiltin: data.isBuiltin.present ? data.isBuiltin.value : this.isBuiltin,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FrameStyleRow(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('assetPath: $assetPath, ')
          ..write('overlayMaskPath: $overlayMaskPath, ')
          ..write('gridLineColor: $gridLineColor, ')
          ..write('backgroundColor: $backgroundColor, ')
          ..write('metadataJson: $metadataJson, ')
          ..write('supportedLayout: $supportedLayout, ')
          ..write('isBuiltin: $isBuiltin')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    assetPath,
    overlayMaskPath,
    gridLineColor,
    backgroundColor,
    metadataJson,
    supportedLayout,
    isBuiltin,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FrameStyleRow &&
          other.id == this.id &&
          other.name == this.name &&
          other.assetPath == this.assetPath &&
          other.overlayMaskPath == this.overlayMaskPath &&
          other.gridLineColor == this.gridLineColor &&
          other.backgroundColor == this.backgroundColor &&
          other.metadataJson == this.metadataJson &&
          other.supportedLayout == this.supportedLayout &&
          other.isBuiltin == this.isBuiltin);
}

class FrameStylesCompanion extends UpdateCompanion<FrameStyleRow> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> assetPath;
  final Value<String?> overlayMaskPath;
  final Value<String> gridLineColor;
  final Value<String> backgroundColor;
  final Value<String> metadataJson;
  final Value<String> supportedLayout;
  final Value<bool> isBuiltin;
  const FrameStylesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.assetPath = const Value.absent(),
    this.overlayMaskPath = const Value.absent(),
    this.gridLineColor = const Value.absent(),
    this.backgroundColor = const Value.absent(),
    this.metadataJson = const Value.absent(),
    this.supportedLayout = const Value.absent(),
    this.isBuiltin = const Value.absent(),
  });
  FrameStylesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String assetPath,
    this.overlayMaskPath = const Value.absent(),
    this.gridLineColor = const Value.absent(),
    this.backgroundColor = const Value.absent(),
    this.metadataJson = const Value.absent(),
    this.supportedLayout = const Value.absent(),
    this.isBuiltin = const Value.absent(),
  }) : name = Value(name),
       assetPath = Value(assetPath);
  static Insertable<FrameStyleRow> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? assetPath,
    Expression<String>? overlayMaskPath,
    Expression<String>? gridLineColor,
    Expression<String>? backgroundColor,
    Expression<String>? metadataJson,
    Expression<String>? supportedLayout,
    Expression<bool>? isBuiltin,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (assetPath != null) 'asset_path': assetPath,
      if (overlayMaskPath != null) 'overlay_mask_path': overlayMaskPath,
      if (gridLineColor != null) 'grid_line_color': gridLineColor,
      if (backgroundColor != null) 'background_color': backgroundColor,
      if (metadataJson != null) 'metadata_json': metadataJson,
      if (supportedLayout != null) 'supported_layout': supportedLayout,
      if (isBuiltin != null) 'is_builtin': isBuiltin,
    });
  }

  FrameStylesCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? assetPath,
    Value<String?>? overlayMaskPath,
    Value<String>? gridLineColor,
    Value<String>? backgroundColor,
    Value<String>? metadataJson,
    Value<String>? supportedLayout,
    Value<bool>? isBuiltin,
  }) {
    return FrameStylesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      assetPath: assetPath ?? this.assetPath,
      overlayMaskPath: overlayMaskPath ?? this.overlayMaskPath,
      gridLineColor: gridLineColor ?? this.gridLineColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      metadataJson: metadataJson ?? this.metadataJson,
      supportedLayout: supportedLayout ?? this.supportedLayout,
      isBuiltin: isBuiltin ?? this.isBuiltin,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (assetPath.present) {
      map['asset_path'] = Variable<String>(assetPath.value);
    }
    if (overlayMaskPath.present) {
      map['overlay_mask_path'] = Variable<String>(overlayMaskPath.value);
    }
    if (gridLineColor.present) {
      map['grid_line_color'] = Variable<String>(gridLineColor.value);
    }
    if (backgroundColor.present) {
      map['background_color'] = Variable<String>(backgroundColor.value);
    }
    if (metadataJson.present) {
      map['metadata_json'] = Variable<String>(metadataJson.value);
    }
    if (supportedLayout.present) {
      map['supported_layout'] = Variable<String>(supportedLayout.value);
    }
    if (isBuiltin.present) {
      map['is_builtin'] = Variable<bool>(isBuiltin.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FrameStylesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('assetPath: $assetPath, ')
          ..write('overlayMaskPath: $overlayMaskPath, ')
          ..write('gridLineColor: $gridLineColor, ')
          ..write('backgroundColor: $backgroundColor, ')
          ..write('metadataJson: $metadataJson, ')
          ..write('supportedLayout: $supportedLayout, ')
          ..write('isBuiltin: $isBuiltin')
          ..write(')'))
        .toString();
  }
}

class $CollectionsTable extends Collections
    with TableInfo<$CollectionsTable, CollectionRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CollectionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sortIndexMeta = const VerificationMeta(
    'sortIndex',
  );
  @override
  late final GeneratedColumn<int> sortIndex = GeneratedColumn<int>(
    'sort_index',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _frameStyleIdMeta = const VerificationMeta(
    'frameStyleId',
  );
  @override
  late final GeneratedColumn<int> frameStyleId = GeneratedColumn<int>(
    'frame_style_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES frame_styles (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _coverPreviewPathMeta = const VerificationMeta(
    'coverPreviewPath',
  );
  @override
  late final GeneratedColumn<String> coverPreviewPath = GeneratedColumn<String>(
    'cover_preview_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _coverUpdatedAtMeta = const VerificationMeta(
    'coverUpdatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> coverUpdatedAt =
      GeneratedColumn<DateTime>(
        'cover_updated_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _accentColorMeta = const VerificationMeta(
    'accentColor',
  );
  @override
  late final GeneratedColumn<String> accentColor = GeneratedColumn<String>(
    'accent_color',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('#FFA726'),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    description,
    sortIndex,
    frameStyleId,
    coverPreviewPath,
    coverUpdatedAt,
    accentColor,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'collections';
  @override
  VerificationContext validateIntegrity(
    Insertable<CollectionRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('sort_index')) {
      context.handle(
        _sortIndexMeta,
        sortIndex.isAcceptableOrUnknown(data['sort_index']!, _sortIndexMeta),
      );
    }
    if (data.containsKey('frame_style_id')) {
      context.handle(
        _frameStyleIdMeta,
        frameStyleId.isAcceptableOrUnknown(
          data['frame_style_id']!,
          _frameStyleIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_frameStyleIdMeta);
    }
    if (data.containsKey('cover_preview_path')) {
      context.handle(
        _coverPreviewPathMeta,
        coverPreviewPath.isAcceptableOrUnknown(
          data['cover_preview_path']!,
          _coverPreviewPathMeta,
        ),
      );
    }
    if (data.containsKey('cover_updated_at')) {
      context.handle(
        _coverUpdatedAtMeta,
        coverUpdatedAt.isAcceptableOrUnknown(
          data['cover_updated_at']!,
          _coverUpdatedAtMeta,
        ),
      );
    }
    if (data.containsKey('accent_color')) {
      context.handle(
        _accentColorMeta,
        accentColor.isAcceptableOrUnknown(
          data['accent_color']!,
          _accentColorMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CollectionRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CollectionRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      sortIndex: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_index'],
      )!,
      frameStyleId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}frame_style_id'],
      )!,
      coverPreviewPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cover_preview_path'],
      ),
      coverUpdatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}cover_updated_at'],
      ),
      accentColor: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}accent_color'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $CollectionsTable createAlias(String alias) {
    return $CollectionsTable(attachedDatabase, alias);
  }
}

class CollectionRow extends DataClass implements Insertable<CollectionRow> {
  final int id;
  final String name;
  final String? description;
  final int sortIndex;
  final int frameStyleId;
  final String? coverPreviewPath;
  final DateTime? coverUpdatedAt;
  final String accentColor;
  final DateTime createdAt;
  final DateTime updatedAt;
  const CollectionRow({
    required this.id,
    required this.name,
    this.description,
    required this.sortIndex,
    required this.frameStyleId,
    this.coverPreviewPath,
    this.coverUpdatedAt,
    required this.accentColor,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['sort_index'] = Variable<int>(sortIndex);
    map['frame_style_id'] = Variable<int>(frameStyleId);
    if (!nullToAbsent || coverPreviewPath != null) {
      map['cover_preview_path'] = Variable<String>(coverPreviewPath);
    }
    if (!nullToAbsent || coverUpdatedAt != null) {
      map['cover_updated_at'] = Variable<DateTime>(coverUpdatedAt);
    }
    map['accent_color'] = Variable<String>(accentColor);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  CollectionsCompanion toCompanion(bool nullToAbsent) {
    return CollectionsCompanion(
      id: Value(id),
      name: Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      sortIndex: Value(sortIndex),
      frameStyleId: Value(frameStyleId),
      coverPreviewPath: coverPreviewPath == null && nullToAbsent
          ? const Value.absent()
          : Value(coverPreviewPath),
      coverUpdatedAt: coverUpdatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(coverUpdatedAt),
      accentColor: Value(accentColor),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory CollectionRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CollectionRow(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
      sortIndex: serializer.fromJson<int>(json['sortIndex']),
      frameStyleId: serializer.fromJson<int>(json['frameStyleId']),
      coverPreviewPath: serializer.fromJson<String?>(json['coverPreviewPath']),
      coverUpdatedAt: serializer.fromJson<DateTime?>(json['coverUpdatedAt']),
      accentColor: serializer.fromJson<String>(json['accentColor']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String?>(description),
      'sortIndex': serializer.toJson<int>(sortIndex),
      'frameStyleId': serializer.toJson<int>(frameStyleId),
      'coverPreviewPath': serializer.toJson<String?>(coverPreviewPath),
      'coverUpdatedAt': serializer.toJson<DateTime?>(coverUpdatedAt),
      'accentColor': serializer.toJson<String>(accentColor),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  CollectionRow copyWith({
    int? id,
    String? name,
    Value<String?> description = const Value.absent(),
    int? sortIndex,
    int? frameStyleId,
    Value<String?> coverPreviewPath = const Value.absent(),
    Value<DateTime?> coverUpdatedAt = const Value.absent(),
    String? accentColor,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => CollectionRow(
    id: id ?? this.id,
    name: name ?? this.name,
    description: description.present ? description.value : this.description,
    sortIndex: sortIndex ?? this.sortIndex,
    frameStyleId: frameStyleId ?? this.frameStyleId,
    coverPreviewPath: coverPreviewPath.present
        ? coverPreviewPath.value
        : this.coverPreviewPath,
    coverUpdatedAt: coverUpdatedAt.present
        ? coverUpdatedAt.value
        : this.coverUpdatedAt,
    accentColor: accentColor ?? this.accentColor,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  CollectionRow copyWithCompanion(CollectionsCompanion data) {
    return CollectionRow(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      description: data.description.present
          ? data.description.value
          : this.description,
      sortIndex: data.sortIndex.present ? data.sortIndex.value : this.sortIndex,
      frameStyleId: data.frameStyleId.present
          ? data.frameStyleId.value
          : this.frameStyleId,
      coverPreviewPath: data.coverPreviewPath.present
          ? data.coverPreviewPath.value
          : this.coverPreviewPath,
      coverUpdatedAt: data.coverUpdatedAt.present
          ? data.coverUpdatedAt.value
          : this.coverUpdatedAt,
      accentColor: data.accentColor.present
          ? data.accentColor.value
          : this.accentColor,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CollectionRow(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('sortIndex: $sortIndex, ')
          ..write('frameStyleId: $frameStyleId, ')
          ..write('coverPreviewPath: $coverPreviewPath, ')
          ..write('coverUpdatedAt: $coverUpdatedAt, ')
          ..write('accentColor: $accentColor, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    description,
    sortIndex,
    frameStyleId,
    coverPreviewPath,
    coverUpdatedAt,
    accentColor,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CollectionRow &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          other.sortIndex == this.sortIndex &&
          other.frameStyleId == this.frameStyleId &&
          other.coverPreviewPath == this.coverPreviewPath &&
          other.coverUpdatedAt == this.coverUpdatedAt &&
          other.accentColor == this.accentColor &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class CollectionsCompanion extends UpdateCompanion<CollectionRow> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> description;
  final Value<int> sortIndex;
  final Value<int> frameStyleId;
  final Value<String?> coverPreviewPath;
  final Value<DateTime?> coverUpdatedAt;
  final Value<String> accentColor;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const CollectionsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.sortIndex = const Value.absent(),
    this.frameStyleId = const Value.absent(),
    this.coverPreviewPath = const Value.absent(),
    this.coverUpdatedAt = const Value.absent(),
    this.accentColor = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  CollectionsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.description = const Value.absent(),
    this.sortIndex = const Value.absent(),
    required int frameStyleId,
    this.coverPreviewPath = const Value.absent(),
    this.coverUpdatedAt = const Value.absent(),
    this.accentColor = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : name = Value(name),
       frameStyleId = Value(frameStyleId);
  static Insertable<CollectionRow> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? description,
    Expression<int>? sortIndex,
    Expression<int>? frameStyleId,
    Expression<String>? coverPreviewPath,
    Expression<DateTime>? coverUpdatedAt,
    Expression<String>? accentColor,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (sortIndex != null) 'sort_index': sortIndex,
      if (frameStyleId != null) 'frame_style_id': frameStyleId,
      if (coverPreviewPath != null) 'cover_preview_path': coverPreviewPath,
      if (coverUpdatedAt != null) 'cover_updated_at': coverUpdatedAt,
      if (accentColor != null) 'accent_color': accentColor,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  CollectionsCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String?>? description,
    Value<int>? sortIndex,
    Value<int>? frameStyleId,
    Value<String?>? coverPreviewPath,
    Value<DateTime?>? coverUpdatedAt,
    Value<String>? accentColor,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return CollectionsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      sortIndex: sortIndex ?? this.sortIndex,
      frameStyleId: frameStyleId ?? this.frameStyleId,
      coverPreviewPath: coverPreviewPath ?? this.coverPreviewPath,
      coverUpdatedAt: coverUpdatedAt ?? this.coverUpdatedAt,
      accentColor: accentColor ?? this.accentColor,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (sortIndex.present) {
      map['sort_index'] = Variable<int>(sortIndex.value);
    }
    if (frameStyleId.present) {
      map['frame_style_id'] = Variable<int>(frameStyleId.value);
    }
    if (coverPreviewPath.present) {
      map['cover_preview_path'] = Variable<String>(coverPreviewPath.value);
    }
    if (coverUpdatedAt.present) {
      map['cover_updated_at'] = Variable<DateTime>(coverUpdatedAt.value);
    }
    if (accentColor.present) {
      map['accent_color'] = Variable<String>(accentColor.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CollectionsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('sortIndex: $sortIndex, ')
          ..write('frameStyleId: $frameStyleId, ')
          ..write('coverPreviewPath: $coverPreviewPath, ')
          ..write('coverUpdatedAt: $coverUpdatedAt, ')
          ..write('accentColor: $accentColor, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $CollectiblesTable extends Collectibles
    with TableInfo<$CollectiblesTable, CollectibleRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CollectiblesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _collectionIdMeta = const VerificationMeta(
    'collectionId',
  );
  @override
  late final GeneratedColumn<int> collectionId = GeneratedColumn<int>(
    'collection_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES collections (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _relativePathMeta = const VerificationMeta(
    'relativePath',
  );
  @override
  late final GeneratedColumn<String> relativePath = GeneratedColumn<String>(
    'relative_path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _thumbnailPathMeta = const VerificationMeta(
    'thumbnailPath',
  );
  @override
  late final GeneratedColumn<String> thumbnailPath = GeneratedColumn<String>(
    'thumbnail_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _fileHashMeta = const VerificationMeta(
    'fileHash',
  );
  @override
  late final GeneratedColumn<String> fileHash = GeneratedColumn<String>(
    'file_hash',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _fileSizeBytesMeta = const VerificationMeta(
    'fileSizeBytes',
  );
  @override
  late final GeneratedColumn<int> fileSizeBytes = GeneratedColumn<int>(
    'file_size_bytes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _displayNameMeta = const VerificationMeta(
    'displayName',
  );
  @override
  late final GeneratedColumn<String> displayName = GeneratedColumn<String>(
    'display_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _storyMeta = const VerificationMeta('story');
  @override
  late final GeneratedColumn<String> story = GeneratedColumn<String>(
    'story',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _moodCodePointMeta = const VerificationMeta(
    'moodCodePoint',
  );
  @override
  late final GeneratedColumn<int> moodCodePoint = GeneratedColumn<int>(
    'mood_code_point',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _moodFontFamilyMeta = const VerificationMeta(
    'moodFontFamily',
  );
  @override
  late final GeneratedColumn<String> moodFontFamily = GeneratedColumn<String>(
    'mood_font_family',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('CupertinoIcons'),
  );
  static const VerificationMeta _moodPackageMeta = const VerificationMeta(
    'moodPackage',
  );
  @override
  late final GeneratedColumn<String> moodPackage = GeneratedColumn<String>(
    'mood_package',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _moodColorMeta = const VerificationMeta(
    'moodColor',
  );
  @override
  late final GeneratedColumn<String> moodColor = GeneratedColumn<String>(
    'mood_color',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('#FFFFFFFF'),
  );
  static const VerificationMeta _capturedAtMeta = const VerificationMeta(
    'capturedAt',
  );
  @override
  late final GeneratedColumn<DateTime> capturedAt = GeneratedColumn<DateTime>(
    'captured_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _capturedDateMeta = const VerificationMeta(
    'capturedDate',
  );
  @override
  late final GeneratedColumn<DateTime> capturedDate = GeneratedColumn<DateTime>(
    'captured_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _allowHighlightMeta = const VerificationMeta(
    'allowHighlight',
  );
  @override
  late final GeneratedColumn<bool> allowHighlight = GeneratedColumn<bool>(
    'allow_highlight',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("allow_highlight" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _sortWeightMeta = const VerificationMeta(
    'sortWeight',
  );
  @override
  late final GeneratedColumn<int> sortWeight = GeneratedColumn<int>(
    'sort_weight',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _isArchivedMeta = const VerificationMeta(
    'isArchived',
  );
  @override
  late final GeneratedColumn<bool> isArchived = GeneratedColumn<bool>(
    'is_archived',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_archived" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    collectionId,
    relativePath,
    thumbnailPath,
    fileHash,
    fileSizeBytes,
    displayName,
    story,
    moodCodePoint,
    moodFontFamily,
    moodPackage,
    moodColor,
    capturedAt,
    capturedDate,
    allowHighlight,
    sortWeight,
    isArchived,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'collectibles';
  @override
  VerificationContext validateIntegrity(
    Insertable<CollectibleRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('collection_id')) {
      context.handle(
        _collectionIdMeta,
        collectionId.isAcceptableOrUnknown(
          data['collection_id']!,
          _collectionIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_collectionIdMeta);
    }
    if (data.containsKey('relative_path')) {
      context.handle(
        _relativePathMeta,
        relativePath.isAcceptableOrUnknown(
          data['relative_path']!,
          _relativePathMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_relativePathMeta);
    }
    if (data.containsKey('thumbnail_path')) {
      context.handle(
        _thumbnailPathMeta,
        thumbnailPath.isAcceptableOrUnknown(
          data['thumbnail_path']!,
          _thumbnailPathMeta,
        ),
      );
    }
    if (data.containsKey('file_hash')) {
      context.handle(
        _fileHashMeta,
        fileHash.isAcceptableOrUnknown(data['file_hash']!, _fileHashMeta),
      );
    }
    if (data.containsKey('file_size_bytes')) {
      context.handle(
        _fileSizeBytesMeta,
        fileSizeBytes.isAcceptableOrUnknown(
          data['file_size_bytes']!,
          _fileSizeBytesMeta,
        ),
      );
    }
    if (data.containsKey('display_name')) {
      context.handle(
        _displayNameMeta,
        displayName.isAcceptableOrUnknown(
          data['display_name']!,
          _displayNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_displayNameMeta);
    }
    if (data.containsKey('story')) {
      context.handle(
        _storyMeta,
        story.isAcceptableOrUnknown(data['story']!, _storyMeta),
      );
    }
    if (data.containsKey('mood_code_point')) {
      context.handle(
        _moodCodePointMeta,
        moodCodePoint.isAcceptableOrUnknown(
          data['mood_code_point']!,
          _moodCodePointMeta,
        ),
      );
    }
    if (data.containsKey('mood_font_family')) {
      context.handle(
        _moodFontFamilyMeta,
        moodFontFamily.isAcceptableOrUnknown(
          data['mood_font_family']!,
          _moodFontFamilyMeta,
        ),
      );
    }
    if (data.containsKey('mood_package')) {
      context.handle(
        _moodPackageMeta,
        moodPackage.isAcceptableOrUnknown(
          data['mood_package']!,
          _moodPackageMeta,
        ),
      );
    }
    if (data.containsKey('mood_color')) {
      context.handle(
        _moodColorMeta,
        moodColor.isAcceptableOrUnknown(data['mood_color']!, _moodColorMeta),
      );
    }
    if (data.containsKey('captured_at')) {
      context.handle(
        _capturedAtMeta,
        capturedAt.isAcceptableOrUnknown(data['captured_at']!, _capturedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_capturedAtMeta);
    }
    if (data.containsKey('captured_date')) {
      context.handle(
        _capturedDateMeta,
        capturedDate.isAcceptableOrUnknown(
          data['captured_date']!,
          _capturedDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_capturedDateMeta);
    }
    if (data.containsKey('allow_highlight')) {
      context.handle(
        _allowHighlightMeta,
        allowHighlight.isAcceptableOrUnknown(
          data['allow_highlight']!,
          _allowHighlightMeta,
        ),
      );
    }
    if (data.containsKey('sort_weight')) {
      context.handle(
        _sortWeightMeta,
        sortWeight.isAcceptableOrUnknown(data['sort_weight']!, _sortWeightMeta),
      );
    }
    if (data.containsKey('is_archived')) {
      context.handle(
        _isArchivedMeta,
        isArchived.isAcceptableOrUnknown(data['is_archived']!, _isArchivedMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CollectibleRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CollectibleRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      collectionId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}collection_id'],
      )!,
      relativePath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}relative_path'],
      )!,
      thumbnailPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}thumbnail_path'],
      ),
      fileHash: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}file_hash'],
      ),
      fileSizeBytes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}file_size_bytes'],
      )!,
      displayName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}display_name'],
      )!,
      story: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}story'],
      ),
      moodCodePoint: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}mood_code_point'],
      )!,
      moodFontFamily: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}mood_font_family'],
      )!,
      moodPackage: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}mood_package'],
      ),
      moodColor: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}mood_color'],
      )!,
      capturedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}captured_at'],
      )!,
      capturedDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}captured_date'],
      )!,
      allowHighlight: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}allow_highlight'],
      )!,
      sortWeight: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_weight'],
      )!,
      isArchived: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_archived'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $CollectiblesTable createAlias(String alias) {
    return $CollectiblesTable(attachedDatabase, alias);
  }
}

class CollectibleRow extends DataClass implements Insertable<CollectibleRow> {
  final int id;
  final int collectionId;
  final String relativePath;
  final String? thumbnailPath;
  final String? fileHash;
  final int fileSizeBytes;
  final String displayName;
  final String? story;
  final int moodCodePoint;
  final String moodFontFamily;
  final String? moodPackage;
  final String moodColor;
  final DateTime capturedAt;
  final DateTime capturedDate;
  final bool allowHighlight;
  final int sortWeight;
  final bool isArchived;
  final DateTime createdAt;
  final DateTime updatedAt;
  const CollectibleRow({
    required this.id,
    required this.collectionId,
    required this.relativePath,
    this.thumbnailPath,
    this.fileHash,
    required this.fileSizeBytes,
    required this.displayName,
    this.story,
    required this.moodCodePoint,
    required this.moodFontFamily,
    this.moodPackage,
    required this.moodColor,
    required this.capturedAt,
    required this.capturedDate,
    required this.allowHighlight,
    required this.sortWeight,
    required this.isArchived,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['collection_id'] = Variable<int>(collectionId);
    map['relative_path'] = Variable<String>(relativePath);
    if (!nullToAbsent || thumbnailPath != null) {
      map['thumbnail_path'] = Variable<String>(thumbnailPath);
    }
    if (!nullToAbsent || fileHash != null) {
      map['file_hash'] = Variable<String>(fileHash);
    }
    map['file_size_bytes'] = Variable<int>(fileSizeBytes);
    map['display_name'] = Variable<String>(displayName);
    if (!nullToAbsent || story != null) {
      map['story'] = Variable<String>(story);
    }
    map['mood_code_point'] = Variable<int>(moodCodePoint);
    map['mood_font_family'] = Variable<String>(moodFontFamily);
    if (!nullToAbsent || moodPackage != null) {
      map['mood_package'] = Variable<String>(moodPackage);
    }
    map['mood_color'] = Variable<String>(moodColor);
    map['captured_at'] = Variable<DateTime>(capturedAt);
    map['captured_date'] = Variable<DateTime>(capturedDate);
    map['allow_highlight'] = Variable<bool>(allowHighlight);
    map['sort_weight'] = Variable<int>(sortWeight);
    map['is_archived'] = Variable<bool>(isArchived);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  CollectiblesCompanion toCompanion(bool nullToAbsent) {
    return CollectiblesCompanion(
      id: Value(id),
      collectionId: Value(collectionId),
      relativePath: Value(relativePath),
      thumbnailPath: thumbnailPath == null && nullToAbsent
          ? const Value.absent()
          : Value(thumbnailPath),
      fileHash: fileHash == null && nullToAbsent
          ? const Value.absent()
          : Value(fileHash),
      fileSizeBytes: Value(fileSizeBytes),
      displayName: Value(displayName),
      story: story == null && nullToAbsent
          ? const Value.absent()
          : Value(story),
      moodCodePoint: Value(moodCodePoint),
      moodFontFamily: Value(moodFontFamily),
      moodPackage: moodPackage == null && nullToAbsent
          ? const Value.absent()
          : Value(moodPackage),
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

  factory CollectibleRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CollectibleRow(
      id: serializer.fromJson<int>(json['id']),
      collectionId: serializer.fromJson<int>(json['collectionId']),
      relativePath: serializer.fromJson<String>(json['relativePath']),
      thumbnailPath: serializer.fromJson<String?>(json['thumbnailPath']),
      fileHash: serializer.fromJson<String?>(json['fileHash']),
      fileSizeBytes: serializer.fromJson<int>(json['fileSizeBytes']),
      displayName: serializer.fromJson<String>(json['displayName']),
      story: serializer.fromJson<String?>(json['story']),
      moodCodePoint: serializer.fromJson<int>(json['moodCodePoint']),
      moodFontFamily: serializer.fromJson<String>(json['moodFontFamily']),
      moodPackage: serializer.fromJson<String?>(json['moodPackage']),
      moodColor: serializer.fromJson<String>(json['moodColor']),
      capturedAt: serializer.fromJson<DateTime>(json['capturedAt']),
      capturedDate: serializer.fromJson<DateTime>(json['capturedDate']),
      allowHighlight: serializer.fromJson<bool>(json['allowHighlight']),
      sortWeight: serializer.fromJson<int>(json['sortWeight']),
      isArchived: serializer.fromJson<bool>(json['isArchived']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'collectionId': serializer.toJson<int>(collectionId),
      'relativePath': serializer.toJson<String>(relativePath),
      'thumbnailPath': serializer.toJson<String?>(thumbnailPath),
      'fileHash': serializer.toJson<String?>(fileHash),
      'fileSizeBytes': serializer.toJson<int>(fileSizeBytes),
      'displayName': serializer.toJson<String>(displayName),
      'story': serializer.toJson<String?>(story),
      'moodCodePoint': serializer.toJson<int>(moodCodePoint),
      'moodFontFamily': serializer.toJson<String>(moodFontFamily),
      'moodPackage': serializer.toJson<String?>(moodPackage),
      'moodColor': serializer.toJson<String>(moodColor),
      'capturedAt': serializer.toJson<DateTime>(capturedAt),
      'capturedDate': serializer.toJson<DateTime>(capturedDate),
      'allowHighlight': serializer.toJson<bool>(allowHighlight),
      'sortWeight': serializer.toJson<int>(sortWeight),
      'isArchived': serializer.toJson<bool>(isArchived),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  CollectibleRow copyWith({
    int? id,
    int? collectionId,
    String? relativePath,
    Value<String?> thumbnailPath = const Value.absent(),
    Value<String?> fileHash = const Value.absent(),
    int? fileSizeBytes,
    String? displayName,
    Value<String?> story = const Value.absent(),
    int? moodCodePoint,
    String? moodFontFamily,
    Value<String?> moodPackage = const Value.absent(),
    String? moodColor,
    DateTime? capturedAt,
    DateTime? capturedDate,
    bool? allowHighlight,
    int? sortWeight,
    bool? isArchived,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => CollectibleRow(
    id: id ?? this.id,
    collectionId: collectionId ?? this.collectionId,
    relativePath: relativePath ?? this.relativePath,
    thumbnailPath: thumbnailPath.present
        ? thumbnailPath.value
        : this.thumbnailPath,
    fileHash: fileHash.present ? fileHash.value : this.fileHash,
    fileSizeBytes: fileSizeBytes ?? this.fileSizeBytes,
    displayName: displayName ?? this.displayName,
    story: story.present ? story.value : this.story,
    moodCodePoint: moodCodePoint ?? this.moodCodePoint,
    moodFontFamily: moodFontFamily ?? this.moodFontFamily,
    moodPackage: moodPackage.present ? moodPackage.value : this.moodPackage,
    moodColor: moodColor ?? this.moodColor,
    capturedAt: capturedAt ?? this.capturedAt,
    capturedDate: capturedDate ?? this.capturedDate,
    allowHighlight: allowHighlight ?? this.allowHighlight,
    sortWeight: sortWeight ?? this.sortWeight,
    isArchived: isArchived ?? this.isArchived,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  CollectibleRow copyWithCompanion(CollectiblesCompanion data) {
    return CollectibleRow(
      id: data.id.present ? data.id.value : this.id,
      collectionId: data.collectionId.present
          ? data.collectionId.value
          : this.collectionId,
      relativePath: data.relativePath.present
          ? data.relativePath.value
          : this.relativePath,
      thumbnailPath: data.thumbnailPath.present
          ? data.thumbnailPath.value
          : this.thumbnailPath,
      fileHash: data.fileHash.present ? data.fileHash.value : this.fileHash,
      fileSizeBytes: data.fileSizeBytes.present
          ? data.fileSizeBytes.value
          : this.fileSizeBytes,
      displayName: data.displayName.present
          ? data.displayName.value
          : this.displayName,
      story: data.story.present ? data.story.value : this.story,
      moodCodePoint: data.moodCodePoint.present
          ? data.moodCodePoint.value
          : this.moodCodePoint,
      moodFontFamily: data.moodFontFamily.present
          ? data.moodFontFamily.value
          : this.moodFontFamily,
      moodPackage: data.moodPackage.present
          ? data.moodPackage.value
          : this.moodPackage,
      moodColor: data.moodColor.present ? data.moodColor.value : this.moodColor,
      capturedAt: data.capturedAt.present
          ? data.capturedAt.value
          : this.capturedAt,
      capturedDate: data.capturedDate.present
          ? data.capturedDate.value
          : this.capturedDate,
      allowHighlight: data.allowHighlight.present
          ? data.allowHighlight.value
          : this.allowHighlight,
      sortWeight: data.sortWeight.present
          ? data.sortWeight.value
          : this.sortWeight,
      isArchived: data.isArchived.present
          ? data.isArchived.value
          : this.isArchived,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CollectibleRow(')
          ..write('id: $id, ')
          ..write('collectionId: $collectionId, ')
          ..write('relativePath: $relativePath, ')
          ..write('thumbnailPath: $thumbnailPath, ')
          ..write('fileHash: $fileHash, ')
          ..write('fileSizeBytes: $fileSizeBytes, ')
          ..write('displayName: $displayName, ')
          ..write('story: $story, ')
          ..write('moodCodePoint: $moodCodePoint, ')
          ..write('moodFontFamily: $moodFontFamily, ')
          ..write('moodPackage: $moodPackage, ')
          ..write('moodColor: $moodColor, ')
          ..write('capturedAt: $capturedAt, ')
          ..write('capturedDate: $capturedDate, ')
          ..write('allowHighlight: $allowHighlight, ')
          ..write('sortWeight: $sortWeight, ')
          ..write('isArchived: $isArchived, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    collectionId,
    relativePath,
    thumbnailPath,
    fileHash,
    fileSizeBytes,
    displayName,
    story,
    moodCodePoint,
    moodFontFamily,
    moodPackage,
    moodColor,
    capturedAt,
    capturedDate,
    allowHighlight,
    sortWeight,
    isArchived,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CollectibleRow &&
          other.id == this.id &&
          other.collectionId == this.collectionId &&
          other.relativePath == this.relativePath &&
          other.thumbnailPath == this.thumbnailPath &&
          other.fileHash == this.fileHash &&
          other.fileSizeBytes == this.fileSizeBytes &&
          other.displayName == this.displayName &&
          other.story == this.story &&
          other.moodCodePoint == this.moodCodePoint &&
          other.moodFontFamily == this.moodFontFamily &&
          other.moodPackage == this.moodPackage &&
          other.moodColor == this.moodColor &&
          other.capturedAt == this.capturedAt &&
          other.capturedDate == this.capturedDate &&
          other.allowHighlight == this.allowHighlight &&
          other.sortWeight == this.sortWeight &&
          other.isArchived == this.isArchived &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class CollectiblesCompanion extends UpdateCompanion<CollectibleRow> {
  final Value<int> id;
  final Value<int> collectionId;
  final Value<String> relativePath;
  final Value<String?> thumbnailPath;
  final Value<String?> fileHash;
  final Value<int> fileSizeBytes;
  final Value<String> displayName;
  final Value<String?> story;
  final Value<int> moodCodePoint;
  final Value<String> moodFontFamily;
  final Value<String?> moodPackage;
  final Value<String> moodColor;
  final Value<DateTime> capturedAt;
  final Value<DateTime> capturedDate;
  final Value<bool> allowHighlight;
  final Value<int> sortWeight;
  final Value<bool> isArchived;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const CollectiblesCompanion({
    this.id = const Value.absent(),
    this.collectionId = const Value.absent(),
    this.relativePath = const Value.absent(),
    this.thumbnailPath = const Value.absent(),
    this.fileHash = const Value.absent(),
    this.fileSizeBytes = const Value.absent(),
    this.displayName = const Value.absent(),
    this.story = const Value.absent(),
    this.moodCodePoint = const Value.absent(),
    this.moodFontFamily = const Value.absent(),
    this.moodPackage = const Value.absent(),
    this.moodColor = const Value.absent(),
    this.capturedAt = const Value.absent(),
    this.capturedDate = const Value.absent(),
    this.allowHighlight = const Value.absent(),
    this.sortWeight = const Value.absent(),
    this.isArchived = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  CollectiblesCompanion.insert({
    this.id = const Value.absent(),
    required int collectionId,
    required String relativePath,
    this.thumbnailPath = const Value.absent(),
    this.fileHash = const Value.absent(),
    this.fileSizeBytes = const Value.absent(),
    required String displayName,
    this.story = const Value.absent(),
    this.moodCodePoint = const Value.absent(),
    this.moodFontFamily = const Value.absent(),
    this.moodPackage = const Value.absent(),
    this.moodColor = const Value.absent(),
    required DateTime capturedAt,
    required DateTime capturedDate,
    this.allowHighlight = const Value.absent(),
    this.sortWeight = const Value.absent(),
    this.isArchived = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : collectionId = Value(collectionId),
       relativePath = Value(relativePath),
       displayName = Value(displayName),
       capturedAt = Value(capturedAt),
       capturedDate = Value(capturedDate);
  static Insertable<CollectibleRow> custom({
    Expression<int>? id,
    Expression<int>? collectionId,
    Expression<String>? relativePath,
    Expression<String>? thumbnailPath,
    Expression<String>? fileHash,
    Expression<int>? fileSizeBytes,
    Expression<String>? displayName,
    Expression<String>? story,
    Expression<int>? moodCodePoint,
    Expression<String>? moodFontFamily,
    Expression<String>? moodPackage,
    Expression<String>? moodColor,
    Expression<DateTime>? capturedAt,
    Expression<DateTime>? capturedDate,
    Expression<bool>? allowHighlight,
    Expression<int>? sortWeight,
    Expression<bool>? isArchived,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (collectionId != null) 'collection_id': collectionId,
      if (relativePath != null) 'relative_path': relativePath,
      if (thumbnailPath != null) 'thumbnail_path': thumbnailPath,
      if (fileHash != null) 'file_hash': fileHash,
      if (fileSizeBytes != null) 'file_size_bytes': fileSizeBytes,
      if (displayName != null) 'display_name': displayName,
      if (story != null) 'story': story,
      if (moodCodePoint != null) 'mood_code_point': moodCodePoint,
      if (moodFontFamily != null) 'mood_font_family': moodFontFamily,
      if (moodPackage != null) 'mood_package': moodPackage,
      if (moodColor != null) 'mood_color': moodColor,
      if (capturedAt != null) 'captured_at': capturedAt,
      if (capturedDate != null) 'captured_date': capturedDate,
      if (allowHighlight != null) 'allow_highlight': allowHighlight,
      if (sortWeight != null) 'sort_weight': sortWeight,
      if (isArchived != null) 'is_archived': isArchived,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  CollectiblesCompanion copyWith({
    Value<int>? id,
    Value<int>? collectionId,
    Value<String>? relativePath,
    Value<String?>? thumbnailPath,
    Value<String?>? fileHash,
    Value<int>? fileSizeBytes,
    Value<String>? displayName,
    Value<String?>? story,
    Value<int>? moodCodePoint,
    Value<String>? moodFontFamily,
    Value<String?>? moodPackage,
    Value<String>? moodColor,
    Value<DateTime>? capturedAt,
    Value<DateTime>? capturedDate,
    Value<bool>? allowHighlight,
    Value<int>? sortWeight,
    Value<bool>? isArchived,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return CollectiblesCompanion(
      id: id ?? this.id,
      collectionId: collectionId ?? this.collectionId,
      relativePath: relativePath ?? this.relativePath,
      thumbnailPath: thumbnailPath ?? this.thumbnailPath,
      fileHash: fileHash ?? this.fileHash,
      fileSizeBytes: fileSizeBytes ?? this.fileSizeBytes,
      displayName: displayName ?? this.displayName,
      story: story ?? this.story,
      moodCodePoint: moodCodePoint ?? this.moodCodePoint,
      moodFontFamily: moodFontFamily ?? this.moodFontFamily,
      moodPackage: moodPackage ?? this.moodPackage,
      moodColor: moodColor ?? this.moodColor,
      capturedAt: capturedAt ?? this.capturedAt,
      capturedDate: capturedDate ?? this.capturedDate,
      allowHighlight: allowHighlight ?? this.allowHighlight,
      sortWeight: sortWeight ?? this.sortWeight,
      isArchived: isArchived ?? this.isArchived,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (collectionId.present) {
      map['collection_id'] = Variable<int>(collectionId.value);
    }
    if (relativePath.present) {
      map['relative_path'] = Variable<String>(relativePath.value);
    }
    if (thumbnailPath.present) {
      map['thumbnail_path'] = Variable<String>(thumbnailPath.value);
    }
    if (fileHash.present) {
      map['file_hash'] = Variable<String>(fileHash.value);
    }
    if (fileSizeBytes.present) {
      map['file_size_bytes'] = Variable<int>(fileSizeBytes.value);
    }
    if (displayName.present) {
      map['display_name'] = Variable<String>(displayName.value);
    }
    if (story.present) {
      map['story'] = Variable<String>(story.value);
    }
    if (moodCodePoint.present) {
      map['mood_code_point'] = Variable<int>(moodCodePoint.value);
    }
    if (moodFontFamily.present) {
      map['mood_font_family'] = Variable<String>(moodFontFamily.value);
    }
    if (moodPackage.present) {
      map['mood_package'] = Variable<String>(moodPackage.value);
    }
    if (moodColor.present) {
      map['mood_color'] = Variable<String>(moodColor.value);
    }
    if (capturedAt.present) {
      map['captured_at'] = Variable<DateTime>(capturedAt.value);
    }
    if (capturedDate.present) {
      map['captured_date'] = Variable<DateTime>(capturedDate.value);
    }
    if (allowHighlight.present) {
      map['allow_highlight'] = Variable<bool>(allowHighlight.value);
    }
    if (sortWeight.present) {
      map['sort_weight'] = Variable<int>(sortWeight.value);
    }
    if (isArchived.present) {
      map['is_archived'] = Variable<bool>(isArchived.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CollectiblesCompanion(')
          ..write('id: $id, ')
          ..write('collectionId: $collectionId, ')
          ..write('relativePath: $relativePath, ')
          ..write('thumbnailPath: $thumbnailPath, ')
          ..write('fileHash: $fileHash, ')
          ..write('fileSizeBytes: $fileSizeBytes, ')
          ..write('displayName: $displayName, ')
          ..write('story: $story, ')
          ..write('moodCodePoint: $moodCodePoint, ')
          ..write('moodFontFamily: $moodFontFamily, ')
          ..write('moodPackage: $moodPackage, ')
          ..write('moodColor: $moodColor, ')
          ..write('capturedAt: $capturedAt, ')
          ..write('capturedDate: $capturedDate, ')
          ..write('allowHighlight: $allowHighlight, ')
          ..write('sortWeight: $sortWeight, ')
          ..write('isArchived: $isArchived, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $HighlightSlotsTable extends HighlightSlots
    with TableInfo<$HighlightSlotsTable, HighlightSlotRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HighlightSlotsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _collectionIdMeta = const VerificationMeta(
    'collectionId',
  );
  @override
  late final GeneratedColumn<int> collectionId = GeneratedColumn<int>(
    'collection_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES collections (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _slotIndexMeta = const VerificationMeta(
    'slotIndex',
  );
  @override
  late final GeneratedColumn<int> slotIndex = GeneratedColumn<int>(
    'slot_index',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _collectibleIdMeta = const VerificationMeta(
    'collectibleId',
  );
  @override
  late final GeneratedColumn<int> collectibleId = GeneratedColumn<int>(
    'collectible_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES collectibles (id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _isLockedMeta = const VerificationMeta(
    'isLocked',
  );
  @override
  late final GeneratedColumn<bool> isLocked = GeneratedColumn<bool>(
    'is_locked',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_locked" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    collectionId,
    slotIndex,
    collectibleId,
    isLocked,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'highlight_slots';
  @override
  VerificationContext validateIntegrity(
    Insertable<HighlightSlotRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('collection_id')) {
      context.handle(
        _collectionIdMeta,
        collectionId.isAcceptableOrUnknown(
          data['collection_id']!,
          _collectionIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_collectionIdMeta);
    }
    if (data.containsKey('slot_index')) {
      context.handle(
        _slotIndexMeta,
        slotIndex.isAcceptableOrUnknown(data['slot_index']!, _slotIndexMeta),
      );
    } else if (isInserting) {
      context.missing(_slotIndexMeta);
    }
    if (data.containsKey('collectible_id')) {
      context.handle(
        _collectibleIdMeta,
        collectibleId.isAcceptableOrUnknown(
          data['collectible_id']!,
          _collectibleIdMeta,
        ),
      );
    }
    if (data.containsKey('is_locked')) {
      context.handle(
        _isLockedMeta,
        isLocked.isAcceptableOrUnknown(data['is_locked']!, _isLockedMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  HighlightSlotRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return HighlightSlotRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      collectionId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}collection_id'],
      )!,
      slotIndex: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}slot_index'],
      )!,
      collectibleId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}collectible_id'],
      ),
      isLocked: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_locked'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $HighlightSlotsTable createAlias(String alias) {
    return $HighlightSlotsTable(attachedDatabase, alias);
  }
}

class HighlightSlotRow extends DataClass
    implements Insertable<HighlightSlotRow> {
  final int id;
  final int collectionId;
  final int slotIndex;
  final int? collectibleId;
  final bool isLocked;
  final DateTime updatedAt;
  const HighlightSlotRow({
    required this.id,
    required this.collectionId,
    required this.slotIndex,
    this.collectibleId,
    required this.isLocked,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['collection_id'] = Variable<int>(collectionId);
    map['slot_index'] = Variable<int>(slotIndex);
    if (!nullToAbsent || collectibleId != null) {
      map['collectible_id'] = Variable<int>(collectibleId);
    }
    map['is_locked'] = Variable<bool>(isLocked);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  HighlightSlotsCompanion toCompanion(bool nullToAbsent) {
    return HighlightSlotsCompanion(
      id: Value(id),
      collectionId: Value(collectionId),
      slotIndex: Value(slotIndex),
      collectibleId: collectibleId == null && nullToAbsent
          ? const Value.absent()
          : Value(collectibleId),
      isLocked: Value(isLocked),
      updatedAt: Value(updatedAt),
    );
  }

  factory HighlightSlotRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return HighlightSlotRow(
      id: serializer.fromJson<int>(json['id']),
      collectionId: serializer.fromJson<int>(json['collectionId']),
      slotIndex: serializer.fromJson<int>(json['slotIndex']),
      collectibleId: serializer.fromJson<int?>(json['collectibleId']),
      isLocked: serializer.fromJson<bool>(json['isLocked']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'collectionId': serializer.toJson<int>(collectionId),
      'slotIndex': serializer.toJson<int>(slotIndex),
      'collectibleId': serializer.toJson<int?>(collectibleId),
      'isLocked': serializer.toJson<bool>(isLocked),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  HighlightSlotRow copyWith({
    int? id,
    int? collectionId,
    int? slotIndex,
    Value<int?> collectibleId = const Value.absent(),
    bool? isLocked,
    DateTime? updatedAt,
  }) => HighlightSlotRow(
    id: id ?? this.id,
    collectionId: collectionId ?? this.collectionId,
    slotIndex: slotIndex ?? this.slotIndex,
    collectibleId: collectibleId.present
        ? collectibleId.value
        : this.collectibleId,
    isLocked: isLocked ?? this.isLocked,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  HighlightSlotRow copyWithCompanion(HighlightSlotsCompanion data) {
    return HighlightSlotRow(
      id: data.id.present ? data.id.value : this.id,
      collectionId: data.collectionId.present
          ? data.collectionId.value
          : this.collectionId,
      slotIndex: data.slotIndex.present ? data.slotIndex.value : this.slotIndex,
      collectibleId: data.collectibleId.present
          ? data.collectibleId.value
          : this.collectibleId,
      isLocked: data.isLocked.present ? data.isLocked.value : this.isLocked,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('HighlightSlotRow(')
          ..write('id: $id, ')
          ..write('collectionId: $collectionId, ')
          ..write('slotIndex: $slotIndex, ')
          ..write('collectibleId: $collectibleId, ')
          ..write('isLocked: $isLocked, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    collectionId,
    slotIndex,
    collectibleId,
    isLocked,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HighlightSlotRow &&
          other.id == this.id &&
          other.collectionId == this.collectionId &&
          other.slotIndex == this.slotIndex &&
          other.collectibleId == this.collectibleId &&
          other.isLocked == this.isLocked &&
          other.updatedAt == this.updatedAt);
}

class HighlightSlotsCompanion extends UpdateCompanion<HighlightSlotRow> {
  final Value<int> id;
  final Value<int> collectionId;
  final Value<int> slotIndex;
  final Value<int?> collectibleId;
  final Value<bool> isLocked;
  final Value<DateTime> updatedAt;
  const HighlightSlotsCompanion({
    this.id = const Value.absent(),
    this.collectionId = const Value.absent(),
    this.slotIndex = const Value.absent(),
    this.collectibleId = const Value.absent(),
    this.isLocked = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  HighlightSlotsCompanion.insert({
    this.id = const Value.absent(),
    required int collectionId,
    required int slotIndex,
    this.collectibleId = const Value.absent(),
    this.isLocked = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : collectionId = Value(collectionId),
       slotIndex = Value(slotIndex);
  static Insertable<HighlightSlotRow> custom({
    Expression<int>? id,
    Expression<int>? collectionId,
    Expression<int>? slotIndex,
    Expression<int>? collectibleId,
    Expression<bool>? isLocked,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (collectionId != null) 'collection_id': collectionId,
      if (slotIndex != null) 'slot_index': slotIndex,
      if (collectibleId != null) 'collectible_id': collectibleId,
      if (isLocked != null) 'is_locked': isLocked,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  HighlightSlotsCompanion copyWith({
    Value<int>? id,
    Value<int>? collectionId,
    Value<int>? slotIndex,
    Value<int?>? collectibleId,
    Value<bool>? isLocked,
    Value<DateTime>? updatedAt,
  }) {
    return HighlightSlotsCompanion(
      id: id ?? this.id,
      collectionId: collectionId ?? this.collectionId,
      slotIndex: slotIndex ?? this.slotIndex,
      collectibleId: collectibleId ?? this.collectibleId,
      isLocked: isLocked ?? this.isLocked,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (collectionId.present) {
      map['collection_id'] = Variable<int>(collectionId.value);
    }
    if (slotIndex.present) {
      map['slot_index'] = Variable<int>(slotIndex.value);
    }
    if (collectibleId.present) {
      map['collectible_id'] = Variable<int>(collectibleId.value);
    }
    if (isLocked.present) {
      map['is_locked'] = Variable<bool>(isLocked.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HighlightSlotsCompanion(')
          ..write('id: $id, ')
          ..write('collectionId: $collectionId, ')
          ..write('slotIndex: $slotIndex, ')
          ..write('collectibleId: $collectibleId, ')
          ..write('isLocked: $isLocked, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $CollectionDailyMetricsTable extends CollectionDailyMetrics
    with TableInfo<$CollectionDailyMetricsTable, CollectionDailyMetricRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CollectionDailyMetricsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _collectionIdMeta = const VerificationMeta(
    'collectionId',
  );
  @override
  late final GeneratedColumn<int> collectionId = GeneratedColumn<int>(
    'collection_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES collections (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _statDateMeta = const VerificationMeta(
    'statDate',
  );
  @override
  late final GeneratedColumn<DateTime> statDate = GeneratedColumn<DateTime>(
    'stat_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _itemCountMeta = const VerificationMeta(
    'itemCount',
  );
  @override
  late final GeneratedColumn<int> itemCount = GeneratedColumn<int>(
    'item_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _firstCollectibleIdMeta =
      const VerificationMeta('firstCollectibleId');
  @override
  late final GeneratedColumn<int> firstCollectibleId = GeneratedColumn<int>(
    'first_collectible_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES collectibles (id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _lastCollectibleIdMeta = const VerificationMeta(
    'lastCollectibleId',
  );
  @override
  late final GeneratedColumn<int> lastCollectibleId = GeneratedColumn<int>(
    'last_collectible_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES collectibles (id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _lastSyncedAtMeta = const VerificationMeta(
    'lastSyncedAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastSyncedAt = GeneratedColumn<DateTime>(
    'last_synced_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    collectionId,
    statDate,
    itemCount,
    firstCollectibleId,
    lastCollectibleId,
    lastSyncedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'collection_daily_metrics';
  @override
  VerificationContext validateIntegrity(
    Insertable<CollectionDailyMetricRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('collection_id')) {
      context.handle(
        _collectionIdMeta,
        collectionId.isAcceptableOrUnknown(
          data['collection_id']!,
          _collectionIdMeta,
        ),
      );
    }
    if (data.containsKey('stat_date')) {
      context.handle(
        _statDateMeta,
        statDate.isAcceptableOrUnknown(data['stat_date']!, _statDateMeta),
      );
    } else if (isInserting) {
      context.missing(_statDateMeta);
    }
    if (data.containsKey('item_count')) {
      context.handle(
        _itemCountMeta,
        itemCount.isAcceptableOrUnknown(data['item_count']!, _itemCountMeta),
      );
    }
    if (data.containsKey('first_collectible_id')) {
      context.handle(
        _firstCollectibleIdMeta,
        firstCollectibleId.isAcceptableOrUnknown(
          data['first_collectible_id']!,
          _firstCollectibleIdMeta,
        ),
      );
    }
    if (data.containsKey('last_collectible_id')) {
      context.handle(
        _lastCollectibleIdMeta,
        lastCollectibleId.isAcceptableOrUnknown(
          data['last_collectible_id']!,
          _lastCollectibleIdMeta,
        ),
      );
    }
    if (data.containsKey('last_synced_at')) {
      context.handle(
        _lastSyncedAtMeta,
        lastSyncedAt.isAcceptableOrUnknown(
          data['last_synced_at']!,
          _lastSyncedAtMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CollectionDailyMetricRow map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CollectionDailyMetricRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      collectionId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}collection_id'],
      ),
      statDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}stat_date'],
      )!,
      itemCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}item_count'],
      )!,
      firstCollectibleId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}first_collectible_id'],
      ),
      lastCollectibleId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}last_collectible_id'],
      ),
      lastSyncedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_synced_at'],
      )!,
    );
  }

  @override
  $CollectionDailyMetricsTable createAlias(String alias) {
    return $CollectionDailyMetricsTable(attachedDatabase, alias);
  }
}

class CollectionDailyMetricRow extends DataClass
    implements Insertable<CollectionDailyMetricRow> {
  final int id;
  final int? collectionId;
  final DateTime statDate;
  final int itemCount;
  final int? firstCollectibleId;
  final int? lastCollectibleId;
  final DateTime lastSyncedAt;
  const CollectionDailyMetricRow({
    required this.id,
    this.collectionId,
    required this.statDate,
    required this.itemCount,
    this.firstCollectibleId,
    this.lastCollectibleId,
    required this.lastSyncedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || collectionId != null) {
      map['collection_id'] = Variable<int>(collectionId);
    }
    map['stat_date'] = Variable<DateTime>(statDate);
    map['item_count'] = Variable<int>(itemCount);
    if (!nullToAbsent || firstCollectibleId != null) {
      map['first_collectible_id'] = Variable<int>(firstCollectibleId);
    }
    if (!nullToAbsent || lastCollectibleId != null) {
      map['last_collectible_id'] = Variable<int>(lastCollectibleId);
    }
    map['last_synced_at'] = Variable<DateTime>(lastSyncedAt);
    return map;
  }

  CollectionDailyMetricsCompanion toCompanion(bool nullToAbsent) {
    return CollectionDailyMetricsCompanion(
      id: Value(id),
      collectionId: collectionId == null && nullToAbsent
          ? const Value.absent()
          : Value(collectionId),
      statDate: Value(statDate),
      itemCount: Value(itemCount),
      firstCollectibleId: firstCollectibleId == null && nullToAbsent
          ? const Value.absent()
          : Value(firstCollectibleId),
      lastCollectibleId: lastCollectibleId == null && nullToAbsent
          ? const Value.absent()
          : Value(lastCollectibleId),
      lastSyncedAt: Value(lastSyncedAt),
    );
  }

  factory CollectionDailyMetricRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CollectionDailyMetricRow(
      id: serializer.fromJson<int>(json['id']),
      collectionId: serializer.fromJson<int?>(json['collectionId']),
      statDate: serializer.fromJson<DateTime>(json['statDate']),
      itemCount: serializer.fromJson<int>(json['itemCount']),
      firstCollectibleId: serializer.fromJson<int?>(json['firstCollectibleId']),
      lastCollectibleId: serializer.fromJson<int?>(json['lastCollectibleId']),
      lastSyncedAt: serializer.fromJson<DateTime>(json['lastSyncedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'collectionId': serializer.toJson<int?>(collectionId),
      'statDate': serializer.toJson<DateTime>(statDate),
      'itemCount': serializer.toJson<int>(itemCount),
      'firstCollectibleId': serializer.toJson<int?>(firstCollectibleId),
      'lastCollectibleId': serializer.toJson<int?>(lastCollectibleId),
      'lastSyncedAt': serializer.toJson<DateTime>(lastSyncedAt),
    };
  }

  CollectionDailyMetricRow copyWith({
    int? id,
    Value<int?> collectionId = const Value.absent(),
    DateTime? statDate,
    int? itemCount,
    Value<int?> firstCollectibleId = const Value.absent(),
    Value<int?> lastCollectibleId = const Value.absent(),
    DateTime? lastSyncedAt,
  }) => CollectionDailyMetricRow(
    id: id ?? this.id,
    collectionId: collectionId.present ? collectionId.value : this.collectionId,
    statDate: statDate ?? this.statDate,
    itemCount: itemCount ?? this.itemCount,
    firstCollectibleId: firstCollectibleId.present
        ? firstCollectibleId.value
        : this.firstCollectibleId,
    lastCollectibleId: lastCollectibleId.present
        ? lastCollectibleId.value
        : this.lastCollectibleId,
    lastSyncedAt: lastSyncedAt ?? this.lastSyncedAt,
  );
  CollectionDailyMetricRow copyWithCompanion(
    CollectionDailyMetricsCompanion data,
  ) {
    return CollectionDailyMetricRow(
      id: data.id.present ? data.id.value : this.id,
      collectionId: data.collectionId.present
          ? data.collectionId.value
          : this.collectionId,
      statDate: data.statDate.present ? data.statDate.value : this.statDate,
      itemCount: data.itemCount.present ? data.itemCount.value : this.itemCount,
      firstCollectibleId: data.firstCollectibleId.present
          ? data.firstCollectibleId.value
          : this.firstCollectibleId,
      lastCollectibleId: data.lastCollectibleId.present
          ? data.lastCollectibleId.value
          : this.lastCollectibleId,
      lastSyncedAt: data.lastSyncedAt.present
          ? data.lastSyncedAt.value
          : this.lastSyncedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CollectionDailyMetricRow(')
          ..write('id: $id, ')
          ..write('collectionId: $collectionId, ')
          ..write('statDate: $statDate, ')
          ..write('itemCount: $itemCount, ')
          ..write('firstCollectibleId: $firstCollectibleId, ')
          ..write('lastCollectibleId: $lastCollectibleId, ')
          ..write('lastSyncedAt: $lastSyncedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    collectionId,
    statDate,
    itemCount,
    firstCollectibleId,
    lastCollectibleId,
    lastSyncedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CollectionDailyMetricRow &&
          other.id == this.id &&
          other.collectionId == this.collectionId &&
          other.statDate == this.statDate &&
          other.itemCount == this.itemCount &&
          other.firstCollectibleId == this.firstCollectibleId &&
          other.lastCollectibleId == this.lastCollectibleId &&
          other.lastSyncedAt == this.lastSyncedAt);
}

class CollectionDailyMetricsCompanion
    extends UpdateCompanion<CollectionDailyMetricRow> {
  final Value<int> id;
  final Value<int?> collectionId;
  final Value<DateTime> statDate;
  final Value<int> itemCount;
  final Value<int?> firstCollectibleId;
  final Value<int?> lastCollectibleId;
  final Value<DateTime> lastSyncedAt;
  const CollectionDailyMetricsCompanion({
    this.id = const Value.absent(),
    this.collectionId = const Value.absent(),
    this.statDate = const Value.absent(),
    this.itemCount = const Value.absent(),
    this.firstCollectibleId = const Value.absent(),
    this.lastCollectibleId = const Value.absent(),
    this.lastSyncedAt = const Value.absent(),
  });
  CollectionDailyMetricsCompanion.insert({
    this.id = const Value.absent(),
    this.collectionId = const Value.absent(),
    required DateTime statDate,
    this.itemCount = const Value.absent(),
    this.firstCollectibleId = const Value.absent(),
    this.lastCollectibleId = const Value.absent(),
    this.lastSyncedAt = const Value.absent(),
  }) : statDate = Value(statDate);
  static Insertable<CollectionDailyMetricRow> custom({
    Expression<int>? id,
    Expression<int>? collectionId,
    Expression<DateTime>? statDate,
    Expression<int>? itemCount,
    Expression<int>? firstCollectibleId,
    Expression<int>? lastCollectibleId,
    Expression<DateTime>? lastSyncedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (collectionId != null) 'collection_id': collectionId,
      if (statDate != null) 'stat_date': statDate,
      if (itemCount != null) 'item_count': itemCount,
      if (firstCollectibleId != null)
        'first_collectible_id': firstCollectibleId,
      if (lastCollectibleId != null) 'last_collectible_id': lastCollectibleId,
      if (lastSyncedAt != null) 'last_synced_at': lastSyncedAt,
    });
  }

  CollectionDailyMetricsCompanion copyWith({
    Value<int>? id,
    Value<int?>? collectionId,
    Value<DateTime>? statDate,
    Value<int>? itemCount,
    Value<int?>? firstCollectibleId,
    Value<int?>? lastCollectibleId,
    Value<DateTime>? lastSyncedAt,
  }) {
    return CollectionDailyMetricsCompanion(
      id: id ?? this.id,
      collectionId: collectionId ?? this.collectionId,
      statDate: statDate ?? this.statDate,
      itemCount: itemCount ?? this.itemCount,
      firstCollectibleId: firstCollectibleId ?? this.firstCollectibleId,
      lastCollectibleId: lastCollectibleId ?? this.lastCollectibleId,
      lastSyncedAt: lastSyncedAt ?? this.lastSyncedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (collectionId.present) {
      map['collection_id'] = Variable<int>(collectionId.value);
    }
    if (statDate.present) {
      map['stat_date'] = Variable<DateTime>(statDate.value);
    }
    if (itemCount.present) {
      map['item_count'] = Variable<int>(itemCount.value);
    }
    if (firstCollectibleId.present) {
      map['first_collectible_id'] = Variable<int>(firstCollectibleId.value);
    }
    if (lastCollectibleId.present) {
      map['last_collectible_id'] = Variable<int>(lastCollectibleId.value);
    }
    if (lastSyncedAt.present) {
      map['last_synced_at'] = Variable<DateTime>(lastSyncedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CollectionDailyMetricsCompanion(')
          ..write('id: $id, ')
          ..write('collectionId: $collectionId, ')
          ..write('statDate: $statDate, ')
          ..write('itemCount: $itemCount, ')
          ..write('firstCollectibleId: $firstCollectibleId, ')
          ..write('lastCollectibleId: $lastCollectibleId, ')
          ..write('lastSyncedAt: $lastSyncedAt')
          ..write(')'))
        .toString();
  }
}

class $ExportLogsTable extends ExportLogs
    with TableInfo<$ExportLogsTable, ExportLogRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExportLogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _collectionIdMeta = const VerificationMeta(
    'collectionId',
  );
  @override
  late final GeneratedColumn<int> collectionId = GeneratedColumn<int>(
    'collection_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES collections (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _exportPathMeta = const VerificationMeta(
    'exportPath',
  );
  @override
  late final GeneratedColumn<String> exportPath = GeneratedColumn<String>(
    'export_path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fileNameMeta = const VerificationMeta(
    'fileName',
  );
  @override
  late final GeneratedColumn<String> fileName = GeneratedColumn<String>(
    'file_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _resolutionPxMeta = const VerificationMeta(
    'resolutionPx',
  );
  @override
  late final GeneratedColumn<String> resolutionPx = GeneratedColumn<String>(
    'resolution_px',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('2048x2048'),
  );
  static const VerificationMeta _fileSizeBytesMeta = const VerificationMeta(
    'fileSizeBytes',
  );
  @override
  late final GeneratedColumn<int> fileSizeBytes = GeneratedColumn<int>(
    'file_size_bytes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    collectionId,
    exportPath,
    fileName,
    resolutionPx,
    fileSizeBytes,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'export_logs';
  @override
  VerificationContext validateIntegrity(
    Insertable<ExportLogRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('collection_id')) {
      context.handle(
        _collectionIdMeta,
        collectionId.isAcceptableOrUnknown(
          data['collection_id']!,
          _collectionIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_collectionIdMeta);
    }
    if (data.containsKey('export_path')) {
      context.handle(
        _exportPathMeta,
        exportPath.isAcceptableOrUnknown(data['export_path']!, _exportPathMeta),
      );
    } else if (isInserting) {
      context.missing(_exportPathMeta);
    }
    if (data.containsKey('file_name')) {
      context.handle(
        _fileNameMeta,
        fileName.isAcceptableOrUnknown(data['file_name']!, _fileNameMeta),
      );
    } else if (isInserting) {
      context.missing(_fileNameMeta);
    }
    if (data.containsKey('resolution_px')) {
      context.handle(
        _resolutionPxMeta,
        resolutionPx.isAcceptableOrUnknown(
          data['resolution_px']!,
          _resolutionPxMeta,
        ),
      );
    }
    if (data.containsKey('file_size_bytes')) {
      context.handle(
        _fileSizeBytesMeta,
        fileSizeBytes.isAcceptableOrUnknown(
          data['file_size_bytes']!,
          _fileSizeBytesMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ExportLogRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ExportLogRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      collectionId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}collection_id'],
      )!,
      exportPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}export_path'],
      )!,
      fileName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}file_name'],
      )!,
      resolutionPx: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}resolution_px'],
      )!,
      fileSizeBytes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}file_size_bytes'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $ExportLogsTable createAlias(String alias) {
    return $ExportLogsTable(attachedDatabase, alias);
  }
}

class ExportLogRow extends DataClass implements Insertable<ExportLogRow> {
  final int id;
  final int collectionId;
  final String exportPath;
  final String fileName;
  final String resolutionPx;
  final int fileSizeBytes;
  final DateTime createdAt;
  const ExportLogRow({
    required this.id,
    required this.collectionId,
    required this.exportPath,
    required this.fileName,
    required this.resolutionPx,
    required this.fileSizeBytes,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['collection_id'] = Variable<int>(collectionId);
    map['export_path'] = Variable<String>(exportPath);
    map['file_name'] = Variable<String>(fileName);
    map['resolution_px'] = Variable<String>(resolutionPx);
    map['file_size_bytes'] = Variable<int>(fileSizeBytes);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  ExportLogsCompanion toCompanion(bool nullToAbsent) {
    return ExportLogsCompanion(
      id: Value(id),
      collectionId: Value(collectionId),
      exportPath: Value(exportPath),
      fileName: Value(fileName),
      resolutionPx: Value(resolutionPx),
      fileSizeBytes: Value(fileSizeBytes),
      createdAt: Value(createdAt),
    );
  }

  factory ExportLogRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ExportLogRow(
      id: serializer.fromJson<int>(json['id']),
      collectionId: serializer.fromJson<int>(json['collectionId']),
      exportPath: serializer.fromJson<String>(json['exportPath']),
      fileName: serializer.fromJson<String>(json['fileName']),
      resolutionPx: serializer.fromJson<String>(json['resolutionPx']),
      fileSizeBytes: serializer.fromJson<int>(json['fileSizeBytes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'collectionId': serializer.toJson<int>(collectionId),
      'exportPath': serializer.toJson<String>(exportPath),
      'fileName': serializer.toJson<String>(fileName),
      'resolutionPx': serializer.toJson<String>(resolutionPx),
      'fileSizeBytes': serializer.toJson<int>(fileSizeBytes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  ExportLogRow copyWith({
    int? id,
    int? collectionId,
    String? exportPath,
    String? fileName,
    String? resolutionPx,
    int? fileSizeBytes,
    DateTime? createdAt,
  }) => ExportLogRow(
    id: id ?? this.id,
    collectionId: collectionId ?? this.collectionId,
    exportPath: exportPath ?? this.exportPath,
    fileName: fileName ?? this.fileName,
    resolutionPx: resolutionPx ?? this.resolutionPx,
    fileSizeBytes: fileSizeBytes ?? this.fileSizeBytes,
    createdAt: createdAt ?? this.createdAt,
  );
  ExportLogRow copyWithCompanion(ExportLogsCompanion data) {
    return ExportLogRow(
      id: data.id.present ? data.id.value : this.id,
      collectionId: data.collectionId.present
          ? data.collectionId.value
          : this.collectionId,
      exportPath: data.exportPath.present
          ? data.exportPath.value
          : this.exportPath,
      fileName: data.fileName.present ? data.fileName.value : this.fileName,
      resolutionPx: data.resolutionPx.present
          ? data.resolutionPx.value
          : this.resolutionPx,
      fileSizeBytes: data.fileSizeBytes.present
          ? data.fileSizeBytes.value
          : this.fileSizeBytes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ExportLogRow(')
          ..write('id: $id, ')
          ..write('collectionId: $collectionId, ')
          ..write('exportPath: $exportPath, ')
          ..write('fileName: $fileName, ')
          ..write('resolutionPx: $resolutionPx, ')
          ..write('fileSizeBytes: $fileSizeBytes, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    collectionId,
    exportPath,
    fileName,
    resolutionPx,
    fileSizeBytes,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExportLogRow &&
          other.id == this.id &&
          other.collectionId == this.collectionId &&
          other.exportPath == this.exportPath &&
          other.fileName == this.fileName &&
          other.resolutionPx == this.resolutionPx &&
          other.fileSizeBytes == this.fileSizeBytes &&
          other.createdAt == this.createdAt);
}

class ExportLogsCompanion extends UpdateCompanion<ExportLogRow> {
  final Value<int> id;
  final Value<int> collectionId;
  final Value<String> exportPath;
  final Value<String> fileName;
  final Value<String> resolutionPx;
  final Value<int> fileSizeBytes;
  final Value<DateTime> createdAt;
  const ExportLogsCompanion({
    this.id = const Value.absent(),
    this.collectionId = const Value.absent(),
    this.exportPath = const Value.absent(),
    this.fileName = const Value.absent(),
    this.resolutionPx = const Value.absent(),
    this.fileSizeBytes = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  ExportLogsCompanion.insert({
    this.id = const Value.absent(),
    required int collectionId,
    required String exportPath,
    required String fileName,
    this.resolutionPx = const Value.absent(),
    this.fileSizeBytes = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : collectionId = Value(collectionId),
       exportPath = Value(exportPath),
       fileName = Value(fileName);
  static Insertable<ExportLogRow> custom({
    Expression<int>? id,
    Expression<int>? collectionId,
    Expression<String>? exportPath,
    Expression<String>? fileName,
    Expression<String>? resolutionPx,
    Expression<int>? fileSizeBytes,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (collectionId != null) 'collection_id': collectionId,
      if (exportPath != null) 'export_path': exportPath,
      if (fileName != null) 'file_name': fileName,
      if (resolutionPx != null) 'resolution_px': resolutionPx,
      if (fileSizeBytes != null) 'file_size_bytes': fileSizeBytes,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  ExportLogsCompanion copyWith({
    Value<int>? id,
    Value<int>? collectionId,
    Value<String>? exportPath,
    Value<String>? fileName,
    Value<String>? resolutionPx,
    Value<int>? fileSizeBytes,
    Value<DateTime>? createdAt,
  }) {
    return ExportLogsCompanion(
      id: id ?? this.id,
      collectionId: collectionId ?? this.collectionId,
      exportPath: exportPath ?? this.exportPath,
      fileName: fileName ?? this.fileName,
      resolutionPx: resolutionPx ?? this.resolutionPx,
      fileSizeBytes: fileSizeBytes ?? this.fileSizeBytes,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (collectionId.present) {
      map['collection_id'] = Variable<int>(collectionId.value);
    }
    if (exportPath.present) {
      map['export_path'] = Variable<String>(exportPath.value);
    }
    if (fileName.present) {
      map['file_name'] = Variable<String>(fileName.value);
    }
    if (resolutionPx.present) {
      map['resolution_px'] = Variable<String>(resolutionPx.value);
    }
    if (fileSizeBytes.present) {
      map['file_size_bytes'] = Variable<int>(fileSizeBytes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExportLogsCompanion(')
          ..write('id: $id, ')
          ..write('collectionId: $collectionId, ')
          ..write('exportPath: $exportPath, ')
          ..write('fileName: $fileName, ')
          ..write('resolutionPx: $resolutionPx, ')
          ..write('fileSizeBytes: $fileSizeBytes, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $StorageSnapshotsTable extends StorageSnapshots
    with TableInfo<$StorageSnapshotsTable, StorageSnapshotRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StorageSnapshotsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _collectionIdMeta = const VerificationMeta(
    'collectionId',
  );
  @override
  late final GeneratedColumn<int> collectionId = GeneratedColumn<int>(
    'collection_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES collections (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _totalBytesMeta = const VerificationMeta(
    'totalBytes',
  );
  @override
  late final GeneratedColumn<int> totalBytes = GeneratedColumn<int>(
    'total_bytes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _thumbnailBytesMeta = const VerificationMeta(
    'thumbnailBytes',
  );
  @override
  late final GeneratedColumn<int> thumbnailBytes = GeneratedColumn<int>(
    'thumbnail_bytes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _itemsCountMeta = const VerificationMeta(
    'itemsCount',
  );
  @override
  late final GeneratedColumn<int> itemsCount = GeneratedColumn<int>(
    'items_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _computedAtMeta = const VerificationMeta(
    'computedAt',
  );
  @override
  late final GeneratedColumn<DateTime> computedAt = GeneratedColumn<DateTime>(
    'computed_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    collectionId,
    totalBytes,
    thumbnailBytes,
    itemsCount,
    computedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'storage_snapshots';
  @override
  VerificationContext validateIntegrity(
    Insertable<StorageSnapshotRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('collection_id')) {
      context.handle(
        _collectionIdMeta,
        collectionId.isAcceptableOrUnknown(
          data['collection_id']!,
          _collectionIdMeta,
        ),
      );
    }
    if (data.containsKey('total_bytes')) {
      context.handle(
        _totalBytesMeta,
        totalBytes.isAcceptableOrUnknown(data['total_bytes']!, _totalBytesMeta),
      );
    }
    if (data.containsKey('thumbnail_bytes')) {
      context.handle(
        _thumbnailBytesMeta,
        thumbnailBytes.isAcceptableOrUnknown(
          data['thumbnail_bytes']!,
          _thumbnailBytesMeta,
        ),
      );
    }
    if (data.containsKey('items_count')) {
      context.handle(
        _itemsCountMeta,
        itemsCount.isAcceptableOrUnknown(data['items_count']!, _itemsCountMeta),
      );
    }
    if (data.containsKey('computed_at')) {
      context.handle(
        _computedAtMeta,
        computedAt.isAcceptableOrUnknown(data['computed_at']!, _computedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  StorageSnapshotRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StorageSnapshotRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      collectionId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}collection_id'],
      ),
      totalBytes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_bytes'],
      )!,
      thumbnailBytes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}thumbnail_bytes'],
      )!,
      itemsCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}items_count'],
      )!,
      computedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}computed_at'],
      )!,
    );
  }

  @override
  $StorageSnapshotsTable createAlias(String alias) {
    return $StorageSnapshotsTable(attachedDatabase, alias);
  }
}

class StorageSnapshotRow extends DataClass
    implements Insertable<StorageSnapshotRow> {
  final int id;
  final int? collectionId;
  final int totalBytes;
  final int thumbnailBytes;
  final int itemsCount;
  final DateTime computedAt;
  const StorageSnapshotRow({
    required this.id,
    this.collectionId,
    required this.totalBytes,
    required this.thumbnailBytes,
    required this.itemsCount,
    required this.computedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || collectionId != null) {
      map['collection_id'] = Variable<int>(collectionId);
    }
    map['total_bytes'] = Variable<int>(totalBytes);
    map['thumbnail_bytes'] = Variable<int>(thumbnailBytes);
    map['items_count'] = Variable<int>(itemsCount);
    map['computed_at'] = Variable<DateTime>(computedAt);
    return map;
  }

  StorageSnapshotsCompanion toCompanion(bool nullToAbsent) {
    return StorageSnapshotsCompanion(
      id: Value(id),
      collectionId: collectionId == null && nullToAbsent
          ? const Value.absent()
          : Value(collectionId),
      totalBytes: Value(totalBytes),
      thumbnailBytes: Value(thumbnailBytes),
      itemsCount: Value(itemsCount),
      computedAt: Value(computedAt),
    );
  }

  factory StorageSnapshotRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StorageSnapshotRow(
      id: serializer.fromJson<int>(json['id']),
      collectionId: serializer.fromJson<int?>(json['collectionId']),
      totalBytes: serializer.fromJson<int>(json['totalBytes']),
      thumbnailBytes: serializer.fromJson<int>(json['thumbnailBytes']),
      itemsCount: serializer.fromJson<int>(json['itemsCount']),
      computedAt: serializer.fromJson<DateTime>(json['computedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'collectionId': serializer.toJson<int?>(collectionId),
      'totalBytes': serializer.toJson<int>(totalBytes),
      'thumbnailBytes': serializer.toJson<int>(thumbnailBytes),
      'itemsCount': serializer.toJson<int>(itemsCount),
      'computedAt': serializer.toJson<DateTime>(computedAt),
    };
  }

  StorageSnapshotRow copyWith({
    int? id,
    Value<int?> collectionId = const Value.absent(),
    int? totalBytes,
    int? thumbnailBytes,
    int? itemsCount,
    DateTime? computedAt,
  }) => StorageSnapshotRow(
    id: id ?? this.id,
    collectionId: collectionId.present ? collectionId.value : this.collectionId,
    totalBytes: totalBytes ?? this.totalBytes,
    thumbnailBytes: thumbnailBytes ?? this.thumbnailBytes,
    itemsCount: itemsCount ?? this.itemsCount,
    computedAt: computedAt ?? this.computedAt,
  );
  StorageSnapshotRow copyWithCompanion(StorageSnapshotsCompanion data) {
    return StorageSnapshotRow(
      id: data.id.present ? data.id.value : this.id,
      collectionId: data.collectionId.present
          ? data.collectionId.value
          : this.collectionId,
      totalBytes: data.totalBytes.present
          ? data.totalBytes.value
          : this.totalBytes,
      thumbnailBytes: data.thumbnailBytes.present
          ? data.thumbnailBytes.value
          : this.thumbnailBytes,
      itemsCount: data.itemsCount.present
          ? data.itemsCount.value
          : this.itemsCount,
      computedAt: data.computedAt.present
          ? data.computedAt.value
          : this.computedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StorageSnapshotRow(')
          ..write('id: $id, ')
          ..write('collectionId: $collectionId, ')
          ..write('totalBytes: $totalBytes, ')
          ..write('thumbnailBytes: $thumbnailBytes, ')
          ..write('itemsCount: $itemsCount, ')
          ..write('computedAt: $computedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    collectionId,
    totalBytes,
    thumbnailBytes,
    itemsCount,
    computedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StorageSnapshotRow &&
          other.id == this.id &&
          other.collectionId == this.collectionId &&
          other.totalBytes == this.totalBytes &&
          other.thumbnailBytes == this.thumbnailBytes &&
          other.itemsCount == this.itemsCount &&
          other.computedAt == this.computedAt);
}

class StorageSnapshotsCompanion extends UpdateCompanion<StorageSnapshotRow> {
  final Value<int> id;
  final Value<int?> collectionId;
  final Value<int> totalBytes;
  final Value<int> thumbnailBytes;
  final Value<int> itemsCount;
  final Value<DateTime> computedAt;
  const StorageSnapshotsCompanion({
    this.id = const Value.absent(),
    this.collectionId = const Value.absent(),
    this.totalBytes = const Value.absent(),
    this.thumbnailBytes = const Value.absent(),
    this.itemsCount = const Value.absent(),
    this.computedAt = const Value.absent(),
  });
  StorageSnapshotsCompanion.insert({
    this.id = const Value.absent(),
    this.collectionId = const Value.absent(),
    this.totalBytes = const Value.absent(),
    this.thumbnailBytes = const Value.absent(),
    this.itemsCount = const Value.absent(),
    this.computedAt = const Value.absent(),
  });
  static Insertable<StorageSnapshotRow> custom({
    Expression<int>? id,
    Expression<int>? collectionId,
    Expression<int>? totalBytes,
    Expression<int>? thumbnailBytes,
    Expression<int>? itemsCount,
    Expression<DateTime>? computedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (collectionId != null) 'collection_id': collectionId,
      if (totalBytes != null) 'total_bytes': totalBytes,
      if (thumbnailBytes != null) 'thumbnail_bytes': thumbnailBytes,
      if (itemsCount != null) 'items_count': itemsCount,
      if (computedAt != null) 'computed_at': computedAt,
    });
  }

  StorageSnapshotsCompanion copyWith({
    Value<int>? id,
    Value<int?>? collectionId,
    Value<int>? totalBytes,
    Value<int>? thumbnailBytes,
    Value<int>? itemsCount,
    Value<DateTime>? computedAt,
  }) {
    return StorageSnapshotsCompanion(
      id: id ?? this.id,
      collectionId: collectionId ?? this.collectionId,
      totalBytes: totalBytes ?? this.totalBytes,
      thumbnailBytes: thumbnailBytes ?? this.thumbnailBytes,
      itemsCount: itemsCount ?? this.itemsCount,
      computedAt: computedAt ?? this.computedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (collectionId.present) {
      map['collection_id'] = Variable<int>(collectionId.value);
    }
    if (totalBytes.present) {
      map['total_bytes'] = Variable<int>(totalBytes.value);
    }
    if (thumbnailBytes.present) {
      map['thumbnail_bytes'] = Variable<int>(thumbnailBytes.value);
    }
    if (itemsCount.present) {
      map['items_count'] = Variable<int>(itemsCount.value);
    }
    if (computedAt.present) {
      map['computed_at'] = Variable<DateTime>(computedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StorageSnapshotsCompanion(')
          ..write('id: $id, ')
          ..write('collectionId: $collectionId, ')
          ..write('totalBytes: $totalBytes, ')
          ..write('thumbnailBytes: $thumbnailBytes, ')
          ..write('itemsCount: $itemsCount, ')
          ..write('computedAt: $computedAt')
          ..write(')'))
        .toString();
  }
}

class $AppPreferencesTable extends AppPreferences
    with TableInfo<$AppPreferencesTable, AppPreferenceRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppPreferencesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _rootDirectoryMeta = const VerificationMeta(
    'rootDirectory',
  );
  @override
  late final GeneratedColumn<String> rootDirectory = GeneratedColumn<String>(
    'root_directory',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _importModeMeta = const VerificationMeta(
    'importMode',
  );
  @override
  late final GeneratedColumn<String> importMode = GeneratedColumn<String>(
    'import_mode',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('copy'),
  );
  static const VerificationMeta _lastExportDirMeta = const VerificationMeta(
    'lastExportDir',
  );
  @override
  late final GeneratedColumn<String> lastExportDir = GeneratedColumn<String>(
    'last_export_dir',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastDirectoryCheckAtMeta =
      const VerificationMeta('lastDirectoryCheckAt');
  @override
  late final GeneratedColumn<DateTime> lastDirectoryCheckAt =
      GeneratedColumn<DateTime>(
        'last_directory_check_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _totalStorageBytesMeta = const VerificationMeta(
    'totalStorageBytes',
  );
  @override
  late final GeneratedColumn<int> totalStorageBytes = GeneratedColumn<int>(
    'total_storage_bytes',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _analyticsOptInMeta = const VerificationMeta(
    'analyticsOptIn',
  );
  @override
  late final GeneratedColumn<bool> analyticsOptIn = GeneratedColumn<bool>(
    'analytics_opt_in',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("analytics_opt_in" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    rootDirectory,
    importMode,
    lastExportDir,
    lastDirectoryCheckAt,
    totalStorageBytes,
    analyticsOptIn,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'app_preferences';
  @override
  VerificationContext validateIntegrity(
    Insertable<AppPreferenceRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('root_directory')) {
      context.handle(
        _rootDirectoryMeta,
        rootDirectory.isAcceptableOrUnknown(
          data['root_directory']!,
          _rootDirectoryMeta,
        ),
      );
    }
    if (data.containsKey('import_mode')) {
      context.handle(
        _importModeMeta,
        importMode.isAcceptableOrUnknown(data['import_mode']!, _importModeMeta),
      );
    }
    if (data.containsKey('last_export_dir')) {
      context.handle(
        _lastExportDirMeta,
        lastExportDir.isAcceptableOrUnknown(
          data['last_export_dir']!,
          _lastExportDirMeta,
        ),
      );
    }
    if (data.containsKey('last_directory_check_at')) {
      context.handle(
        _lastDirectoryCheckAtMeta,
        lastDirectoryCheckAt.isAcceptableOrUnknown(
          data['last_directory_check_at']!,
          _lastDirectoryCheckAtMeta,
        ),
      );
    }
    if (data.containsKey('total_storage_bytes')) {
      context.handle(
        _totalStorageBytesMeta,
        totalStorageBytes.isAcceptableOrUnknown(
          data['total_storage_bytes']!,
          _totalStorageBytesMeta,
        ),
      );
    }
    if (data.containsKey('analytics_opt_in')) {
      context.handle(
        _analyticsOptInMeta,
        analyticsOptIn.isAcceptableOrUnknown(
          data['analytics_opt_in']!,
          _analyticsOptInMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AppPreferenceRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppPreferenceRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      rootDirectory: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}root_directory'],
      )!,
      importMode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}import_mode'],
      )!,
      lastExportDir: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_export_dir'],
      ),
      lastDirectoryCheckAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_directory_check_at'],
      ),
      totalStorageBytes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_storage_bytes'],
      ),
      analyticsOptIn: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}analytics_opt_in'],
      )!,
    );
  }

  @override
  $AppPreferencesTable createAlias(String alias) {
    return $AppPreferencesTable(attachedDatabase, alias);
  }
}

class AppPreferenceRow extends DataClass
    implements Insertable<AppPreferenceRow> {
  final int id;
  final String rootDirectory;
  final String importMode;
  final String? lastExportDir;
  final DateTime? lastDirectoryCheckAt;
  final int? totalStorageBytes;
  final bool analyticsOptIn;
  const AppPreferenceRow({
    required this.id,
    required this.rootDirectory,
    required this.importMode,
    this.lastExportDir,
    this.lastDirectoryCheckAt,
    this.totalStorageBytes,
    required this.analyticsOptIn,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['root_directory'] = Variable<String>(rootDirectory);
    map['import_mode'] = Variable<String>(importMode);
    if (!nullToAbsent || lastExportDir != null) {
      map['last_export_dir'] = Variable<String>(lastExportDir);
    }
    if (!nullToAbsent || lastDirectoryCheckAt != null) {
      map['last_directory_check_at'] = Variable<DateTime>(lastDirectoryCheckAt);
    }
    if (!nullToAbsent || totalStorageBytes != null) {
      map['total_storage_bytes'] = Variable<int>(totalStorageBytes);
    }
    map['analytics_opt_in'] = Variable<bool>(analyticsOptIn);
    return map;
  }

  AppPreferencesCompanion toCompanion(bool nullToAbsent) {
    return AppPreferencesCompanion(
      id: Value(id),
      rootDirectory: Value(rootDirectory),
      importMode: Value(importMode),
      lastExportDir: lastExportDir == null && nullToAbsent
          ? const Value.absent()
          : Value(lastExportDir),
      lastDirectoryCheckAt: lastDirectoryCheckAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastDirectoryCheckAt),
      totalStorageBytes: totalStorageBytes == null && nullToAbsent
          ? const Value.absent()
          : Value(totalStorageBytes),
      analyticsOptIn: Value(analyticsOptIn),
    );
  }

  factory AppPreferenceRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppPreferenceRow(
      id: serializer.fromJson<int>(json['id']),
      rootDirectory: serializer.fromJson<String>(json['rootDirectory']),
      importMode: serializer.fromJson<String>(json['importMode']),
      lastExportDir: serializer.fromJson<String?>(json['lastExportDir']),
      lastDirectoryCheckAt: serializer.fromJson<DateTime?>(
        json['lastDirectoryCheckAt'],
      ),
      totalStorageBytes: serializer.fromJson<int?>(json['totalStorageBytes']),
      analyticsOptIn: serializer.fromJson<bool>(json['analyticsOptIn']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'rootDirectory': serializer.toJson<String>(rootDirectory),
      'importMode': serializer.toJson<String>(importMode),
      'lastExportDir': serializer.toJson<String?>(lastExportDir),
      'lastDirectoryCheckAt': serializer.toJson<DateTime?>(
        lastDirectoryCheckAt,
      ),
      'totalStorageBytes': serializer.toJson<int?>(totalStorageBytes),
      'analyticsOptIn': serializer.toJson<bool>(analyticsOptIn),
    };
  }

  AppPreferenceRow copyWith({
    int? id,
    String? rootDirectory,
    String? importMode,
    Value<String?> lastExportDir = const Value.absent(),
    Value<DateTime?> lastDirectoryCheckAt = const Value.absent(),
    Value<int?> totalStorageBytes = const Value.absent(),
    bool? analyticsOptIn,
  }) => AppPreferenceRow(
    id: id ?? this.id,
    rootDirectory: rootDirectory ?? this.rootDirectory,
    importMode: importMode ?? this.importMode,
    lastExportDir: lastExportDir.present
        ? lastExportDir.value
        : this.lastExportDir,
    lastDirectoryCheckAt: lastDirectoryCheckAt.present
        ? lastDirectoryCheckAt.value
        : this.lastDirectoryCheckAt,
    totalStorageBytes: totalStorageBytes.present
        ? totalStorageBytes.value
        : this.totalStorageBytes,
    analyticsOptIn: analyticsOptIn ?? this.analyticsOptIn,
  );
  AppPreferenceRow copyWithCompanion(AppPreferencesCompanion data) {
    return AppPreferenceRow(
      id: data.id.present ? data.id.value : this.id,
      rootDirectory: data.rootDirectory.present
          ? data.rootDirectory.value
          : this.rootDirectory,
      importMode: data.importMode.present
          ? data.importMode.value
          : this.importMode,
      lastExportDir: data.lastExportDir.present
          ? data.lastExportDir.value
          : this.lastExportDir,
      lastDirectoryCheckAt: data.lastDirectoryCheckAt.present
          ? data.lastDirectoryCheckAt.value
          : this.lastDirectoryCheckAt,
      totalStorageBytes: data.totalStorageBytes.present
          ? data.totalStorageBytes.value
          : this.totalStorageBytes,
      analyticsOptIn: data.analyticsOptIn.present
          ? data.analyticsOptIn.value
          : this.analyticsOptIn,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AppPreferenceRow(')
          ..write('id: $id, ')
          ..write('rootDirectory: $rootDirectory, ')
          ..write('importMode: $importMode, ')
          ..write('lastExportDir: $lastExportDir, ')
          ..write('lastDirectoryCheckAt: $lastDirectoryCheckAt, ')
          ..write('totalStorageBytes: $totalStorageBytes, ')
          ..write('analyticsOptIn: $analyticsOptIn')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    rootDirectory,
    importMode,
    lastExportDir,
    lastDirectoryCheckAt,
    totalStorageBytes,
    analyticsOptIn,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppPreferenceRow &&
          other.id == this.id &&
          other.rootDirectory == this.rootDirectory &&
          other.importMode == this.importMode &&
          other.lastExportDir == this.lastExportDir &&
          other.lastDirectoryCheckAt == this.lastDirectoryCheckAt &&
          other.totalStorageBytes == this.totalStorageBytes &&
          other.analyticsOptIn == this.analyticsOptIn);
}

class AppPreferencesCompanion extends UpdateCompanion<AppPreferenceRow> {
  final Value<int> id;
  final Value<String> rootDirectory;
  final Value<String> importMode;
  final Value<String?> lastExportDir;
  final Value<DateTime?> lastDirectoryCheckAt;
  final Value<int?> totalStorageBytes;
  final Value<bool> analyticsOptIn;
  const AppPreferencesCompanion({
    this.id = const Value.absent(),
    this.rootDirectory = const Value.absent(),
    this.importMode = const Value.absent(),
    this.lastExportDir = const Value.absent(),
    this.lastDirectoryCheckAt = const Value.absent(),
    this.totalStorageBytes = const Value.absent(),
    this.analyticsOptIn = const Value.absent(),
  });
  AppPreferencesCompanion.insert({
    this.id = const Value.absent(),
    this.rootDirectory = const Value.absent(),
    this.importMode = const Value.absent(),
    this.lastExportDir = const Value.absent(),
    this.lastDirectoryCheckAt = const Value.absent(),
    this.totalStorageBytes = const Value.absent(),
    this.analyticsOptIn = const Value.absent(),
  });
  static Insertable<AppPreferenceRow> custom({
    Expression<int>? id,
    Expression<String>? rootDirectory,
    Expression<String>? importMode,
    Expression<String>? lastExportDir,
    Expression<DateTime>? lastDirectoryCheckAt,
    Expression<int>? totalStorageBytes,
    Expression<bool>? analyticsOptIn,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (rootDirectory != null) 'root_directory': rootDirectory,
      if (importMode != null) 'import_mode': importMode,
      if (lastExportDir != null) 'last_export_dir': lastExportDir,
      if (lastDirectoryCheckAt != null)
        'last_directory_check_at': lastDirectoryCheckAt,
      if (totalStorageBytes != null) 'total_storage_bytes': totalStorageBytes,
      if (analyticsOptIn != null) 'analytics_opt_in': analyticsOptIn,
    });
  }

  AppPreferencesCompanion copyWith({
    Value<int>? id,
    Value<String>? rootDirectory,
    Value<String>? importMode,
    Value<String?>? lastExportDir,
    Value<DateTime?>? lastDirectoryCheckAt,
    Value<int?>? totalStorageBytes,
    Value<bool>? analyticsOptIn,
  }) {
    return AppPreferencesCompanion(
      id: id ?? this.id,
      rootDirectory: rootDirectory ?? this.rootDirectory,
      importMode: importMode ?? this.importMode,
      lastExportDir: lastExportDir ?? this.lastExportDir,
      lastDirectoryCheckAt: lastDirectoryCheckAt ?? this.lastDirectoryCheckAt,
      totalStorageBytes: totalStorageBytes ?? this.totalStorageBytes,
      analyticsOptIn: analyticsOptIn ?? this.analyticsOptIn,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (rootDirectory.present) {
      map['root_directory'] = Variable<String>(rootDirectory.value);
    }
    if (importMode.present) {
      map['import_mode'] = Variable<String>(importMode.value);
    }
    if (lastExportDir.present) {
      map['last_export_dir'] = Variable<String>(lastExportDir.value);
    }
    if (lastDirectoryCheckAt.present) {
      map['last_directory_check_at'] = Variable<DateTime>(
        lastDirectoryCheckAt.value,
      );
    }
    if (totalStorageBytes.present) {
      map['total_storage_bytes'] = Variable<int>(totalStorageBytes.value);
    }
    if (analyticsOptIn.present) {
      map['analytics_opt_in'] = Variable<bool>(analyticsOptIn.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppPreferencesCompanion(')
          ..write('id: $id, ')
          ..write('rootDirectory: $rootDirectory, ')
          ..write('importMode: $importMode, ')
          ..write('lastExportDir: $lastExportDir, ')
          ..write('lastDirectoryCheckAt: $lastDirectoryCheckAt, ')
          ..write('totalStorageBytes: $totalStorageBytes, ')
          ..write('analyticsOptIn: $analyticsOptIn')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $FrameStylesTable frameStyles = $FrameStylesTable(this);
  late final $CollectionsTable collections = $CollectionsTable(this);
  late final $CollectiblesTable collectibles = $CollectiblesTable(this);
  late final $HighlightSlotsTable highlightSlots = $HighlightSlotsTable(this);
  late final $CollectionDailyMetricsTable collectionDailyMetrics =
      $CollectionDailyMetricsTable(this);
  late final $ExportLogsTable exportLogs = $ExportLogsTable(this);
  late final $StorageSnapshotsTable storageSnapshots = $StorageSnapshotsTable(
    this,
  );
  late final $AppPreferencesTable appPreferences = $AppPreferencesTable(this);
  late final CollectionsDao collectionsDao = CollectionsDao(
    this as AppDatabase,
  );
  late final CollectiblesDao collectiblesDao = CollectiblesDao(
    this as AppDatabase,
  );
  late final HighlightSlotsDao highlightSlotsDao = HighlightSlotsDao(
    this as AppDatabase,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    frameStyles,
    collections,
    collectibles,
    highlightSlots,
    collectionDailyMetrics,
    exportLogs,
    storageSnapshots,
    appPreferences,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'frame_styles',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('collections', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'collections',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('collectibles', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'collections',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('highlight_slots', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'collectibles',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('highlight_slots', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'collections',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [
        TableUpdate('collection_daily_metrics', kind: UpdateKind.delete),
      ],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'collectibles',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [
        TableUpdate('collection_daily_metrics', kind: UpdateKind.update),
      ],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'collectibles',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [
        TableUpdate('collection_daily_metrics', kind: UpdateKind.update),
      ],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'collections',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('export_logs', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'collections',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('storage_snapshots', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$FrameStylesTableCreateCompanionBuilder =
    FrameStylesCompanion Function({
      Value<int> id,
      required String name,
      required String assetPath,
      Value<String?> overlayMaskPath,
      Value<String> gridLineColor,
      Value<String> backgroundColor,
      Value<String> metadataJson,
      Value<String> supportedLayout,
      Value<bool> isBuiltin,
    });
typedef $$FrameStylesTableUpdateCompanionBuilder =
    FrameStylesCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String> assetPath,
      Value<String?> overlayMaskPath,
      Value<String> gridLineColor,
      Value<String> backgroundColor,
      Value<String> metadataJson,
      Value<String> supportedLayout,
      Value<bool> isBuiltin,
    });

final class $$FrameStylesTableReferences
    extends BaseReferences<_$AppDatabase, $FrameStylesTable, FrameStyleRow> {
  $$FrameStylesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$CollectionsTable, List<CollectionRow>>
  _collectionsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.collections,
    aliasName: $_aliasNameGenerator(
      db.frameStyles.id,
      db.collections.frameStyleId,
    ),
  );

  $$CollectionsTableProcessedTableManager get collectionsRefs {
    final manager = $$CollectionsTableTableManager(
      $_db,
      $_db.collections,
    ).filter((f) => f.frameStyleId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_collectionsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$FrameStylesTableFilterComposer
    extends Composer<_$AppDatabase, $FrameStylesTable> {
  $$FrameStylesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get assetPath => $composableBuilder(
    column: $table.assetPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get overlayMaskPath => $composableBuilder(
    column: $table.overlayMaskPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get gridLineColor => $composableBuilder(
    column: $table.gridLineColor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get backgroundColor => $composableBuilder(
    column: $table.backgroundColor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get metadataJson => $composableBuilder(
    column: $table.metadataJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get supportedLayout => $composableBuilder(
    column: $table.supportedLayout,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isBuiltin => $composableBuilder(
    column: $table.isBuiltin,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> collectionsRefs(
    Expression<bool> Function($$CollectionsTableFilterComposer f) f,
  ) {
    final $$CollectionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.collections,
      getReferencedColumn: (t) => t.frameStyleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CollectionsTableFilterComposer(
            $db: $db,
            $table: $db.collections,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$FrameStylesTableOrderingComposer
    extends Composer<_$AppDatabase, $FrameStylesTable> {
  $$FrameStylesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get assetPath => $composableBuilder(
    column: $table.assetPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get overlayMaskPath => $composableBuilder(
    column: $table.overlayMaskPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get gridLineColor => $composableBuilder(
    column: $table.gridLineColor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get backgroundColor => $composableBuilder(
    column: $table.backgroundColor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get metadataJson => $composableBuilder(
    column: $table.metadataJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get supportedLayout => $composableBuilder(
    column: $table.supportedLayout,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isBuiltin => $composableBuilder(
    column: $table.isBuiltin,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$FrameStylesTableAnnotationComposer
    extends Composer<_$AppDatabase, $FrameStylesTable> {
  $$FrameStylesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get assetPath =>
      $composableBuilder(column: $table.assetPath, builder: (column) => column);

  GeneratedColumn<String> get overlayMaskPath => $composableBuilder(
    column: $table.overlayMaskPath,
    builder: (column) => column,
  );

  GeneratedColumn<String> get gridLineColor => $composableBuilder(
    column: $table.gridLineColor,
    builder: (column) => column,
  );

  GeneratedColumn<String> get backgroundColor => $composableBuilder(
    column: $table.backgroundColor,
    builder: (column) => column,
  );

  GeneratedColumn<String> get metadataJson => $composableBuilder(
    column: $table.metadataJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get supportedLayout => $composableBuilder(
    column: $table.supportedLayout,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isBuiltin =>
      $composableBuilder(column: $table.isBuiltin, builder: (column) => column);

  Expression<T> collectionsRefs<T extends Object>(
    Expression<T> Function($$CollectionsTableAnnotationComposer a) f,
  ) {
    final $$CollectionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.collections,
      getReferencedColumn: (t) => t.frameStyleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CollectionsTableAnnotationComposer(
            $db: $db,
            $table: $db.collections,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$FrameStylesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FrameStylesTable,
          FrameStyleRow,
          $$FrameStylesTableFilterComposer,
          $$FrameStylesTableOrderingComposer,
          $$FrameStylesTableAnnotationComposer,
          $$FrameStylesTableCreateCompanionBuilder,
          $$FrameStylesTableUpdateCompanionBuilder,
          (FrameStyleRow, $$FrameStylesTableReferences),
          FrameStyleRow,
          PrefetchHooks Function({bool collectionsRefs})
        > {
  $$FrameStylesTableTableManager(_$AppDatabase db, $FrameStylesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FrameStylesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FrameStylesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FrameStylesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> assetPath = const Value.absent(),
                Value<String?> overlayMaskPath = const Value.absent(),
                Value<String> gridLineColor = const Value.absent(),
                Value<String> backgroundColor = const Value.absent(),
                Value<String> metadataJson = const Value.absent(),
                Value<String> supportedLayout = const Value.absent(),
                Value<bool> isBuiltin = const Value.absent(),
              }) => FrameStylesCompanion(
                id: id,
                name: name,
                assetPath: assetPath,
                overlayMaskPath: overlayMaskPath,
                gridLineColor: gridLineColor,
                backgroundColor: backgroundColor,
                metadataJson: metadataJson,
                supportedLayout: supportedLayout,
                isBuiltin: isBuiltin,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required String assetPath,
                Value<String?> overlayMaskPath = const Value.absent(),
                Value<String> gridLineColor = const Value.absent(),
                Value<String> backgroundColor = const Value.absent(),
                Value<String> metadataJson = const Value.absent(),
                Value<String> supportedLayout = const Value.absent(),
                Value<bool> isBuiltin = const Value.absent(),
              }) => FrameStylesCompanion.insert(
                id: id,
                name: name,
                assetPath: assetPath,
                overlayMaskPath: overlayMaskPath,
                gridLineColor: gridLineColor,
                backgroundColor: backgroundColor,
                metadataJson: metadataJson,
                supportedLayout: supportedLayout,
                isBuiltin: isBuiltin,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$FrameStylesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({collectionsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (collectionsRefs) db.collections],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (collectionsRefs)
                    await $_getPrefetchedData<
                      FrameStyleRow,
                      $FrameStylesTable,
                      CollectionRow
                    >(
                      currentTable: table,
                      referencedTable: $$FrameStylesTableReferences
                          ._collectionsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$FrameStylesTableReferences(
                            db,
                            table,
                            p0,
                          ).collectionsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where(
                            (e) => e.frameStyleId == item.id,
                          ),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$FrameStylesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FrameStylesTable,
      FrameStyleRow,
      $$FrameStylesTableFilterComposer,
      $$FrameStylesTableOrderingComposer,
      $$FrameStylesTableAnnotationComposer,
      $$FrameStylesTableCreateCompanionBuilder,
      $$FrameStylesTableUpdateCompanionBuilder,
      (FrameStyleRow, $$FrameStylesTableReferences),
      FrameStyleRow,
      PrefetchHooks Function({bool collectionsRefs})
    >;
typedef $$CollectionsTableCreateCompanionBuilder =
    CollectionsCompanion Function({
      Value<int> id,
      required String name,
      Value<String?> description,
      Value<int> sortIndex,
      required int frameStyleId,
      Value<String?> coverPreviewPath,
      Value<DateTime?> coverUpdatedAt,
      Value<String> accentColor,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });
typedef $$CollectionsTableUpdateCompanionBuilder =
    CollectionsCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String?> description,
      Value<int> sortIndex,
      Value<int> frameStyleId,
      Value<String?> coverPreviewPath,
      Value<DateTime?> coverUpdatedAt,
      Value<String> accentColor,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

final class $$CollectionsTableReferences
    extends BaseReferences<_$AppDatabase, $CollectionsTable, CollectionRow> {
  $$CollectionsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $FrameStylesTable _frameStyleIdTable(_$AppDatabase db) =>
      db.frameStyles.createAlias(
        $_aliasNameGenerator(db.collections.frameStyleId, db.frameStyles.id),
      );

  $$FrameStylesTableProcessedTableManager get frameStyleId {
    final $_column = $_itemColumn<int>('frame_style_id')!;

    final manager = $$FrameStylesTableTableManager(
      $_db,
      $_db.frameStyles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_frameStyleIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$CollectiblesTable, List<CollectibleRow>>
  _collectiblesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.collectibles,
    aliasName: $_aliasNameGenerator(
      db.collections.id,
      db.collectibles.collectionId,
    ),
  );

  $$CollectiblesTableProcessedTableManager get collectiblesRefs {
    final manager = $$CollectiblesTableTableManager(
      $_db,
      $_db.collectibles,
    ).filter((f) => f.collectionId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_collectiblesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$HighlightSlotsTable, List<HighlightSlotRow>>
  _highlightSlotsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.highlightSlots,
    aliasName: $_aliasNameGenerator(
      db.collections.id,
      db.highlightSlots.collectionId,
    ),
  );

  $$HighlightSlotsTableProcessedTableManager get highlightSlotsRefs {
    final manager = $$HighlightSlotsTableTableManager(
      $_db,
      $_db.highlightSlots,
    ).filter((f) => f.collectionId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_highlightSlotsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $CollectionDailyMetricsTable,
    List<CollectionDailyMetricRow>
  >
  _collectionDailyMetricsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.collectionDailyMetrics,
        aliasName: $_aliasNameGenerator(
          db.collections.id,
          db.collectionDailyMetrics.collectionId,
        ),
      );

  $$CollectionDailyMetricsTableProcessedTableManager
  get collectionDailyMetricsRefs {
    final manager = $$CollectionDailyMetricsTableTableManager(
      $_db,
      $_db.collectionDailyMetrics,
    ).filter((f) => f.collectionId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _collectionDailyMetricsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ExportLogsTable, List<ExportLogRow>>
  _exportLogsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.exportLogs,
    aliasName: $_aliasNameGenerator(
      db.collections.id,
      db.exportLogs.collectionId,
    ),
  );

  $$ExportLogsTableProcessedTableManager get exportLogsRefs {
    final manager = $$ExportLogsTableTableManager(
      $_db,
      $_db.exportLogs,
    ).filter((f) => f.collectionId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_exportLogsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$StorageSnapshotsTable, List<StorageSnapshotRow>>
  _storageSnapshotsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.storageSnapshots,
    aliasName: $_aliasNameGenerator(
      db.collections.id,
      db.storageSnapshots.collectionId,
    ),
  );

  $$StorageSnapshotsTableProcessedTableManager get storageSnapshotsRefs {
    final manager = $$StorageSnapshotsTableTableManager(
      $_db,
      $_db.storageSnapshots,
    ).filter((f) => f.collectionId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _storageSnapshotsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$CollectionsTableFilterComposer
    extends Composer<_$AppDatabase, $CollectionsTable> {
  $$CollectionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortIndex => $composableBuilder(
    column: $table.sortIndex,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get coverPreviewPath => $composableBuilder(
    column: $table.coverPreviewPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get coverUpdatedAt => $composableBuilder(
    column: $table.coverUpdatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get accentColor => $composableBuilder(
    column: $table.accentColor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$FrameStylesTableFilterComposer get frameStyleId {
    final $$FrameStylesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.frameStyleId,
      referencedTable: $db.frameStyles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FrameStylesTableFilterComposer(
            $db: $db,
            $table: $db.frameStyles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> collectiblesRefs(
    Expression<bool> Function($$CollectiblesTableFilterComposer f) f,
  ) {
    final $$CollectiblesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.collectibles,
      getReferencedColumn: (t) => t.collectionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CollectiblesTableFilterComposer(
            $db: $db,
            $table: $db.collectibles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> highlightSlotsRefs(
    Expression<bool> Function($$HighlightSlotsTableFilterComposer f) f,
  ) {
    final $$HighlightSlotsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.highlightSlots,
      getReferencedColumn: (t) => t.collectionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HighlightSlotsTableFilterComposer(
            $db: $db,
            $table: $db.highlightSlots,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> collectionDailyMetricsRefs(
    Expression<bool> Function($$CollectionDailyMetricsTableFilterComposer f) f,
  ) {
    final $$CollectionDailyMetricsTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.collectionDailyMetrics,
          getReferencedColumn: (t) => t.collectionId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$CollectionDailyMetricsTableFilterComposer(
                $db: $db,
                $table: $db.collectionDailyMetrics,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<bool> exportLogsRefs(
    Expression<bool> Function($$ExportLogsTableFilterComposer f) f,
  ) {
    final $$ExportLogsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.exportLogs,
      getReferencedColumn: (t) => t.collectionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExportLogsTableFilterComposer(
            $db: $db,
            $table: $db.exportLogs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> storageSnapshotsRefs(
    Expression<bool> Function($$StorageSnapshotsTableFilterComposer f) f,
  ) {
    final $$StorageSnapshotsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.storageSnapshots,
      getReferencedColumn: (t) => t.collectionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StorageSnapshotsTableFilterComposer(
            $db: $db,
            $table: $db.storageSnapshots,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CollectionsTableOrderingComposer
    extends Composer<_$AppDatabase, $CollectionsTable> {
  $$CollectionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortIndex => $composableBuilder(
    column: $table.sortIndex,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get coverPreviewPath => $composableBuilder(
    column: $table.coverPreviewPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get coverUpdatedAt => $composableBuilder(
    column: $table.coverUpdatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get accentColor => $composableBuilder(
    column: $table.accentColor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$FrameStylesTableOrderingComposer get frameStyleId {
    final $$FrameStylesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.frameStyleId,
      referencedTable: $db.frameStyles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FrameStylesTableOrderingComposer(
            $db: $db,
            $table: $db.frameStyles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CollectionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CollectionsTable> {
  $$CollectionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<int> get sortIndex =>
      $composableBuilder(column: $table.sortIndex, builder: (column) => column);

  GeneratedColumn<String> get coverPreviewPath => $composableBuilder(
    column: $table.coverPreviewPath,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get coverUpdatedAt => $composableBuilder(
    column: $table.coverUpdatedAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get accentColor => $composableBuilder(
    column: $table.accentColor,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$FrameStylesTableAnnotationComposer get frameStyleId {
    final $$FrameStylesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.frameStyleId,
      referencedTable: $db.frameStyles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FrameStylesTableAnnotationComposer(
            $db: $db,
            $table: $db.frameStyles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> collectiblesRefs<T extends Object>(
    Expression<T> Function($$CollectiblesTableAnnotationComposer a) f,
  ) {
    final $$CollectiblesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.collectibles,
      getReferencedColumn: (t) => t.collectionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CollectiblesTableAnnotationComposer(
            $db: $db,
            $table: $db.collectibles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> highlightSlotsRefs<T extends Object>(
    Expression<T> Function($$HighlightSlotsTableAnnotationComposer a) f,
  ) {
    final $$HighlightSlotsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.highlightSlots,
      getReferencedColumn: (t) => t.collectionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HighlightSlotsTableAnnotationComposer(
            $db: $db,
            $table: $db.highlightSlots,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> collectionDailyMetricsRefs<T extends Object>(
    Expression<T> Function($$CollectionDailyMetricsTableAnnotationComposer a) f,
  ) {
    final $$CollectionDailyMetricsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.collectionDailyMetrics,
          getReferencedColumn: (t) => t.collectionId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$CollectionDailyMetricsTableAnnotationComposer(
                $db: $db,
                $table: $db.collectionDailyMetrics,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> exportLogsRefs<T extends Object>(
    Expression<T> Function($$ExportLogsTableAnnotationComposer a) f,
  ) {
    final $$ExportLogsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.exportLogs,
      getReferencedColumn: (t) => t.collectionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExportLogsTableAnnotationComposer(
            $db: $db,
            $table: $db.exportLogs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> storageSnapshotsRefs<T extends Object>(
    Expression<T> Function($$StorageSnapshotsTableAnnotationComposer a) f,
  ) {
    final $$StorageSnapshotsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.storageSnapshots,
      getReferencedColumn: (t) => t.collectionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StorageSnapshotsTableAnnotationComposer(
            $db: $db,
            $table: $db.storageSnapshots,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CollectionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CollectionsTable,
          CollectionRow,
          $$CollectionsTableFilterComposer,
          $$CollectionsTableOrderingComposer,
          $$CollectionsTableAnnotationComposer,
          $$CollectionsTableCreateCompanionBuilder,
          $$CollectionsTableUpdateCompanionBuilder,
          (CollectionRow, $$CollectionsTableReferences),
          CollectionRow,
          PrefetchHooks Function({
            bool frameStyleId,
            bool collectiblesRefs,
            bool highlightSlotsRefs,
            bool collectionDailyMetricsRefs,
            bool exportLogsRefs,
            bool storageSnapshotsRefs,
          })
        > {
  $$CollectionsTableTableManager(_$AppDatabase db, $CollectionsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CollectionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CollectionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CollectionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<int> sortIndex = const Value.absent(),
                Value<int> frameStyleId = const Value.absent(),
                Value<String?> coverPreviewPath = const Value.absent(),
                Value<DateTime?> coverUpdatedAt = const Value.absent(),
                Value<String> accentColor = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => CollectionsCompanion(
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
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<String?> description = const Value.absent(),
                Value<int> sortIndex = const Value.absent(),
                required int frameStyleId,
                Value<String?> coverPreviewPath = const Value.absent(),
                Value<DateTime?> coverUpdatedAt = const Value.absent(),
                Value<String> accentColor = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => CollectionsCompanion.insert(
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
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$CollectionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                frameStyleId = false,
                collectiblesRefs = false,
                highlightSlotsRefs = false,
                collectionDailyMetricsRefs = false,
                exportLogsRefs = false,
                storageSnapshotsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (collectiblesRefs) db.collectibles,
                    if (highlightSlotsRefs) db.highlightSlots,
                    if (collectionDailyMetricsRefs) db.collectionDailyMetrics,
                    if (exportLogsRefs) db.exportLogs,
                    if (storageSnapshotsRefs) db.storageSnapshots,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (frameStyleId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.frameStyleId,
                                    referencedTable:
                                        $$CollectionsTableReferences
                                            ._frameStyleIdTable(db),
                                    referencedColumn:
                                        $$CollectionsTableReferences
                                            ._frameStyleIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (collectiblesRefs)
                        await $_getPrefetchedData<
                          CollectionRow,
                          $CollectionsTable,
                          CollectibleRow
                        >(
                          currentTable: table,
                          referencedTable: $$CollectionsTableReferences
                              ._collectiblesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CollectionsTableReferences(
                                db,
                                table,
                                p0,
                              ).collectiblesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.collectionId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (highlightSlotsRefs)
                        await $_getPrefetchedData<
                          CollectionRow,
                          $CollectionsTable,
                          HighlightSlotRow
                        >(
                          currentTable: table,
                          referencedTable: $$CollectionsTableReferences
                              ._highlightSlotsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CollectionsTableReferences(
                                db,
                                table,
                                p0,
                              ).highlightSlotsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.collectionId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (collectionDailyMetricsRefs)
                        await $_getPrefetchedData<
                          CollectionRow,
                          $CollectionsTable,
                          CollectionDailyMetricRow
                        >(
                          currentTable: table,
                          referencedTable: $$CollectionsTableReferences
                              ._collectionDailyMetricsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CollectionsTableReferences(
                                db,
                                table,
                                p0,
                              ).collectionDailyMetricsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.collectionId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (exportLogsRefs)
                        await $_getPrefetchedData<
                          CollectionRow,
                          $CollectionsTable,
                          ExportLogRow
                        >(
                          currentTable: table,
                          referencedTable: $$CollectionsTableReferences
                              ._exportLogsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CollectionsTableReferences(
                                db,
                                table,
                                p0,
                              ).exportLogsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.collectionId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (storageSnapshotsRefs)
                        await $_getPrefetchedData<
                          CollectionRow,
                          $CollectionsTable,
                          StorageSnapshotRow
                        >(
                          currentTable: table,
                          referencedTable: $$CollectionsTableReferences
                              ._storageSnapshotsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CollectionsTableReferences(
                                db,
                                table,
                                p0,
                              ).storageSnapshotsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.collectionId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$CollectionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CollectionsTable,
      CollectionRow,
      $$CollectionsTableFilterComposer,
      $$CollectionsTableOrderingComposer,
      $$CollectionsTableAnnotationComposer,
      $$CollectionsTableCreateCompanionBuilder,
      $$CollectionsTableUpdateCompanionBuilder,
      (CollectionRow, $$CollectionsTableReferences),
      CollectionRow,
      PrefetchHooks Function({
        bool frameStyleId,
        bool collectiblesRefs,
        bool highlightSlotsRefs,
        bool collectionDailyMetricsRefs,
        bool exportLogsRefs,
        bool storageSnapshotsRefs,
      })
    >;
typedef $$CollectiblesTableCreateCompanionBuilder =
    CollectiblesCompanion Function({
      Value<int> id,
      required int collectionId,
      required String relativePath,
      Value<String?> thumbnailPath,
      Value<String?> fileHash,
      Value<int> fileSizeBytes,
      required String displayName,
      Value<String?> story,
      Value<int> moodCodePoint,
      Value<String> moodFontFamily,
      Value<String?> moodPackage,
      Value<String> moodColor,
      required DateTime capturedAt,
      required DateTime capturedDate,
      Value<bool> allowHighlight,
      Value<int> sortWeight,
      Value<bool> isArchived,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });
typedef $$CollectiblesTableUpdateCompanionBuilder =
    CollectiblesCompanion Function({
      Value<int> id,
      Value<int> collectionId,
      Value<String> relativePath,
      Value<String?> thumbnailPath,
      Value<String?> fileHash,
      Value<int> fileSizeBytes,
      Value<String> displayName,
      Value<String?> story,
      Value<int> moodCodePoint,
      Value<String> moodFontFamily,
      Value<String?> moodPackage,
      Value<String> moodColor,
      Value<DateTime> capturedAt,
      Value<DateTime> capturedDate,
      Value<bool> allowHighlight,
      Value<int> sortWeight,
      Value<bool> isArchived,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

final class $$CollectiblesTableReferences
    extends BaseReferences<_$AppDatabase, $CollectiblesTable, CollectibleRow> {
  $$CollectiblesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $CollectionsTable _collectionIdTable(_$AppDatabase db) =>
      db.collections.createAlias(
        $_aliasNameGenerator(db.collectibles.collectionId, db.collections.id),
      );

  $$CollectionsTableProcessedTableManager get collectionId {
    final $_column = $_itemColumn<int>('collection_id')!;

    final manager = $$CollectionsTableTableManager(
      $_db,
      $_db.collections,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_collectionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$HighlightSlotsTable, List<HighlightSlotRow>>
  _highlightSlotsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.highlightSlots,
    aliasName: $_aliasNameGenerator(
      db.collectibles.id,
      db.highlightSlots.collectibleId,
    ),
  );

  $$HighlightSlotsTableProcessedTableManager get highlightSlotsRefs {
    final manager = $$HighlightSlotsTableTableManager(
      $_db,
      $_db.highlightSlots,
    ).filter((f) => f.collectibleId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_highlightSlotsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$CollectiblesTableFilterComposer
    extends Composer<_$AppDatabase, $CollectiblesTable> {
  $$CollectiblesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get relativePath => $composableBuilder(
    column: $table.relativePath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get thumbnailPath => $composableBuilder(
    column: $table.thumbnailPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fileHash => $composableBuilder(
    column: $table.fileHash,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get fileSizeBytes => $composableBuilder(
    column: $table.fileSizeBytes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get story => $composableBuilder(
    column: $table.story,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get moodCodePoint => $composableBuilder(
    column: $table.moodCodePoint,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get moodFontFamily => $composableBuilder(
    column: $table.moodFontFamily,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get moodPackage => $composableBuilder(
    column: $table.moodPackage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get moodColor => $composableBuilder(
    column: $table.moodColor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get capturedAt => $composableBuilder(
    column: $table.capturedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get capturedDate => $composableBuilder(
    column: $table.capturedDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get allowHighlight => $composableBuilder(
    column: $table.allowHighlight,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortWeight => $composableBuilder(
    column: $table.sortWeight,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isArchived => $composableBuilder(
    column: $table.isArchived,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$CollectionsTableFilterComposer get collectionId {
    final $$CollectionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.collectionId,
      referencedTable: $db.collections,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CollectionsTableFilterComposer(
            $db: $db,
            $table: $db.collections,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> highlightSlotsRefs(
    Expression<bool> Function($$HighlightSlotsTableFilterComposer f) f,
  ) {
    final $$HighlightSlotsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.highlightSlots,
      getReferencedColumn: (t) => t.collectibleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HighlightSlotsTableFilterComposer(
            $db: $db,
            $table: $db.highlightSlots,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CollectiblesTableOrderingComposer
    extends Composer<_$AppDatabase, $CollectiblesTable> {
  $$CollectiblesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get relativePath => $composableBuilder(
    column: $table.relativePath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get thumbnailPath => $composableBuilder(
    column: $table.thumbnailPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fileHash => $composableBuilder(
    column: $table.fileHash,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get fileSizeBytes => $composableBuilder(
    column: $table.fileSizeBytes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get story => $composableBuilder(
    column: $table.story,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get moodCodePoint => $composableBuilder(
    column: $table.moodCodePoint,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get moodFontFamily => $composableBuilder(
    column: $table.moodFontFamily,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get moodPackage => $composableBuilder(
    column: $table.moodPackage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get moodColor => $composableBuilder(
    column: $table.moodColor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get capturedAt => $composableBuilder(
    column: $table.capturedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get capturedDate => $composableBuilder(
    column: $table.capturedDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get allowHighlight => $composableBuilder(
    column: $table.allowHighlight,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortWeight => $composableBuilder(
    column: $table.sortWeight,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isArchived => $composableBuilder(
    column: $table.isArchived,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$CollectionsTableOrderingComposer get collectionId {
    final $$CollectionsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.collectionId,
      referencedTable: $db.collections,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CollectionsTableOrderingComposer(
            $db: $db,
            $table: $db.collections,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CollectiblesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CollectiblesTable> {
  $$CollectiblesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get relativePath => $composableBuilder(
    column: $table.relativePath,
    builder: (column) => column,
  );

  GeneratedColumn<String> get thumbnailPath => $composableBuilder(
    column: $table.thumbnailPath,
    builder: (column) => column,
  );

  GeneratedColumn<String> get fileHash =>
      $composableBuilder(column: $table.fileHash, builder: (column) => column);

  GeneratedColumn<int> get fileSizeBytes => $composableBuilder(
    column: $table.fileSizeBytes,
    builder: (column) => column,
  );

  GeneratedColumn<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get story =>
      $composableBuilder(column: $table.story, builder: (column) => column);

  GeneratedColumn<int> get moodCodePoint => $composableBuilder(
    column: $table.moodCodePoint,
    builder: (column) => column,
  );

  GeneratedColumn<String> get moodFontFamily => $composableBuilder(
    column: $table.moodFontFamily,
    builder: (column) => column,
  );

  GeneratedColumn<String> get moodPackage => $composableBuilder(
    column: $table.moodPackage,
    builder: (column) => column,
  );

  GeneratedColumn<String> get moodColor =>
      $composableBuilder(column: $table.moodColor, builder: (column) => column);

  GeneratedColumn<DateTime> get capturedAt => $composableBuilder(
    column: $table.capturedAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get capturedDate => $composableBuilder(
    column: $table.capturedDate,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get allowHighlight => $composableBuilder(
    column: $table.allowHighlight,
    builder: (column) => column,
  );

  GeneratedColumn<int> get sortWeight => $composableBuilder(
    column: $table.sortWeight,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isArchived => $composableBuilder(
    column: $table.isArchived,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$CollectionsTableAnnotationComposer get collectionId {
    final $$CollectionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.collectionId,
      referencedTable: $db.collections,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CollectionsTableAnnotationComposer(
            $db: $db,
            $table: $db.collections,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> highlightSlotsRefs<T extends Object>(
    Expression<T> Function($$HighlightSlotsTableAnnotationComposer a) f,
  ) {
    final $$HighlightSlotsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.highlightSlots,
      getReferencedColumn: (t) => t.collectibleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HighlightSlotsTableAnnotationComposer(
            $db: $db,
            $table: $db.highlightSlots,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CollectiblesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CollectiblesTable,
          CollectibleRow,
          $$CollectiblesTableFilterComposer,
          $$CollectiblesTableOrderingComposer,
          $$CollectiblesTableAnnotationComposer,
          $$CollectiblesTableCreateCompanionBuilder,
          $$CollectiblesTableUpdateCompanionBuilder,
          (CollectibleRow, $$CollectiblesTableReferences),
          CollectibleRow,
          PrefetchHooks Function({bool collectionId, bool highlightSlotsRefs})
        > {
  $$CollectiblesTableTableManager(_$AppDatabase db, $CollectiblesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CollectiblesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CollectiblesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CollectiblesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> collectionId = const Value.absent(),
                Value<String> relativePath = const Value.absent(),
                Value<String?> thumbnailPath = const Value.absent(),
                Value<String?> fileHash = const Value.absent(),
                Value<int> fileSizeBytes = const Value.absent(),
                Value<String> displayName = const Value.absent(),
                Value<String?> story = const Value.absent(),
                Value<int> moodCodePoint = const Value.absent(),
                Value<String> moodFontFamily = const Value.absent(),
                Value<String?> moodPackage = const Value.absent(),
                Value<String> moodColor = const Value.absent(),
                Value<DateTime> capturedAt = const Value.absent(),
                Value<DateTime> capturedDate = const Value.absent(),
                Value<bool> allowHighlight = const Value.absent(),
                Value<int> sortWeight = const Value.absent(),
                Value<bool> isArchived = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => CollectiblesCompanion(
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
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int collectionId,
                required String relativePath,
                Value<String?> thumbnailPath = const Value.absent(),
                Value<String?> fileHash = const Value.absent(),
                Value<int> fileSizeBytes = const Value.absent(),
                required String displayName,
                Value<String?> story = const Value.absent(),
                Value<int> moodCodePoint = const Value.absent(),
                Value<String> moodFontFamily = const Value.absent(),
                Value<String?> moodPackage = const Value.absent(),
                Value<String> moodColor = const Value.absent(),
                required DateTime capturedAt,
                required DateTime capturedDate,
                Value<bool> allowHighlight = const Value.absent(),
                Value<int> sortWeight = const Value.absent(),
                Value<bool> isArchived = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => CollectiblesCompanion.insert(
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
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$CollectiblesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({collectionId = false, highlightSlotsRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (highlightSlotsRefs) db.highlightSlots,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (collectionId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.collectionId,
                                    referencedTable:
                                        $$CollectiblesTableReferences
                                            ._collectionIdTable(db),
                                    referencedColumn:
                                        $$CollectiblesTableReferences
                                            ._collectionIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (highlightSlotsRefs)
                        await $_getPrefetchedData<
                          CollectibleRow,
                          $CollectiblesTable,
                          HighlightSlotRow
                        >(
                          currentTable: table,
                          referencedTable: $$CollectiblesTableReferences
                              ._highlightSlotsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CollectiblesTableReferences(
                                db,
                                table,
                                p0,
                              ).highlightSlotsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.collectibleId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$CollectiblesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CollectiblesTable,
      CollectibleRow,
      $$CollectiblesTableFilterComposer,
      $$CollectiblesTableOrderingComposer,
      $$CollectiblesTableAnnotationComposer,
      $$CollectiblesTableCreateCompanionBuilder,
      $$CollectiblesTableUpdateCompanionBuilder,
      (CollectibleRow, $$CollectiblesTableReferences),
      CollectibleRow,
      PrefetchHooks Function({bool collectionId, bool highlightSlotsRefs})
    >;
typedef $$HighlightSlotsTableCreateCompanionBuilder =
    HighlightSlotsCompanion Function({
      Value<int> id,
      required int collectionId,
      required int slotIndex,
      Value<int?> collectibleId,
      Value<bool> isLocked,
      Value<DateTime> updatedAt,
    });
typedef $$HighlightSlotsTableUpdateCompanionBuilder =
    HighlightSlotsCompanion Function({
      Value<int> id,
      Value<int> collectionId,
      Value<int> slotIndex,
      Value<int?> collectibleId,
      Value<bool> isLocked,
      Value<DateTime> updatedAt,
    });

final class $$HighlightSlotsTableReferences
    extends
        BaseReferences<_$AppDatabase, $HighlightSlotsTable, HighlightSlotRow> {
  $$HighlightSlotsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $CollectionsTable _collectionIdTable(_$AppDatabase db) =>
      db.collections.createAlias(
        $_aliasNameGenerator(db.highlightSlots.collectionId, db.collections.id),
      );

  $$CollectionsTableProcessedTableManager get collectionId {
    final $_column = $_itemColumn<int>('collection_id')!;

    final manager = $$CollectionsTableTableManager(
      $_db,
      $_db.collections,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_collectionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $CollectiblesTable _collectibleIdTable(_$AppDatabase db) =>
      db.collectibles.createAlias(
        $_aliasNameGenerator(
          db.highlightSlots.collectibleId,
          db.collectibles.id,
        ),
      );

  $$CollectiblesTableProcessedTableManager? get collectibleId {
    final $_column = $_itemColumn<int>('collectible_id');
    if ($_column == null) return null;
    final manager = $$CollectiblesTableTableManager(
      $_db,
      $_db.collectibles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_collectibleIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$HighlightSlotsTableFilterComposer
    extends Composer<_$AppDatabase, $HighlightSlotsTable> {
  $$HighlightSlotsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get slotIndex => $composableBuilder(
    column: $table.slotIndex,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isLocked => $composableBuilder(
    column: $table.isLocked,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$CollectionsTableFilterComposer get collectionId {
    final $$CollectionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.collectionId,
      referencedTable: $db.collections,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CollectionsTableFilterComposer(
            $db: $db,
            $table: $db.collections,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CollectiblesTableFilterComposer get collectibleId {
    final $$CollectiblesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.collectibleId,
      referencedTable: $db.collectibles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CollectiblesTableFilterComposer(
            $db: $db,
            $table: $db.collectibles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$HighlightSlotsTableOrderingComposer
    extends Composer<_$AppDatabase, $HighlightSlotsTable> {
  $$HighlightSlotsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get slotIndex => $composableBuilder(
    column: $table.slotIndex,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isLocked => $composableBuilder(
    column: $table.isLocked,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$CollectionsTableOrderingComposer get collectionId {
    final $$CollectionsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.collectionId,
      referencedTable: $db.collections,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CollectionsTableOrderingComposer(
            $db: $db,
            $table: $db.collections,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CollectiblesTableOrderingComposer get collectibleId {
    final $$CollectiblesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.collectibleId,
      referencedTable: $db.collectibles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CollectiblesTableOrderingComposer(
            $db: $db,
            $table: $db.collectibles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$HighlightSlotsTableAnnotationComposer
    extends Composer<_$AppDatabase, $HighlightSlotsTable> {
  $$HighlightSlotsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get slotIndex =>
      $composableBuilder(column: $table.slotIndex, builder: (column) => column);

  GeneratedColumn<bool> get isLocked =>
      $composableBuilder(column: $table.isLocked, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$CollectionsTableAnnotationComposer get collectionId {
    final $$CollectionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.collectionId,
      referencedTable: $db.collections,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CollectionsTableAnnotationComposer(
            $db: $db,
            $table: $db.collections,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CollectiblesTableAnnotationComposer get collectibleId {
    final $$CollectiblesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.collectibleId,
      referencedTable: $db.collectibles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CollectiblesTableAnnotationComposer(
            $db: $db,
            $table: $db.collectibles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$HighlightSlotsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $HighlightSlotsTable,
          HighlightSlotRow,
          $$HighlightSlotsTableFilterComposer,
          $$HighlightSlotsTableOrderingComposer,
          $$HighlightSlotsTableAnnotationComposer,
          $$HighlightSlotsTableCreateCompanionBuilder,
          $$HighlightSlotsTableUpdateCompanionBuilder,
          (HighlightSlotRow, $$HighlightSlotsTableReferences),
          HighlightSlotRow,
          PrefetchHooks Function({bool collectionId, bool collectibleId})
        > {
  $$HighlightSlotsTableTableManager(
    _$AppDatabase db,
    $HighlightSlotsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$HighlightSlotsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$HighlightSlotsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$HighlightSlotsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> collectionId = const Value.absent(),
                Value<int> slotIndex = const Value.absent(),
                Value<int?> collectibleId = const Value.absent(),
                Value<bool> isLocked = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => HighlightSlotsCompanion(
                id: id,
                collectionId: collectionId,
                slotIndex: slotIndex,
                collectibleId: collectibleId,
                isLocked: isLocked,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int collectionId,
                required int slotIndex,
                Value<int?> collectibleId = const Value.absent(),
                Value<bool> isLocked = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => HighlightSlotsCompanion.insert(
                id: id,
                collectionId: collectionId,
                slotIndex: slotIndex,
                collectibleId: collectibleId,
                isLocked: isLocked,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$HighlightSlotsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({collectionId = false, collectibleId = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (collectionId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.collectionId,
                                    referencedTable:
                                        $$HighlightSlotsTableReferences
                                            ._collectionIdTable(db),
                                    referencedColumn:
                                        $$HighlightSlotsTableReferences
                                            ._collectionIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (collectibleId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.collectibleId,
                                    referencedTable:
                                        $$HighlightSlotsTableReferences
                                            ._collectibleIdTable(db),
                                    referencedColumn:
                                        $$HighlightSlotsTableReferences
                                            ._collectibleIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [];
                  },
                );
              },
        ),
      );
}

typedef $$HighlightSlotsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $HighlightSlotsTable,
      HighlightSlotRow,
      $$HighlightSlotsTableFilterComposer,
      $$HighlightSlotsTableOrderingComposer,
      $$HighlightSlotsTableAnnotationComposer,
      $$HighlightSlotsTableCreateCompanionBuilder,
      $$HighlightSlotsTableUpdateCompanionBuilder,
      (HighlightSlotRow, $$HighlightSlotsTableReferences),
      HighlightSlotRow,
      PrefetchHooks Function({bool collectionId, bool collectibleId})
    >;
typedef $$CollectionDailyMetricsTableCreateCompanionBuilder =
    CollectionDailyMetricsCompanion Function({
      Value<int> id,
      Value<int?> collectionId,
      required DateTime statDate,
      Value<int> itemCount,
      Value<int?> firstCollectibleId,
      Value<int?> lastCollectibleId,
      Value<DateTime> lastSyncedAt,
    });
typedef $$CollectionDailyMetricsTableUpdateCompanionBuilder =
    CollectionDailyMetricsCompanion Function({
      Value<int> id,
      Value<int?> collectionId,
      Value<DateTime> statDate,
      Value<int> itemCount,
      Value<int?> firstCollectibleId,
      Value<int?> lastCollectibleId,
      Value<DateTime> lastSyncedAt,
    });

final class $$CollectionDailyMetricsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $CollectionDailyMetricsTable,
          CollectionDailyMetricRow
        > {
  $$CollectionDailyMetricsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $CollectionsTable _collectionIdTable(_$AppDatabase db) =>
      db.collections.createAlias(
        $_aliasNameGenerator(
          db.collectionDailyMetrics.collectionId,
          db.collections.id,
        ),
      );

  $$CollectionsTableProcessedTableManager? get collectionId {
    final $_column = $_itemColumn<int>('collection_id');
    if ($_column == null) return null;
    final manager = $$CollectionsTableTableManager(
      $_db,
      $_db.collections,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_collectionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $CollectiblesTable _firstCollectibleIdTable(_$AppDatabase db) =>
      db.collectibles.createAlias(
        $_aliasNameGenerator(
          db.collectionDailyMetrics.firstCollectibleId,
          db.collectibles.id,
        ),
      );

  $$CollectiblesTableProcessedTableManager? get firstCollectibleId {
    final $_column = $_itemColumn<int>('first_collectible_id');
    if ($_column == null) return null;
    final manager = $$CollectiblesTableTableManager(
      $_db,
      $_db.collectibles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_firstCollectibleIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $CollectiblesTable _lastCollectibleIdTable(_$AppDatabase db) =>
      db.collectibles.createAlias(
        $_aliasNameGenerator(
          db.collectionDailyMetrics.lastCollectibleId,
          db.collectibles.id,
        ),
      );

  $$CollectiblesTableProcessedTableManager? get lastCollectibleId {
    final $_column = $_itemColumn<int>('last_collectible_id');
    if ($_column == null) return null;
    final manager = $$CollectiblesTableTableManager(
      $_db,
      $_db.collectibles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_lastCollectibleIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$CollectionDailyMetricsTableFilterComposer
    extends Composer<_$AppDatabase, $CollectionDailyMetricsTable> {
  $$CollectionDailyMetricsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get statDate => $composableBuilder(
    column: $table.statDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get itemCount => $composableBuilder(
    column: $table.itemCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$CollectionsTableFilterComposer get collectionId {
    final $$CollectionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.collectionId,
      referencedTable: $db.collections,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CollectionsTableFilterComposer(
            $db: $db,
            $table: $db.collections,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CollectiblesTableFilterComposer get firstCollectibleId {
    final $$CollectiblesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.firstCollectibleId,
      referencedTable: $db.collectibles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CollectiblesTableFilterComposer(
            $db: $db,
            $table: $db.collectibles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CollectiblesTableFilterComposer get lastCollectibleId {
    final $$CollectiblesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.lastCollectibleId,
      referencedTable: $db.collectibles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CollectiblesTableFilterComposer(
            $db: $db,
            $table: $db.collectibles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CollectionDailyMetricsTableOrderingComposer
    extends Composer<_$AppDatabase, $CollectionDailyMetricsTable> {
  $$CollectionDailyMetricsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get statDate => $composableBuilder(
    column: $table.statDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get itemCount => $composableBuilder(
    column: $table.itemCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$CollectionsTableOrderingComposer get collectionId {
    final $$CollectionsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.collectionId,
      referencedTable: $db.collections,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CollectionsTableOrderingComposer(
            $db: $db,
            $table: $db.collections,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CollectiblesTableOrderingComposer get firstCollectibleId {
    final $$CollectiblesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.firstCollectibleId,
      referencedTable: $db.collectibles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CollectiblesTableOrderingComposer(
            $db: $db,
            $table: $db.collectibles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CollectiblesTableOrderingComposer get lastCollectibleId {
    final $$CollectiblesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.lastCollectibleId,
      referencedTable: $db.collectibles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CollectiblesTableOrderingComposer(
            $db: $db,
            $table: $db.collectibles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CollectionDailyMetricsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CollectionDailyMetricsTable> {
  $$CollectionDailyMetricsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get statDate =>
      $composableBuilder(column: $table.statDate, builder: (column) => column);

  GeneratedColumn<int> get itemCount =>
      $composableBuilder(column: $table.itemCount, builder: (column) => column);

  GeneratedColumn<DateTime> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => column,
  );

  $$CollectionsTableAnnotationComposer get collectionId {
    final $$CollectionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.collectionId,
      referencedTable: $db.collections,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CollectionsTableAnnotationComposer(
            $db: $db,
            $table: $db.collections,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CollectiblesTableAnnotationComposer get firstCollectibleId {
    final $$CollectiblesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.firstCollectibleId,
      referencedTable: $db.collectibles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CollectiblesTableAnnotationComposer(
            $db: $db,
            $table: $db.collectibles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CollectiblesTableAnnotationComposer get lastCollectibleId {
    final $$CollectiblesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.lastCollectibleId,
      referencedTable: $db.collectibles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CollectiblesTableAnnotationComposer(
            $db: $db,
            $table: $db.collectibles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CollectionDailyMetricsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CollectionDailyMetricsTable,
          CollectionDailyMetricRow,
          $$CollectionDailyMetricsTableFilterComposer,
          $$CollectionDailyMetricsTableOrderingComposer,
          $$CollectionDailyMetricsTableAnnotationComposer,
          $$CollectionDailyMetricsTableCreateCompanionBuilder,
          $$CollectionDailyMetricsTableUpdateCompanionBuilder,
          (CollectionDailyMetricRow, $$CollectionDailyMetricsTableReferences),
          CollectionDailyMetricRow,
          PrefetchHooks Function({
            bool collectionId,
            bool firstCollectibleId,
            bool lastCollectibleId,
          })
        > {
  $$CollectionDailyMetricsTableTableManager(
    _$AppDatabase db,
    $CollectionDailyMetricsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CollectionDailyMetricsTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$CollectionDailyMetricsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$CollectionDailyMetricsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int?> collectionId = const Value.absent(),
                Value<DateTime> statDate = const Value.absent(),
                Value<int> itemCount = const Value.absent(),
                Value<int?> firstCollectibleId = const Value.absent(),
                Value<int?> lastCollectibleId = const Value.absent(),
                Value<DateTime> lastSyncedAt = const Value.absent(),
              }) => CollectionDailyMetricsCompanion(
                id: id,
                collectionId: collectionId,
                statDate: statDate,
                itemCount: itemCount,
                firstCollectibleId: firstCollectibleId,
                lastCollectibleId: lastCollectibleId,
                lastSyncedAt: lastSyncedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int?> collectionId = const Value.absent(),
                required DateTime statDate,
                Value<int> itemCount = const Value.absent(),
                Value<int?> firstCollectibleId = const Value.absent(),
                Value<int?> lastCollectibleId = const Value.absent(),
                Value<DateTime> lastSyncedAt = const Value.absent(),
              }) => CollectionDailyMetricsCompanion.insert(
                id: id,
                collectionId: collectionId,
                statDate: statDate,
                itemCount: itemCount,
                firstCollectibleId: firstCollectibleId,
                lastCollectibleId: lastCollectibleId,
                lastSyncedAt: lastSyncedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$CollectionDailyMetricsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                collectionId = false,
                firstCollectibleId = false,
                lastCollectibleId = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (collectionId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.collectionId,
                                    referencedTable:
                                        $$CollectionDailyMetricsTableReferences
                                            ._collectionIdTable(db),
                                    referencedColumn:
                                        $$CollectionDailyMetricsTableReferences
                                            ._collectionIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (firstCollectibleId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.firstCollectibleId,
                                    referencedTable:
                                        $$CollectionDailyMetricsTableReferences
                                            ._firstCollectibleIdTable(db),
                                    referencedColumn:
                                        $$CollectionDailyMetricsTableReferences
                                            ._firstCollectibleIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (lastCollectibleId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.lastCollectibleId,
                                    referencedTable:
                                        $$CollectionDailyMetricsTableReferences
                                            ._lastCollectibleIdTable(db),
                                    referencedColumn:
                                        $$CollectionDailyMetricsTableReferences
                                            ._lastCollectibleIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [];
                  },
                );
              },
        ),
      );
}

typedef $$CollectionDailyMetricsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CollectionDailyMetricsTable,
      CollectionDailyMetricRow,
      $$CollectionDailyMetricsTableFilterComposer,
      $$CollectionDailyMetricsTableOrderingComposer,
      $$CollectionDailyMetricsTableAnnotationComposer,
      $$CollectionDailyMetricsTableCreateCompanionBuilder,
      $$CollectionDailyMetricsTableUpdateCompanionBuilder,
      (CollectionDailyMetricRow, $$CollectionDailyMetricsTableReferences),
      CollectionDailyMetricRow,
      PrefetchHooks Function({
        bool collectionId,
        bool firstCollectibleId,
        bool lastCollectibleId,
      })
    >;
typedef $$ExportLogsTableCreateCompanionBuilder =
    ExportLogsCompanion Function({
      Value<int> id,
      required int collectionId,
      required String exportPath,
      required String fileName,
      Value<String> resolutionPx,
      Value<int> fileSizeBytes,
      Value<DateTime> createdAt,
    });
typedef $$ExportLogsTableUpdateCompanionBuilder =
    ExportLogsCompanion Function({
      Value<int> id,
      Value<int> collectionId,
      Value<String> exportPath,
      Value<String> fileName,
      Value<String> resolutionPx,
      Value<int> fileSizeBytes,
      Value<DateTime> createdAt,
    });

final class $$ExportLogsTableReferences
    extends BaseReferences<_$AppDatabase, $ExportLogsTable, ExportLogRow> {
  $$ExportLogsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $CollectionsTable _collectionIdTable(_$AppDatabase db) =>
      db.collections.createAlias(
        $_aliasNameGenerator(db.exportLogs.collectionId, db.collections.id),
      );

  $$CollectionsTableProcessedTableManager get collectionId {
    final $_column = $_itemColumn<int>('collection_id')!;

    final manager = $$CollectionsTableTableManager(
      $_db,
      $_db.collections,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_collectionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ExportLogsTableFilterComposer
    extends Composer<_$AppDatabase, $ExportLogsTable> {
  $$ExportLogsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get exportPath => $composableBuilder(
    column: $table.exportPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fileName => $composableBuilder(
    column: $table.fileName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get resolutionPx => $composableBuilder(
    column: $table.resolutionPx,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get fileSizeBytes => $composableBuilder(
    column: $table.fileSizeBytes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$CollectionsTableFilterComposer get collectionId {
    final $$CollectionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.collectionId,
      referencedTable: $db.collections,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CollectionsTableFilterComposer(
            $db: $db,
            $table: $db.collections,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ExportLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $ExportLogsTable> {
  $$ExportLogsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get exportPath => $composableBuilder(
    column: $table.exportPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fileName => $composableBuilder(
    column: $table.fileName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get resolutionPx => $composableBuilder(
    column: $table.resolutionPx,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get fileSizeBytes => $composableBuilder(
    column: $table.fileSizeBytes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$CollectionsTableOrderingComposer get collectionId {
    final $$CollectionsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.collectionId,
      referencedTable: $db.collections,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CollectionsTableOrderingComposer(
            $db: $db,
            $table: $db.collections,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ExportLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ExportLogsTable> {
  $$ExportLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get exportPath => $composableBuilder(
    column: $table.exportPath,
    builder: (column) => column,
  );

  GeneratedColumn<String> get fileName =>
      $composableBuilder(column: $table.fileName, builder: (column) => column);

  GeneratedColumn<String> get resolutionPx => $composableBuilder(
    column: $table.resolutionPx,
    builder: (column) => column,
  );

  GeneratedColumn<int> get fileSizeBytes => $composableBuilder(
    column: $table.fileSizeBytes,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$CollectionsTableAnnotationComposer get collectionId {
    final $$CollectionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.collectionId,
      referencedTable: $db.collections,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CollectionsTableAnnotationComposer(
            $db: $db,
            $table: $db.collections,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ExportLogsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ExportLogsTable,
          ExportLogRow,
          $$ExportLogsTableFilterComposer,
          $$ExportLogsTableOrderingComposer,
          $$ExportLogsTableAnnotationComposer,
          $$ExportLogsTableCreateCompanionBuilder,
          $$ExportLogsTableUpdateCompanionBuilder,
          (ExportLogRow, $$ExportLogsTableReferences),
          ExportLogRow,
          PrefetchHooks Function({bool collectionId})
        > {
  $$ExportLogsTableTableManager(_$AppDatabase db, $ExportLogsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExportLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExportLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ExportLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> collectionId = const Value.absent(),
                Value<String> exportPath = const Value.absent(),
                Value<String> fileName = const Value.absent(),
                Value<String> resolutionPx = const Value.absent(),
                Value<int> fileSizeBytes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => ExportLogsCompanion(
                id: id,
                collectionId: collectionId,
                exportPath: exportPath,
                fileName: fileName,
                resolutionPx: resolutionPx,
                fileSizeBytes: fileSizeBytes,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int collectionId,
                required String exportPath,
                required String fileName,
                Value<String> resolutionPx = const Value.absent(),
                Value<int> fileSizeBytes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => ExportLogsCompanion.insert(
                id: id,
                collectionId: collectionId,
                exportPath: exportPath,
                fileName: fileName,
                resolutionPx: resolutionPx,
                fileSizeBytes: fileSizeBytes,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ExportLogsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({collectionId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (collectionId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.collectionId,
                                referencedTable: $$ExportLogsTableReferences
                                    ._collectionIdTable(db),
                                referencedColumn: $$ExportLogsTableReferences
                                    ._collectionIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ExportLogsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ExportLogsTable,
      ExportLogRow,
      $$ExportLogsTableFilterComposer,
      $$ExportLogsTableOrderingComposer,
      $$ExportLogsTableAnnotationComposer,
      $$ExportLogsTableCreateCompanionBuilder,
      $$ExportLogsTableUpdateCompanionBuilder,
      (ExportLogRow, $$ExportLogsTableReferences),
      ExportLogRow,
      PrefetchHooks Function({bool collectionId})
    >;
typedef $$StorageSnapshotsTableCreateCompanionBuilder =
    StorageSnapshotsCompanion Function({
      Value<int> id,
      Value<int?> collectionId,
      Value<int> totalBytes,
      Value<int> thumbnailBytes,
      Value<int> itemsCount,
      Value<DateTime> computedAt,
    });
typedef $$StorageSnapshotsTableUpdateCompanionBuilder =
    StorageSnapshotsCompanion Function({
      Value<int> id,
      Value<int?> collectionId,
      Value<int> totalBytes,
      Value<int> thumbnailBytes,
      Value<int> itemsCount,
      Value<DateTime> computedAt,
    });

final class $$StorageSnapshotsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $StorageSnapshotsTable,
          StorageSnapshotRow
        > {
  $$StorageSnapshotsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $CollectionsTable _collectionIdTable(_$AppDatabase db) =>
      db.collections.createAlias(
        $_aliasNameGenerator(
          db.storageSnapshots.collectionId,
          db.collections.id,
        ),
      );

  $$CollectionsTableProcessedTableManager? get collectionId {
    final $_column = $_itemColumn<int>('collection_id');
    if ($_column == null) return null;
    final manager = $$CollectionsTableTableManager(
      $_db,
      $_db.collections,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_collectionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$StorageSnapshotsTableFilterComposer
    extends Composer<_$AppDatabase, $StorageSnapshotsTable> {
  $$StorageSnapshotsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalBytes => $composableBuilder(
    column: $table.totalBytes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get thumbnailBytes => $composableBuilder(
    column: $table.thumbnailBytes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get itemsCount => $composableBuilder(
    column: $table.itemsCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get computedAt => $composableBuilder(
    column: $table.computedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$CollectionsTableFilterComposer get collectionId {
    final $$CollectionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.collectionId,
      referencedTable: $db.collections,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CollectionsTableFilterComposer(
            $db: $db,
            $table: $db.collections,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$StorageSnapshotsTableOrderingComposer
    extends Composer<_$AppDatabase, $StorageSnapshotsTable> {
  $$StorageSnapshotsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalBytes => $composableBuilder(
    column: $table.totalBytes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get thumbnailBytes => $composableBuilder(
    column: $table.thumbnailBytes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get itemsCount => $composableBuilder(
    column: $table.itemsCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get computedAt => $composableBuilder(
    column: $table.computedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$CollectionsTableOrderingComposer get collectionId {
    final $$CollectionsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.collectionId,
      referencedTable: $db.collections,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CollectionsTableOrderingComposer(
            $db: $db,
            $table: $db.collections,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$StorageSnapshotsTableAnnotationComposer
    extends Composer<_$AppDatabase, $StorageSnapshotsTable> {
  $$StorageSnapshotsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get totalBytes => $composableBuilder(
    column: $table.totalBytes,
    builder: (column) => column,
  );

  GeneratedColumn<int> get thumbnailBytes => $composableBuilder(
    column: $table.thumbnailBytes,
    builder: (column) => column,
  );

  GeneratedColumn<int> get itemsCount => $composableBuilder(
    column: $table.itemsCount,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get computedAt => $composableBuilder(
    column: $table.computedAt,
    builder: (column) => column,
  );

  $$CollectionsTableAnnotationComposer get collectionId {
    final $$CollectionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.collectionId,
      referencedTable: $db.collections,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CollectionsTableAnnotationComposer(
            $db: $db,
            $table: $db.collections,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$StorageSnapshotsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $StorageSnapshotsTable,
          StorageSnapshotRow,
          $$StorageSnapshotsTableFilterComposer,
          $$StorageSnapshotsTableOrderingComposer,
          $$StorageSnapshotsTableAnnotationComposer,
          $$StorageSnapshotsTableCreateCompanionBuilder,
          $$StorageSnapshotsTableUpdateCompanionBuilder,
          (StorageSnapshotRow, $$StorageSnapshotsTableReferences),
          StorageSnapshotRow,
          PrefetchHooks Function({bool collectionId})
        > {
  $$StorageSnapshotsTableTableManager(
    _$AppDatabase db,
    $StorageSnapshotsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StorageSnapshotsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StorageSnapshotsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StorageSnapshotsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int?> collectionId = const Value.absent(),
                Value<int> totalBytes = const Value.absent(),
                Value<int> thumbnailBytes = const Value.absent(),
                Value<int> itemsCount = const Value.absent(),
                Value<DateTime> computedAt = const Value.absent(),
              }) => StorageSnapshotsCompanion(
                id: id,
                collectionId: collectionId,
                totalBytes: totalBytes,
                thumbnailBytes: thumbnailBytes,
                itemsCount: itemsCount,
                computedAt: computedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int?> collectionId = const Value.absent(),
                Value<int> totalBytes = const Value.absent(),
                Value<int> thumbnailBytes = const Value.absent(),
                Value<int> itemsCount = const Value.absent(),
                Value<DateTime> computedAt = const Value.absent(),
              }) => StorageSnapshotsCompanion.insert(
                id: id,
                collectionId: collectionId,
                totalBytes: totalBytes,
                thumbnailBytes: thumbnailBytes,
                itemsCount: itemsCount,
                computedAt: computedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$StorageSnapshotsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({collectionId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (collectionId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.collectionId,
                                referencedTable:
                                    $$StorageSnapshotsTableReferences
                                        ._collectionIdTable(db),
                                referencedColumn:
                                    $$StorageSnapshotsTableReferences
                                        ._collectionIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$StorageSnapshotsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $StorageSnapshotsTable,
      StorageSnapshotRow,
      $$StorageSnapshotsTableFilterComposer,
      $$StorageSnapshotsTableOrderingComposer,
      $$StorageSnapshotsTableAnnotationComposer,
      $$StorageSnapshotsTableCreateCompanionBuilder,
      $$StorageSnapshotsTableUpdateCompanionBuilder,
      (StorageSnapshotRow, $$StorageSnapshotsTableReferences),
      StorageSnapshotRow,
      PrefetchHooks Function({bool collectionId})
    >;
typedef $$AppPreferencesTableCreateCompanionBuilder =
    AppPreferencesCompanion Function({
      Value<int> id,
      Value<String> rootDirectory,
      Value<String> importMode,
      Value<String?> lastExportDir,
      Value<DateTime?> lastDirectoryCheckAt,
      Value<int?> totalStorageBytes,
      Value<bool> analyticsOptIn,
    });
typedef $$AppPreferencesTableUpdateCompanionBuilder =
    AppPreferencesCompanion Function({
      Value<int> id,
      Value<String> rootDirectory,
      Value<String> importMode,
      Value<String?> lastExportDir,
      Value<DateTime?> lastDirectoryCheckAt,
      Value<int?> totalStorageBytes,
      Value<bool> analyticsOptIn,
    });

class $$AppPreferencesTableFilterComposer
    extends Composer<_$AppDatabase, $AppPreferencesTable> {
  $$AppPreferencesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get rootDirectory => $composableBuilder(
    column: $table.rootDirectory,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get importMode => $composableBuilder(
    column: $table.importMode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastExportDir => $composableBuilder(
    column: $table.lastExportDir,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastDirectoryCheckAt => $composableBuilder(
    column: $table.lastDirectoryCheckAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalStorageBytes => $composableBuilder(
    column: $table.totalStorageBytes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get analyticsOptIn => $composableBuilder(
    column: $table.analyticsOptIn,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AppPreferencesTableOrderingComposer
    extends Composer<_$AppDatabase, $AppPreferencesTable> {
  $$AppPreferencesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get rootDirectory => $composableBuilder(
    column: $table.rootDirectory,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get importMode => $composableBuilder(
    column: $table.importMode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastExportDir => $composableBuilder(
    column: $table.lastExportDir,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastDirectoryCheckAt => $composableBuilder(
    column: $table.lastDirectoryCheckAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalStorageBytes => $composableBuilder(
    column: $table.totalStorageBytes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get analyticsOptIn => $composableBuilder(
    column: $table.analyticsOptIn,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AppPreferencesTableAnnotationComposer
    extends Composer<_$AppDatabase, $AppPreferencesTable> {
  $$AppPreferencesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get rootDirectory => $composableBuilder(
    column: $table.rootDirectory,
    builder: (column) => column,
  );

  GeneratedColumn<String> get importMode => $composableBuilder(
    column: $table.importMode,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lastExportDir => $composableBuilder(
    column: $table.lastExportDir,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastDirectoryCheckAt => $composableBuilder(
    column: $table.lastDirectoryCheckAt,
    builder: (column) => column,
  );

  GeneratedColumn<int> get totalStorageBytes => $composableBuilder(
    column: $table.totalStorageBytes,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get analyticsOptIn => $composableBuilder(
    column: $table.analyticsOptIn,
    builder: (column) => column,
  );
}

class $$AppPreferencesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AppPreferencesTable,
          AppPreferenceRow,
          $$AppPreferencesTableFilterComposer,
          $$AppPreferencesTableOrderingComposer,
          $$AppPreferencesTableAnnotationComposer,
          $$AppPreferencesTableCreateCompanionBuilder,
          $$AppPreferencesTableUpdateCompanionBuilder,
          (
            AppPreferenceRow,
            BaseReferences<
              _$AppDatabase,
              $AppPreferencesTable,
              AppPreferenceRow
            >,
          ),
          AppPreferenceRow,
          PrefetchHooks Function()
        > {
  $$AppPreferencesTableTableManager(
    _$AppDatabase db,
    $AppPreferencesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AppPreferencesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AppPreferencesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AppPreferencesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> rootDirectory = const Value.absent(),
                Value<String> importMode = const Value.absent(),
                Value<String?> lastExportDir = const Value.absent(),
                Value<DateTime?> lastDirectoryCheckAt = const Value.absent(),
                Value<int?> totalStorageBytes = const Value.absent(),
                Value<bool> analyticsOptIn = const Value.absent(),
              }) => AppPreferencesCompanion(
                id: id,
                rootDirectory: rootDirectory,
                importMode: importMode,
                lastExportDir: lastExportDir,
                lastDirectoryCheckAt: lastDirectoryCheckAt,
                totalStorageBytes: totalStorageBytes,
                analyticsOptIn: analyticsOptIn,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> rootDirectory = const Value.absent(),
                Value<String> importMode = const Value.absent(),
                Value<String?> lastExportDir = const Value.absent(),
                Value<DateTime?> lastDirectoryCheckAt = const Value.absent(),
                Value<int?> totalStorageBytes = const Value.absent(),
                Value<bool> analyticsOptIn = const Value.absent(),
              }) => AppPreferencesCompanion.insert(
                id: id,
                rootDirectory: rootDirectory,
                importMode: importMode,
                lastExportDir: lastExportDir,
                lastDirectoryCheckAt: lastDirectoryCheckAt,
                totalStorageBytes: totalStorageBytes,
                analyticsOptIn: analyticsOptIn,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AppPreferencesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AppPreferencesTable,
      AppPreferenceRow,
      $$AppPreferencesTableFilterComposer,
      $$AppPreferencesTableOrderingComposer,
      $$AppPreferencesTableAnnotationComposer,
      $$AppPreferencesTableCreateCompanionBuilder,
      $$AppPreferencesTableUpdateCompanionBuilder,
      (
        AppPreferenceRow,
        BaseReferences<_$AppDatabase, $AppPreferencesTable, AppPreferenceRow>,
      ),
      AppPreferenceRow,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$FrameStylesTableTableManager get frameStyles =>
      $$FrameStylesTableTableManager(_db, _db.frameStyles);
  $$CollectionsTableTableManager get collections =>
      $$CollectionsTableTableManager(_db, _db.collections);
  $$CollectiblesTableTableManager get collectibles =>
      $$CollectiblesTableTableManager(_db, _db.collectibles);
  $$HighlightSlotsTableTableManager get highlightSlots =>
      $$HighlightSlotsTableTableManager(_db, _db.highlightSlots);
  $$CollectionDailyMetricsTableTableManager get collectionDailyMetrics =>
      $$CollectionDailyMetricsTableTableManager(
        _db,
        _db.collectionDailyMetrics,
      );
  $$ExportLogsTableTableManager get exportLogs =>
      $$ExportLogsTableTableManager(_db, _db.exportLogs);
  $$StorageSnapshotsTableTableManager get storageSnapshots =>
      $$StorageSnapshotsTableTableManager(_db, _db.storageSnapshots);
  $$AppPreferencesTableTableManager get appPreferences =>
      $$AppPreferencesTableTableManager(_db, _db.appPreferences);
}

mixin _$CollectionsDaoMixin on DatabaseAccessor<AppDatabase> {
  $FrameStylesTable get frameStyles => attachedDatabase.frameStyles;
  $CollectionsTable get collections => attachedDatabase.collections;
  $CollectiblesTable get collectibles => attachedDatabase.collectibles;
}
mixin _$CollectiblesDaoMixin on DatabaseAccessor<AppDatabase> {
  $FrameStylesTable get frameStyles => attachedDatabase.frameStyles;
  $CollectionsTable get collections => attachedDatabase.collections;
  $CollectiblesTable get collectibles => attachedDatabase.collectibles;
}
mixin _$HighlightSlotsDaoMixin on DatabaseAccessor<AppDatabase> {
  $FrameStylesTable get frameStyles => attachedDatabase.frameStyles;
  $CollectionsTable get collections => attachedDatabase.collections;
  $CollectiblesTable get collectibles => attachedDatabase.collectibles;
  $HighlightSlotsTable get highlightSlots => attachedDatabase.highlightSlots;
}
