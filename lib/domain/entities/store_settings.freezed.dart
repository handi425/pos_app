// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'store_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

StoreSettings _$StoreSettingsFromJson(Map<String, dynamic> json) {
  return _StoreSettings.fromJson(json);
}

/// @nodoc
mixin _$StoreSettings {
  int get id => throw _privateConstructorUsedError;
  String get storeName => throw _privateConstructorUsedError;
  String get address => throw _privateConstructorUsedError;
  String get phone => throw _privateConstructorUsedError;
  int get defaultTax => throw _privateConstructorUsedError;
  String? get printerName => throw _privateConstructorUsedError;
  bool get darkMode => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this StoreSettings to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StoreSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StoreSettingsCopyWith<StoreSettings> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StoreSettingsCopyWith<$Res> {
  factory $StoreSettingsCopyWith(
    StoreSettings value,
    $Res Function(StoreSettings) then,
  ) = _$StoreSettingsCopyWithImpl<$Res, StoreSettings>;
  @useResult
  $Res call({
    int id,
    String storeName,
    String address,
    String phone,
    int defaultTax,
    String? printerName,
    bool darkMode,
    DateTime? updatedAt,
  });
}

/// @nodoc
class _$StoreSettingsCopyWithImpl<$Res, $Val extends StoreSettings>
    implements $StoreSettingsCopyWith<$Res> {
  _$StoreSettingsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StoreSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? storeName = null,
    Object? address = null,
    Object? phone = null,
    Object? defaultTax = null,
    Object? printerName = freezed,
    Object? darkMode = null,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            storeName: null == storeName
                ? _value.storeName
                : storeName // ignore: cast_nullable_to_non_nullable
                      as String,
            address: null == address
                ? _value.address
                : address // ignore: cast_nullable_to_non_nullable
                      as String,
            phone: null == phone
                ? _value.phone
                : phone // ignore: cast_nullable_to_non_nullable
                      as String,
            defaultTax: null == defaultTax
                ? _value.defaultTax
                : defaultTax // ignore: cast_nullable_to_non_nullable
                      as int,
            printerName: freezed == printerName
                ? _value.printerName
                : printerName // ignore: cast_nullable_to_non_nullable
                      as String?,
            darkMode: null == darkMode
                ? _value.darkMode
                : darkMode // ignore: cast_nullable_to_non_nullable
                      as bool,
            updatedAt: freezed == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$StoreSettingsImplCopyWith<$Res>
    implements $StoreSettingsCopyWith<$Res> {
  factory _$$StoreSettingsImplCopyWith(
    _$StoreSettingsImpl value,
    $Res Function(_$StoreSettingsImpl) then,
  ) = __$$StoreSettingsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    String storeName,
    String address,
    String phone,
    int defaultTax,
    String? printerName,
    bool darkMode,
    DateTime? updatedAt,
  });
}

/// @nodoc
class __$$StoreSettingsImplCopyWithImpl<$Res>
    extends _$StoreSettingsCopyWithImpl<$Res, _$StoreSettingsImpl>
    implements _$$StoreSettingsImplCopyWith<$Res> {
  __$$StoreSettingsImplCopyWithImpl(
    _$StoreSettingsImpl _value,
    $Res Function(_$StoreSettingsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of StoreSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? storeName = null,
    Object? address = null,
    Object? phone = null,
    Object? defaultTax = null,
    Object? printerName = freezed,
    Object? darkMode = null,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _$StoreSettingsImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        storeName: null == storeName
            ? _value.storeName
            : storeName // ignore: cast_nullable_to_non_nullable
                  as String,
        address: null == address
            ? _value.address
            : address // ignore: cast_nullable_to_non_nullable
                  as String,
        phone: null == phone
            ? _value.phone
            : phone // ignore: cast_nullable_to_non_nullable
                  as String,
        defaultTax: null == defaultTax
            ? _value.defaultTax
            : defaultTax // ignore: cast_nullable_to_non_nullable
                  as int,
        printerName: freezed == printerName
            ? _value.printerName
            : printerName // ignore: cast_nullable_to_non_nullable
                  as String?,
        darkMode: null == darkMode
            ? _value.darkMode
            : darkMode // ignore: cast_nullable_to_non_nullable
                  as bool,
        updatedAt: freezed == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$StoreSettingsImpl implements _StoreSettings {
  const _$StoreSettingsImpl({
    required this.id,
    required this.storeName,
    required this.address,
    required this.phone,
    required this.defaultTax,
    this.printerName,
    required this.darkMode,
    this.updatedAt,
  });

  factory _$StoreSettingsImpl.fromJson(Map<String, dynamic> json) =>
      _$$StoreSettingsImplFromJson(json);

  @override
  final int id;
  @override
  final String storeName;
  @override
  final String address;
  @override
  final String phone;
  @override
  final int defaultTax;
  @override
  final String? printerName;
  @override
  final bool darkMode;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'StoreSettings(id: $id, storeName: $storeName, address: $address, phone: $phone, defaultTax: $defaultTax, printerName: $printerName, darkMode: $darkMode, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StoreSettingsImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.storeName, storeName) ||
                other.storeName == storeName) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.defaultTax, defaultTax) ||
                other.defaultTax == defaultTax) &&
            (identical(other.printerName, printerName) ||
                other.printerName == printerName) &&
            (identical(other.darkMode, darkMode) ||
                other.darkMode == darkMode) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    storeName,
    address,
    phone,
    defaultTax,
    printerName,
    darkMode,
    updatedAt,
  );

  /// Create a copy of StoreSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StoreSettingsImplCopyWith<_$StoreSettingsImpl> get copyWith =>
      __$$StoreSettingsImplCopyWithImpl<_$StoreSettingsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StoreSettingsImplToJson(this);
  }
}

abstract class _StoreSettings implements StoreSettings {
  const factory _StoreSettings({
    required final int id,
    required final String storeName,
    required final String address,
    required final String phone,
    required final int defaultTax,
    final String? printerName,
    required final bool darkMode,
    final DateTime? updatedAt,
  }) = _$StoreSettingsImpl;

  factory _StoreSettings.fromJson(Map<String, dynamic> json) =
      _$StoreSettingsImpl.fromJson;

  @override
  int get id;
  @override
  String get storeName;
  @override
  String get address;
  @override
  String get phone;
  @override
  int get defaultTax;
  @override
  String? get printerName;
  @override
  bool get darkMode;
  @override
  DateTime? get updatedAt;

  /// Create a copy of StoreSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StoreSettingsImplCopyWith<_$StoreSettingsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
