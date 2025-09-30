// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sale.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Sale _$SaleFromJson(Map<String, dynamic> json) {
  return _Sale.fromJson(json);
}

/// @nodoc
mixin _$Sale {
  int get id => throw _privateConstructorUsedError;
  DateTime get datetime => throw _privateConstructorUsedError;
  Customer? get customer => throw _privateConstructorUsedError;
  AppUser? get user => throw _privateConstructorUsedError;
  int get subtotal => throw _privateConstructorUsedError;
  int get discount => throw _privateConstructorUsedError;
  int get tax => throw _privateConstructorUsedError;
  int get total => throw _privateConstructorUsedError;
  int get paid => throw _privateConstructorUsedError;
  int get change => throw _privateConstructorUsedError;
  PaymentMethod get paymentMethod => throw _privateConstructorUsedError;
  bool get isCredit => throw _privateConstructorUsedError;
  List<SaleItem> get items => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;

  /// Serializes this Sale to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Sale
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SaleCopyWith<Sale> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SaleCopyWith<$Res> {
  factory $SaleCopyWith(Sale value, $Res Function(Sale) then) =
      _$SaleCopyWithImpl<$Res, Sale>;
  @useResult
  $Res call({
    int id,
    DateTime datetime,
    Customer? customer,
    AppUser? user,
    int subtotal,
    int discount,
    int tax,
    int total,
    int paid,
    int change,
    PaymentMethod paymentMethod,
    bool isCredit,
    List<SaleItem> items,
    String? notes,
  });

  $CustomerCopyWith<$Res>? get customer;
  $AppUserCopyWith<$Res>? get user;
}

/// @nodoc
class _$SaleCopyWithImpl<$Res, $Val extends Sale>
    implements $SaleCopyWith<$Res> {
  _$SaleCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Sale
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? datetime = null,
    Object? customer = freezed,
    Object? user = freezed,
    Object? subtotal = null,
    Object? discount = null,
    Object? tax = null,
    Object? total = null,
    Object? paid = null,
    Object? change = null,
    Object? paymentMethod = null,
    Object? isCredit = null,
    Object? items = null,
    Object? notes = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            datetime: null == datetime
                ? _value.datetime
                : datetime // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            customer: freezed == customer
                ? _value.customer
                : customer // ignore: cast_nullable_to_non_nullable
                      as Customer?,
            user: freezed == user
                ? _value.user
                : user // ignore: cast_nullable_to_non_nullable
                      as AppUser?,
            subtotal: null == subtotal
                ? _value.subtotal
                : subtotal // ignore: cast_nullable_to_non_nullable
                      as int,
            discount: null == discount
                ? _value.discount
                : discount // ignore: cast_nullable_to_non_nullable
                      as int,
            tax: null == tax
                ? _value.tax
                : tax // ignore: cast_nullable_to_non_nullable
                      as int,
            total: null == total
                ? _value.total
                : total // ignore: cast_nullable_to_non_nullable
                      as int,
            paid: null == paid
                ? _value.paid
                : paid // ignore: cast_nullable_to_non_nullable
                      as int,
            change: null == change
                ? _value.change
                : change // ignore: cast_nullable_to_non_nullable
                      as int,
            paymentMethod: null == paymentMethod
                ? _value.paymentMethod
                : paymentMethod // ignore: cast_nullable_to_non_nullable
                      as PaymentMethod,
            isCredit: null == isCredit
                ? _value.isCredit
                : isCredit // ignore: cast_nullable_to_non_nullable
                      as bool,
            items: null == items
                ? _value.items
                : items // ignore: cast_nullable_to_non_nullable
                      as List<SaleItem>,
            notes: freezed == notes
                ? _value.notes
                : notes // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }

  /// Create a copy of Sale
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CustomerCopyWith<$Res>? get customer {
    if (_value.customer == null) {
      return null;
    }

    return $CustomerCopyWith<$Res>(_value.customer!, (value) {
      return _then(_value.copyWith(customer: value) as $Val);
    });
  }

  /// Create a copy of Sale
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
abstract class _$$SaleImplCopyWith<$Res> implements $SaleCopyWith<$Res> {
  factory _$$SaleImplCopyWith(
    _$SaleImpl value,
    $Res Function(_$SaleImpl) then,
  ) = __$$SaleImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    DateTime datetime,
    Customer? customer,
    AppUser? user,
    int subtotal,
    int discount,
    int tax,
    int total,
    int paid,
    int change,
    PaymentMethod paymentMethod,
    bool isCredit,
    List<SaleItem> items,
    String? notes,
  });

  @override
  $CustomerCopyWith<$Res>? get customer;
  @override
  $AppUserCopyWith<$Res>? get user;
}

