import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/debt.dart';
import '../../domain/entities/value_enums.dart';
import '../../domain/repositories/debt_repository.dart';
import '../db/database_provider.dart';
import '../db/pos_database.dart';
import 'mappers.dart';

class DebtRepositoryImpl implements DebtRepository {
  DebtRepositoryImpl(this._db);

  final PosDatabase _db;

  @override
  Stream<List<Debt>> watchOpenDebts() {
    return _db.debtsDao.watchOpenDebts().asyncMap((rows) async {
      final debts = <Debt>[];
      for (final row in rows) {
        final customer = mapCustomer(row.customer);
        debts.add(mapDebt(row.debt, customer));
      }
      return debts;
    });
  }

  @override
  Future<void> recordPayment({
    required int debtId,
    required int amount,
    required DebtPaymentMethodView method,
    required int userId,
    String? note,
  }) {
    return _db.debtsDao.recordPayment(
      debtId: debtId,
      amount: amount,
      method: mapDebtPaymentMethodToDb(method),
      userId: userId,
      note: note,
    );
  }

  @override
  Future<List<DebtPayment>> paymentsForDebt(int debtId) async {
    final rows = await _db.debtsDao.paymentsForDebt(debtId);
    final payments = <DebtPayment>[];
    for (final row in rows) {
      final user = await _db.usersDao.getById(row.userId);
      payments.add(mapDebtPayment(row, user: user));
    }
    return payments;
  }
}

final debtRepositoryProvider = Provider<DebtRepository>((ref) {
  final db = ref.watch(posDatabaseProvider);
  return DebtRepositoryImpl(db);
});
