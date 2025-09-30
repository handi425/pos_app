import '../entities/debt.dart';
import '../entities/value_enums.dart';

abstract class DebtRepository {
  Stream<List<Debt>> watchOpenDebts();
  Future<void> recordPayment({
    required int debtId,
    required int amount,
    required DebtPaymentMethodView method,
    required int userId,
    String? note,
  });
  Future<List<DebtPayment>> paymentsForDebt(int debtId);
}

