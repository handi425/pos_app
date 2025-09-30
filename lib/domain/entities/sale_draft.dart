import 'package:freezed_annotation/freezed_annotation.dart';

import 'customer.dart';
import 'value_enums.dart';

part 'sale_draft.freezed.dart';
part 'sale_draft.g.dart';

@freezed
class CartItem with _$CartItem {
  const factory CartItem({
    required int productId,
    required String name,
    required double quantity,
    required int price,
    @Default(0) int discount,
  }) = _CartItem;

  factory CartItem.fromJson(Map<String, dynamic> json) =>
      _$CartItemFromJson(json);

  const CartItem._();

  int get lineBase => (price * quantity).round();
  int get lineDiscount => discount.clamp(0, lineBase);
  int get lineTotal => (lineBase - lineDiscount).clamp(0, lineBase);
}

@freezed
class SaleDraft with _$SaleDraft {
  const factory SaleDraft({
    Customer? customer,
    required List<CartItem> items,
    @Default(0) int transactionDiscount,
    @Default(0) int tax,
    @Default(0) int paid,
    @Default(PaymentMethod.cash) PaymentMethod paymentMethod,
    @Default(false) bool asDebt,
    String? notes,
  }) = _SaleDraft;

  const SaleDraft._();

  int get itemsGross => items.fold(0, (sum, item) => sum + item.lineBase);
  int get itemDiscountTotal => items.fold(0, (sum, item) => sum + item.lineDiscount);
  int get subtotal => itemsGross - itemDiscountTotal;
  int get discountTotal => itemDiscountTotal + transactionDiscount;
  int get grandTotal => (subtotal - transactionDiscount + tax).clamp(0, subtotal + tax);
  int get change => (paid - grandTotal).clamp(0, paid);
}

