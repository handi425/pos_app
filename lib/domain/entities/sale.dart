import 'package:freezed_annotation/freezed_annotation.dart';

import 'customer.dart';
import 'sale_item.dart';
import 'value_enums.dart';
import 'app_user.dart';

part 'sale.freezed.dart';
part 'sale.g.dart';

@freezed
class Sale with _$Sale {
  const factory Sale({
    required int id,
    required DateTime datetime,
    Customer? customer,
    AppUser? user,
    required int subtotal,
    required int discount,
    required int tax,
    required int total,
    required int paid,
    required int change,
    required PaymentMethod paymentMethod,
    required bool isCredit,
    @Default(<SaleItem>[]) List<SaleItem> items,
    String? notes,
  }) = _Sale;

  factory Sale.fromJson(Map<String, dynamic> json) => _$SaleFromJson(json);
}
