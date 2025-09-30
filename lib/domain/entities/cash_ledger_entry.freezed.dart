// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cash_ledger_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

CashLedgerEntry _$CashLedgerEntryFromJson(Map<String, dynamic> json) {
  return _CashLedgerEntry.fromJson(json);
}

/// @nodoc
mixin _$CashLedgerEntry {
  int get id => throw _privateConstructorUsedError;
  CashMovementType get type => throw _privateConstructorUsedError;
  int get amount => throw _privateConstructorUsedError;
  CashReferenceType get refType => throw _privateConstructorUsedError;
  int? get refId => throw _privateConstructorUsedError;
  String? get note => throw _privateConstructorUsedError;
  DateTime get datetime => throw _privateConstructorUsedError;
  AppUser? get user => throw _privateConstructorUsedError;

  /// Serializes this CashLedgerEntry to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CashLedgerEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CashLedgerEntryCopyWith<CashLedgerEntry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CashLedgerEntryCopyWith<$Res> {
  factory $CashLedgerEntryCopyWith(
    CashLedgerEntry value,
    $Res Function(CashLedgerEntry) then,
  ) = _$CashLedgerEntryCopyWithImpl<$Res, CashLedgerEntry>;
  @useResult
  $Res call({
    int id,
    CashMovementType type,
    int amount,
    CashReferenceType refType,
    int? refId,
    String? note,
    DateTime datetime,
    AppUser? user,
  });

  $AppUserCopyWith<$Res>? get user;
}

/// @nodoc
class _$CashLedgerEntryCopyWithImpl<$Res, $Val extends CashLedgerEntry>
    implements $CashLedgerEntryCopyWith<$Res> {
  _$CashLedgerEntryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CashLedgerEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? amount = null,
    Object? refType = null,
    Object? refId = freezed,
    Object? note = freezed,
    Object? datetime = null,
    Object? user = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as CashMovementType,
            amount: null == amount
                ? _value.amount
                : amount // ignore: cast_nullable_to_non_nullable
                      as int,
            refType: null == refType
                ? _value.refType
                : refType // ignore: cast_nullable_to_non_nullable
                      as CashReferenceType,
            refId: freezed == refId
                ? _value.refId
                : refId // ignore: cast_nullable_to_non_nullable
                      as int?,
            note: freezed == note
                ? _value.note
                : note // ignore: cast_nullable_to_non_nullable
                      as String?,
            datetime: null == datetime
                ? _value.datetime
                : datetime // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            user: freezed == user
                ? _value.user
                : user // ignore: cast_nullable_to_non_nullable
                      as AppUser?,
          )
          as $Val,
    );
  }

  /// Create a copy of CashLedgerEntry
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AppUserCopyWith<$Res>? get user {
    if (_value.user == null) {
      return null;
    }

    return $AppUserCopyWith<$Res>(_value.user!, (value) {
      return _then(_value.copyWith(user: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CashLedgerEntryImplCopyWith<$Res>
    implements $CashLedgerEntryCopyWith<$Res> {
  factory _$$CashLedgerEntryImplCopyWith(
    _$CashLedgerEntryImpl value,
    $Res Function(_$CashLedgerEntryImpl) then,
  ) = __$$CashLedgerEntryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    CashMovementType type,
    int amount,
    CashReferenceType refType,
    int? refId,
    String? note,
    DateTime datetime,
    AppUser? user,
  });

  @override
  $AppUserCopyWith<$Res>? get user;
}

/// @nodoc
class __$$CashLedgerEntryImplCopyWithImpl<$Res>
    extends _$CashLedgerEntryCopyWithImpl<$Res, _$CashLedgerEntryImpl>
    implements _$$CashLedgerEntryImplCopyWith<$Res> {
  __$$CashLedgerEntryImplCopyWithImpl(
    _$CashLedgerEntryImpl _value,
    $Res Function(_$CashLedgerEntryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CashLedgerEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? amount = null,
    Object? refType = null,
    Object? refId = freezed,
    Object? note = freezed,
    Object? datetime = null,
    Object? user = freezed,
  }) {
    return _then(
      _$CashLedgerEntryImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as CashMovementType,
        amount: null == amount
            ? _value.amount
            : amount // ignore: cast_nullable_to_non_nullable
                  as int,
        refType: null == refType
            ? _value.refType
            : refType // ignore: cast_nullable_to_non_nullable
                  as CashReferenceType,
        refId: freezed == refId
            ? _value.refId
            : refId // ignore: cast_nullable_to_non_nullable
                  as int?,
        note: freezed == note
            ? _value.note
            : note // ignore: cast_nullable_to_non_nullable
                  as String?,
        datetime: null == datetime
            ? _value.datetime
            : datetime // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        user: freezed == user
            ? _value.user
            : user // ignore: cast_nullable_to_non_nullable
                  as AppUser?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CashLedgerEntryImpl implements _CashLedgerEntry {
  const _$CashLedgerEntryImpl({
    required this.id,
    required this.type,
    required this.amount,
    required this.refType,
    this.refId,
    this.note,
    required this.datetime,
    this.user,
  });

  factory _$CashLedgerEntryImpl.fromJson(Map<String, dynamic> json) =>
      _$$CashLedgerEntryImplFromJson(json);

  @override
  final int id;
  @override
  final CashMovementType type;
  @override
  final int amount;
  @override
  final CashReferenceType refType;
  @override
  final int? refId;
  @override
  final String? note;
  @override
  final DateTime datetime;
  @override
  final AppUser? user;

  @override
  String toString() {
    return 'CashLedgerEntry(id: $id, type: $type, amount: $amount, refType: $refType, refId: $refId, note: $note, datetime: $datetime, user: $user)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CashLedgerEntryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.refType, refType) || other.refType == refType) &&
            (identical(other.refId, refId) || other.refId == refId) &&
            (identical(other.note, note) || other.note == note) &&
            (identical(other.datetime, datetime) ||
                other.datetime == datetime) &&
            (identical(other.user, user) || other.user == user));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    type,
    amount,
    refType,
    refId,
    note,
    datetime,
    user,
  );

  /// Create a copy of CashLedgerEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CashLedgerEntryImplCopyWith<_$CashLedgerEntryImpl> get copyWith =>
      __$$CashLedgerEntryImplCopyWithImpl<_$CashLedgerEntryImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CashLedgerEntryImplToJson(this);
  }
}

abstract class _CashLedgerEntry implements CashLedgerEntry {
  const factory _CashLedgerEntry({
    required final int id,
    required final CashMovementType type,
    required final int amount,
    required final CashReferenceType refType,
    final int? refId,
    final String? note,
    required final DateTime datetime,
    final AppUser? user,
  }) = _$CashLedgerEntryImpl;

  factory _CashLedgerEntry.fromJson(Map<String, dynamic> json) =
      _$CashLedgerEntryImpl.fromJson;

  @override
  int get id;
  @override
  CashMovementType get type;
  @override
  int get amount;
  @override
  CashReferenceType get refType;
  @override
  int? get refId;
  @override
  String? get note;
  @override
  DateTime get datetime;
  @override
  AppUser? get user;

  /// Create a copy of CashLedgerEntry
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CashLedgerEntryImplCopyWith<_$CashLedgerEntryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