/// @nodoc
class __$$SaleImplCopyWithImpl<$Res>
    extends _$SaleCopyWithImpl<$Res, _$SaleImpl>
    implements _$$SaleImplCopyWith<$Res> {
  __$$SaleImplCopyWithImpl(_$SaleImpl _value, $Res Function(_$SaleImpl) _then)
    : super(_value, _then);

  /// Create a copy of Sale
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? datetime = null,
    Object? customer = freezed,
    Object? user = freezed,
    Object? subtotal = null,
    Object? discount = null,
    Object? tax = null,
    Object? total = null,
    Object? paid = null,
    Object? change = null,
    Object? paymentMethod = null,
    Object? isCredit = null,
    Object? items = null,
    Object? notes = freezed,
  }) {
    return _then(
      _$SaleImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        datetime: null == datetime
            ? _value.datetime
            : datetime // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        customer: freezed == customer
            ? _value.customer
            : customer // ignore: cast_nullable_to_non_nullable
                  as Customer?,
        user: freezed == user
            ? _value.user
            : user // ignore: cast_nullable_to_non_nullable
                  as AppUser?,
        subtotal: null == subtotal
            ? _value.subtotal
            : subtotal // ignore: cast_nullable_to_non_nullable
                  as int,
        discount: null == discount
            ? _value.discount
            : discount // ignore: cast_nullable_to_non_nullable
                  as int,
        tax: null == tax
            ? _value.tax
            : tax // ignore: cast_nullable_to_non_nullable
                  as int,
        total: null == total
            ? _value.total
            : total // ignore: cast_nullable_to_non_nullable
                  as int,
        paid: null == paid
            ? _value.paid
            : paid // ignore: cast_nullable_to_non_nullable
                  as int,
        change: null == change
            ? _value.change
            : change // ignore: cast_nullable_to_non_nullable
                  as int,
        paymentMethod: null == paymentMethod
            ? _value.paymentMethod
            : paymentMethod // ignore: cast_nullable_to_non_nullable
                  as PaymentMethod,
        isCredit: null == isCredit
            ? _value.isCredit
            : isCredit // ignore: cast_nullable_to_non_nullable
                  as bool,
        items: null == items
            ? _value._items
            : items // ignore: cast_nullable_to_non_nullable
                  as List<SaleItem>,
        notes: freezed == notes
            ? _value.notes
            : notes // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SaleImpl implements _Sale {
  const _$SaleImpl({
    required this.id,
    required this.datetime,
    this.customer,
    this.user,
    required this.subtotal,
    required this.discount,
    required this.tax,
    required this.total,
    required this.paid,
    required this.change,
    required this.paymentMethod,
    required this.isCredit,
    final List<SaleItem> items = const <SaleItem>[],
    this.notes,
  }) : _items = items;

  factory _$SaleImpl.fromJson(Map<String, dynamic> json) =>
      _$$SaleImplFromJson(json);

  @override
  final int id;
  @override
  final DateTime datetime;
  @override
  final Customer? customer;
  @override
  final AppUser? user;
  @override
  final int subtotal;
  @override
  final int discount;
  @override
  final int tax;
  @override
  final int total;
  @override
  final int paid;
  @override
  final int change;
  @override
  final PaymentMethod paymentMethod;
  @override
  final bool isCredit;
  final List<SaleItem> _items;
  @override
  @JsonKey()
  List<SaleItem> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  final String? notes;

  @override
  String toString() {
    return 'Sale(id: $id, datetime: $datetime, customer: $customer, user: $user, subtotal: $subtotal, discount: $discount, tax: $tax, total: $total, paid: $paid, change: $change, paymentMethod: $paymentMethod, isCredit: $isCredit, items: $items, notes: $notes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SaleImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.datetime, datetime) ||
                other.datetime == datetime) &&
            (identical(other.customer, customer) ||
                other.customer == customer) &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.subtotal, subtotal) ||
                other.subtotal == subtotal) &&
            (identical(other.discount, discount) ||
                other.discount == discount) &&
            (identical(other.tax, tax) || other.tax == tax) &&
            (identical(other.total, total) || other.total == total) &&
            (identical(other.paid, paid) || other.paid == paid) &&
            (identical(other.change, change) || other.change == change) &&
            (identical(other.paymentMethod, paymentMethod) ||
                other.paymentMethod == paymentMethod) &&
            (identical(other.isCredit, isCredit) ||
                other.isCredit == isCredit) &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.notes, notes) || other.notes == notes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    datetime,
    customer,
    user,
    subtotal,
    discount,
    tax,
    total,
    paid,
    change,
    paymentMethod,
    isCredit,
    const DeepCollectionEquality().hash(_items),
    notes,
  );

  /// Create a copy of Sale
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SaleImplCopyWith<_$SaleImpl> get copyWith =>
      __$$SaleImplCopyWithImpl<_$SaleImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SaleImplToJson(this);
  }
}

abstract class _Sale implements Sale {
  const factory _Sale({
    required final int id,
    required final DateTime datetime,
    final Customer? customer,
    final AppUser? user,
    required final int subtotal,
    required final int discount,
    required final int tax,
    required final int total,
    required final int paid,
    required final int change,
    required final PaymentMethod paymentMethod,
    required final bool isCredit,
    final List<SaleItem> items,
    final String? notes,
  }) = _$SaleImpl;

  factory _Sale.fromJson(Map<String, dynamic> json) = _$SaleImpl.fromJson;

  @override
  int get id;
  @override
  DateTime get datetime;
  @override
  Customer? get customer;
  @override
  AppUser? get user;
  @override
  int get subtotal;
  @override
  int get discount;
  @override
  int get tax;
  @override
  int get total;
  @override
  int get paid;
  @override
  int get change;
  @override
  PaymentMethod get paymentMethod;
  @override
  bool get isCredit;
  @override
  List<SaleItem> get items;
  @override
  String? get notes;

  /// Create a copy of Sale
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SaleImplCopyWith<_$SaleImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
