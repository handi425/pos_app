// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sale_draft.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

CartItem _$CartItemFromJson(Map<String, dynamic> json) {
  return _CartItem.fromJson(json);
}

/// @nodoc
mixin _$CartItem {
  int get productId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  double get quantity => throw _privateConstructorUsedError;
  int get price => throw _privateConstructorUsedError;
  int get discount => throw _privateConstructorUsedError;

  /// Serializes this CartItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CartItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CartItemCopyWith<CartItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CartItemCopyWith<$Res> {
  factory $CartItemCopyWith(CartItem value, $Res Function(CartItem) then) =
      _$CartItemCopyWithImpl<$Res, CartItem>;
  @useResult
  $Res call({
    int productId,
    String name,
    double quantity,
    int price,
    int discount,
  });
}

/// @nodoc
class _$CartItemCopyWithImpl<$Res, $Val extends CartItem>
    implements $CartItemCopyWith<$Res> {
  _$CartItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CartItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? productId = null,
    Object? name = null,
    Object? quantity = null,
    Object? price = null,
    Object? discount = null,
  }) {
    return _then(
      _value.copyWith(
            productId: null == productId
                ? _value.productId
                : productId // ignore: cast_nullable_to_non_nullable
                      as int,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            quantity: null == quantity
                ? _value.quantity
                : quantity // ignore: cast_nullable_to_non_nullable
                      as double,
            price: null == price
                ? _value.price
                : price // ignore: cast_nullable_to_non_nullable
                      as int,
            discount: null == discount
                ? _value.discount
                : discount // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CartItemImplCopyWith<$Res>
    implements $CartItemCopyWith<$Res> {
  factory _$$CartItemImplCopyWith(
    _$CartItemImpl value,
    $Res Function(_$CartItemImpl) then,
  ) = __$$CartItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int productId,
    String name,
    double quantity,
    int price,
    int discount,
  });
}

/// @nodoc
class __$$CartItemImplCopyWithImpl<$Res>
    extends _$CartItemCopyWithImpl<$Res, _$CartItemImpl>
    implements _$$CartItemImplCopyWith<$Res> {
  __$$CartItemImplCopyWithImpl(
    _$CartItemImpl _value,
    $Res Function(_$CartItemImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CartItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? productId = null,
    Object? name = null,
    Object? quantity = null,
    Object? price = null,
    Object? discount = null,
  }) {
    return _then(
      _$CartItemImpl(
        productId: null == productId
            ? _value.productId
            : productId // ignore: cast_nullable_to_non_nullable
                  as int,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        quantity: null == quantity
            ? _value.quantity
            : quantity // ignore: cast_nullable_to_non_nullable
                  as double,
        price: null == price
            ? _value.price
            : price // ignore: cast_nullable_to_non_nullable
                  as int,
        discount: null == discount
            ? _value.discount
            : discount // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CartItemImpl extends _CartItem {
  const _$CartItemImpl({
    required this.productId,
    required this.name,
    required this.quantity,
    required this.price,
    this.discount = 0,
  }) : super._();

  factory _$CartItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$CartItemImplFromJson(json);

  @override
  final int productId;
  @override
  final String name;
  @override
  final double quantity;
  @override
  final int price;
  @override
  @JsonKey()
  final int discount;

  @override
  String toString() {
    return 'CartItem(productId: $productId, name: $name, quantity: $quantity, price: $price, discount: $discount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CartItemImpl &&
            (identical(other.productId, productId) ||
                other.productId == productId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.discount, discount) ||
                other.discount == discount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, productId, name, quantity, price, discount);

  /// Create a copy of CartItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CartItemImplCopyWith<_$CartItemImpl> get copyWith =>
      __$$CartItemImplCopyWithImpl<_$CartItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CartItemImplToJson(this);
  }
}

abstract class _CartItem extends CartItem {
  const factory _CartItem({
    required final int productId,
    required final String name,
    required final double quantity,
    required final int price,
    final int discount,
  }) = _$CartItemImpl;
  const _CartItem._() : super._();

  factory _CartItem.fromJson(Map<String, dynamic> json) =
      _$CartItemImpl.fromJson;

  @override
  int get productId;
  @override
  String get name;
  @override
  double get quantity;
  @override
  int get price;
  @override
  int get discount;

  /// Create a copy of CartItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CartItemImplCopyWith<_$CartItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$SaleDraft {
  Customer? get customer => throw _privateConstructorUsedError;
  List<CartItem> get items => throw _privateConstructorUsedError;
  int get transactionDiscount => throw _privateConstructorUsedError;
  int get tax => throw _privateConstructorUsedError;
  int get paid => throw _privateConstructorUsedError;
  PaymentMethod get paymentMethod => throw _privateConstructorUsedError;
  bool get asDebt => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;

  /// Create a copy of SaleDraft
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SaleDraftCopyWith<SaleDraft> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SaleDraftCopyWith<$Res> {
  factory $SaleDraftCopyWith(SaleDraft value, $Res Function(SaleDraft) then) =
      _$SaleDraftCopyWithImpl<$Res, SaleDraft>;
  @useResult
  $Res call({
    Customer? customer,
    List<CartItem> items,
    int transactionDiscount,
    int tax,
    int paid,
    PaymentMethod paymentMethod,
    bool asDebt,
    String? notes,
  });

  $CustomerCopyWith<$Res>? get customer;
}

/// @nodoc
class _$SaleDraftCopyWithImpl<$Res, $Val extends SaleDraft>
    implements $SaleDraftCopyWith<$Res> {
  _$SaleDraftCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SaleDraft
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? customer = freezed,
    Object? items = null,
    Object? transactionDiscount = null,
    Object? tax = null,
    Object? paid = null,
    Object? paymentMethod = null,
    Object? asDebt = null,
    Object? notes = freezed,
  }) {
    return _then(
      _value.copyWith(
            customer: freezed == customer
                ? _value.customer
                : customer // ignore: cast_nullable_to_non_nullable
                      as Customer?,
            items: null == items
                ? _value.items
                : items // ignore: cast_nullable_to_non_nullable
                      as List<CartItem>,
            transactionDiscount: null == transactionDiscount
                ? _value.transactionDiscount
                : transactionDiscount // ignore: cast_nullable_to_non_nullable
                      as int,
            tax: null == tax
                ? _value.tax
                : tax // ignore: cast_nullable_to_non_nullable
                      as int,
            paid: null == paid
                ? _value.paid
                : paid // ignore: cast_nullable_to_non_nullable
                      as int,
            paymentMethod: null == paymentMethod
                ? _value.paymentMethod
                : paymentMethod // ignore: cast_nullable_to_non_nullable
                      as PaymentMethod,
            asDebt: null == asDebt
                ? _value.asDebt
                : asDebt // ignore: cast_nullable_to_non_nullable
                      as bool,
            notes: freezed == notes
                ? _value.notes
                : notes // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }

  /// Create a copy of SaleDraft
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
}

/// @nodoc
abstract class _$$SaleDraftImplCopyWith<$Res>
    implements $SaleDraftCopyWith<$Res> {
  factory _$$SaleDraftImplCopyWith(
    _$SaleDraftImpl value,
    $Res Function(_$SaleDraftImpl) then,
  ) = __$$SaleDraftImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    Customer? customer,
    List<CartItem> items,
    int transactionDiscount,
    int tax,
    int paid,
    PaymentMethod paymentMethod,
    bool asDebt,
    String? notes,
  });

  @override
  $CustomerCopyWith<$Res>? get customer;
}

/// @nodoc
class __$$SaleDraftImplCopyWithImpl<$Res>
    extends _$SaleDraftCopyWithImpl<$Res, _$SaleDraftImpl>
    implements _$$SaleDraftImplCopyWith<$Res> {
  __$$SaleDraftImplCopyWithImpl(
    _$SaleDraftImpl _value,
    $Res Function(_$SaleDraftImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SaleDraft
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? customer = freezed,
    Object? items = null,
    Object? transactionDiscount = null,
    Object? tax = null,
    Object? paid = null,
    Object? paymentMethod = null,
    Object? asDebt = null,
    Object? notes = freezed,
  }) {
    return _then(
      _$SaleDraftImpl(
        customer: freezed == customer
            ? _value.customer
            : customer // ignore: cast_nullable_to_non_nullable
                  as Customer?,
        items: null == items
            ? _value._items
            : items // ignore: cast_nullable_to_non_nullable
                  as List<CartItem>,
        transactionDiscount: null == transactionDiscount
            ? _value.transactionDiscount
            : transactionDiscount // ignore: cast_nullable_to_non_nullable
                  as int,
        tax: null == tax
            ? _value.tax
            : tax // ignore: cast_nullable_to_non_nullable
                  as int,
        paid: null == paid
            ? _value.paid
            : paid // ignore: cast_nullable_to_non_nullable
                  as int,
        paymentMethod: null == paymentMethod
            ? _value.paymentMethod
            : paymentMethod // ignore: cast_nullable_to_non_nullable
                  as PaymentMethod,
        asDebt: null == asDebt
            ? _value.asDebt
            : asDebt // ignore: cast_nullable_to_non_nullable
                  as bool,
        notes: freezed == notes
            ? _value.notes
            : notes // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$SaleDraftImpl extends _SaleDraft {
  const _$SaleDraftImpl({
    this.customer,
    required final List<CartItem> items,
    this.transactionDiscount = 0,
    this.tax = 0,
    this.paid = 0,
    this.paymentMethod = PaymentMethod.cash,
    this.asDebt = false,
    this.notes,
  }) : _items = items,
       super._();

  @override
  final Customer? customer;
  final List<CartItem> _items;
  @override
  List<CartItem> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  @JsonKey()
  final int transactionDiscount;
  @override
  @JsonKey()
  final int tax;
  @override
  @JsonKey()
  final int paid;
  @override
  @JsonKey()
  final PaymentMethod paymentMethod;
  @override
  @JsonKey()
  final bool asDebt;
  @override
  final String? notes;

  @override
  String toString() {
    return 'SaleDraft(customer: $customer, items: $items, transactionDiscount: $transactionDiscount, tax: $tax, paid: $paid, paymentMethod: $paymentMethod, asDebt: $asDebt, notes: $notes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SaleDraftImpl &&
            (identical(other.customer, customer) ||
                other.customer == customer) &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.transactionDiscount, transactionDiscount) ||
                other.transactionDiscount == transactionDiscount) &&
            (identical(other.tax, tax) || other.tax == tax) &&
            (identical(other.paid, paid) || other.paid == paid) &&
            (identical(other.paymentMethod, paymentMethod) ||
                other.paymentMethod == paymentMethod) &&
            (identical(other.asDebt, asDebt) || other.asDebt == asDebt) &&
            (identical(other.notes, notes) || other.notes == notes));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    customer,
    const DeepCollectionEquality().hash(_items),
    transactionDiscount,
    tax,
    paid,
    paymentMethod,
    asDebt,
    notes,
  );

  /// Create a copy of SaleDraft
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SaleDraftImplCopyWith<_$SaleDraftImpl> get copyWith =>
      __$$SaleDraftImplCopyWithImpl<_$SaleDraftImpl>(this, _$identity);
}

abstract class _SaleDraft extends SaleDraft {
  const factory _SaleDraft({
    final Customer? customer,
    required final List<CartItem> items,
    final int transactionDiscount,
    final int tax,
    final int paid,
    final PaymentMethod paymentMethod,
    final bool asDebt,
    final String? notes,
  }) = _$SaleDraftImpl;
  const _SaleDraft._() : super._();

  @override
  Customer? get customer;
  @override
  List<CartItem> get items;
  @override
  int get transactionDiscount;
  @override
  int get tax;
  @override
  int get paid;
  @override
  PaymentMethod get paymentMethod;
  @override
  bool get asDebt;
  @override
  String? get notes;

  /// Create a copy of SaleDraft
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SaleDraftImplCopyWith<_$SaleDraftImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
