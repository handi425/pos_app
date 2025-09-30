import 'package:freezed_annotation/freezed_annotation.dart';

import 'app_user.dart';
import 'customer.dart';
import 'value_enums.dart';

part 'debt.freezed.dart';
part 'debt.g.dart';

@freezed
class Debt with _$Debt {
  const factory Debt({
    required int id,
    required int saleId,
    required Customer customer,
    required int principal,
    required int remaining,
    required DebtStatusView status,
    required DateTime createdAt,
  }) = _Debt;

  factory Debt.fromJson(Map<String, dynamic> json) => _$DebtFromJson(json);
}

@freezed
class DebtPayment with _$DebtPayment {
  const factory DebtPayment({
    required int id,
    required int debtId,
    required int amount,
    required DebtPaymentMethodView method,
    required DateTime datetime,
    AppUser? user,
    String? note,
  }) = _DebtPayment;

  factory DebtPayment.fromJson(Map<String, dynamic> json) =>
      _$DebtPaymentFromJson(json);
}
