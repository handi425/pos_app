// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'debt.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Debt _$DebtFromJson(Map<String, dynamic> json) {
  return _Debt.fromJson(json);
}

/// @nodoc
mixin _$Debt {
  int get id => throw _privateConstructorUsedError;
  int get saleId => throw _privateConstructorUsedError;
  Customer get customer => throw _privateConstructorUsedError;
  int get principal => throw _privateConstructorUsedError;
  int get remaining => throw _privateConstructorUsedError;
  DebtStatusView get status => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Serializes this Debt to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Debt
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DebtCopyWith<Debt> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DebtCopyWith<$Res> {
  factory $DebtCopyWith(Debt value, $Res Function(Debt) then) =
      _$DebtCopyWithImpl<$Res, Debt>;
  @useResult
  $Res call({
    int id,
    int saleId,
    Customer customer,
    int principal,
    int remaining,
    DebtStatusView status,
    DateTime createdAt,
  });

  $CustomerCopyWith<$Res> get customer;
}

/// @nodoc
class _$DebtCopyWithImpl<$Res, $Val extends Debt>
    implements $DebtCopyWith<$Res> {
  _$DebtCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Debt
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? saleId = null,
    Object? customer = null,
    Object? principal = null,
    Object? remaining = null,
    Object? status = null,
    Object? createdAt = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            saleId: null == saleId
                ? _value.saleId
                : saleId // ignore: cast_nullable_to_non_nullable
                      as int,
            customer: null == customer
                ? _value.customer
                : customer // ignore: cast_nullable_to_non_nullable
                      as Customer,
            principal: null == principal
                ? _value.principal
                : principal // ignore: cast_nullable_to_non_nullable
                      as int,
            remaining: null == remaining
                ? _value.remaining
                : remaining // ignore: cast_nullable_to_non_nullable
                      as int,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as DebtStatusView,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }

  /// Create a copy of Debt
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CustomerCopyWith<$Res> get customer {
    return $CustomerCopyWith<$Res>(_value.customer, (value) {
      return _then(_value.copyWith(customer: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$DebtImplCopyWith<$Res> implements $DebtCopyWith<$Res> {
  factory _$$DebtImplCopyWith(
    _$DebtImpl value,
    $Res Function(_$DebtImpl) then,
  ) = __$$DebtImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    int saleId,
    Customer customer,
    int principal,
    int remaining,
    DebtStatusView status,
    DateTime createdAt,
  });

  @override
  $CustomerCopyWith<$Res> get customer;
}

/// @nodoc
class __$$DebtImplCopyWithImpl<$Res>
    extends _$DebtCopyWithImpl<$Res, _$DebtImpl>
    implements _$$DebtImplCopyWith<$Res> {
  __$$DebtImplCopyWithImpl(_$DebtImpl _value, $Res Function(_$DebtImpl) _then)
    : super(_value, _then);

  /// Create a copy of Debt
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? saleId = null,
    Object? customer = null,
    Object? principal = null,
    Object? remaining = null,
    Object? status = null,
    Object? createdAt = null,
  }) {
    return _then(
      _$DebtImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        saleId: null == saleId
            ? _value.saleId
            : saleId // ignore: cast_nullable_to_non_nullable
                  as int,
        customer: null == customer
            ? _value.customer
            : customer // ignore: cast_nullable_to_non_nullable
                  as Customer,
        principal: null == principal
            ? _value.principal
            : principal // ignore: cast_nullable_to_non_nullable
                  as int,
        remaining: null == remaining
            ? _value.remaining
            : remaining // ignore: cast_nullable_to_non_nullable
                  as int,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as DebtStatusView,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DebtImpl implements _Debt {
  const _$DebtImpl({
    required this.id,
    required this.saleId,
    required this.customer,
    required this.principal,
    required this.remaining,
    required this.status,
    required this.createdAt,
  });

  factory _$DebtImpl.fromJson(Map<String, dynamic> json) =>
      _$$DebtImplFromJson(json);

  @override
  final int id;
  @override
  final int saleId;
  @override
  final Customer customer;
  @override
  final int principal;
  @override
  final int remaining;
  @override
  final DebtStatusView status;
  @override
  final DateTime createdAt;

  @override
  String toString() {
    return 'Debt(id: $id, saleId: $saleId, customer: $customer, principal: $principal, remaining: $remaining, status: $status, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DebtImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.saleId, saleId) || other.saleId == saleId) &&
            (identical(other.customer, customer) ||
                other.customer == customer) &&
            (identical(other.principal, principal) ||
                other.principal == principal) &&
            (identical(other.remaining, remaining) ||
                other.remaining == remaining) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    saleId,
    customer,
    principal,
    remaining,
    status,
    createdAt,
  );

  /// Create a copy of Debt
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DebtImplCopyWith<_$DebtImpl> get copyWith =>
      __$$DebtImplCopyWithImpl<_$DebtImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DebtImplToJson(this);
  }
}

abstract class _Debt implements Debt {
  const factory _Debt({
    required final int id,
    required final int saleId,
    required final Customer customer,
    required final int principal,
    required final int remaining,
    required final DebtStatusView status,
    required final DateTime createdAt,
  }) = _$DebtImpl;

  factory _Debt.fromJson(Map<String, dynamic> json) = _$DebtImpl.fromJson;

  @override
  int get id;
  @override
  int get saleId;
  @override
  Customer get customer;
  @override
  int get principal;
  @override
  int get remaining;
  @override
  DebtStatusView get status;
  @override
  DateTime get createdAt;

  /// Create a copy of Debt
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DebtImplCopyWith<_$DebtImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DebtPayment _$DebtPaymentFromJson(Map<String, dynamic> json) {
  return _DebtPayment.fromJson(json);
}

/// @nodoc
mixin _$DebtPayment {
  int get id => throw _privateConstructorUsedError;
  int get debtId => throw _privateConstructorUsedError;
  int get amount => throw _privateConstructorUsedError;
  DebtPaymentMethodView get method => throw _privateConstructorUsedError;
  DateTime get datetime => throw _privateConstructorUsedError;
  AppUser? get user => throw _privateConstructorUsedError;
  String? get note => throw _privateConstructorUsedError;

  /// Serializes this DebtPayment to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DebtPayment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DebtPaymentCopyWith<DebtPayment> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DebtPaymentCopyWith<$Res> {
  factory $DebtPaymentCopyWith(
    DebtPayment value,
    $Res Function(DebtPayment) then,
  ) = _$DebtPaymentCopyWithImpl<$Res, DebtPayment>;
  @useResult
  $Res call({
    int id,
    int debtId,
    int amount,
    DebtPaymentMethodView method,
    DateTime datetime,
    AppUser? user,
    String? note,
  });

  $AppUserCopyWith<$Res>? get user;
}

/// @nodoc
class _$DebtPaymentCopyWithImpl<$Res, $Val extends DebtPayment>
    implements $DebtPaymentCopyWith<$Res> {
  _$DebtPaymentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DebtPayment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? debtId = null,
    Object? amount = null,
    Object? method = null,
    Object? datetime = null,
    Object? user = freezed,
    Object? note = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            debtId: null == debtId
                ? _value.debtId
                : debtId // ignore: cast_nullable_to_non_nullable
                      as int,
            amount: null == amount
                ? _value.amount
                : amount // ignore: cast_nullable_to_non_nullable
                      as int,
            method: null == method
                ? _value.method
                : method // ignore: cast_nullable_to_non_nullable
                      as DebtPaymentMethodView,
            datetime: null == datetime
                ? _value.datetime
                : datetime // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            user: freezed == user
                ? _value.user
                : user // ignore: cast_nullable_to_non_nullable
                      as AppUser?,
            note: freezed == note
                ? _value.note
                : note // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }

  /// Create a copy of DebtPayment
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
abstract class _$$DebtPaymentImplCopyWith<$Res>
    implements $DebtPaymentCopyWith<$Res> {
  factory _$$DebtPaymentImplCopyWith(
    _$DebtPaymentImpl value,
    $Res Function(_$DebtPaymentImpl) then,
  ) = __$$DebtPaymentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    int debtId,
    int amount,
    DebtPaymentMethodView method,
    DateTime datetime,
    AppUser? user,
    String? note,
  });

  @override
  $AppUserCopyWith<$Res>? get user;
}

/// @nodoc
class __$$DebtPaymentImplCopyWithImpl<$Res>
    extends _$DebtPaymentCopyWithImpl<$Res, _$DebtPaymentImpl>
    implements _$$DebtPaymentImplCopyWith<$Res> {
  __$$DebtPaymentImplCopyWithImpl(
    _$DebtPaymentImpl _value,
    $Res Function(_$DebtPaymentImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DebtPayment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? debtId = null,
    Object? amount = null,
    Object? method = null,
    Object? datetime = null,
    Object? user = freezed,
    Object? note = freezed,
  }) {
    return _then(
      _$DebtPaymentImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        debtId: null == debtId
            ? _value.debtId
            : debtId // ignore: cast_nullable_to_non_nullable
                  as int,
        amount: null == amount
            ? _value.amount
            : amount // ignore: cast_nullable_to_non_nullable
                  as int,
        method: null == method
            ? _value.method
            : method // ignore: cast_nullable_to_non_nullable
                  as DebtPaymentMethodView,
        datetime: null == datetime
            ? _value.datetime
            : datetime // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        user: freezed == user
            ? _value.user
            : user // ignore: cast_nullable_to_non_nullable
                  as AppUser?,
        note: freezed == note
            ? _value.note
            : note // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DebtPaymentImpl implements _DebtPayment {
  const _$DebtPaymentImpl({
    required this.id,
    required this.debtId,
    required this.amount,
    required this.method,
    required this.datetime,
    this.user,
    this.note,
  });

  factory _$DebtPaymentImpl.fromJson(Map<String, dynamic> json) =>
      _$$DebtPaymentImplFromJson(json);

  @override
  final int id;
  @override
  final int debtId;
  @override
  final int amount;
  @override
  final DebtPaymentMethodView method;
  @override
  final DateTime datetime;
  @override
  final AppUser? user;
  @override
  final String? note;

  @override
  String toString() {
    return 'DebtPayment(id: $id, debtId: $debtId, amount: $amount, method: $method, datetime: $datetime, user: $user, note: $note)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DebtPaymentImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.debtId, debtId) || other.debtId == debtId) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.method, method) || other.method == method) &&
            (identical(other.datetime, datetime) ||
                other.datetime == datetime) &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.note, note) || other.note == note));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    debtId,
    amount,
    method,
    datetime,
    user,
    note,
  );

  /// Create a copy of DebtPayment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DebtPaymentImplCopyWith<_$DebtPaymentImpl> get copyWith =>
      __$$DebtPaymentImplCopyWithImpl<_$DebtPaymentImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DebtPaymentImplToJson(this);
  }
}

abstract class _DebtPayment implements DebtPayment {
  const factory _DebtPayment({
    required final int id,
    required final int debtId,
    required final int amount,
    required final DebtPaymentMethodView method,
    required final DateTime datetime,
    final AppUser? user,
    final String? note,
  }) = _$DebtPaymentImpl;

  factory _DebtPayment.fromJson(Map<String, dynamic> json) =
      _$DebtPaymentImpl.fromJson;

  @override
  int get id;
  @override
  int get debtId;
  @override
  int get amount;
  @override
  DebtPaymentMethodView get method;
  @override
  DateTime get datetime;
  @override
  AppUser? get user;
  @override
  String? get note;

  /// Create a copy of DebtPayment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DebtPaymentImplCopyWith<_$DebtPaymentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
