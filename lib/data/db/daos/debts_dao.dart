import 'package:drift/drift.dart';

import '../pos_database.dart';
import '../tables.dart';

part 'debts_dao.g.dart';

class DebtWithCustomer {
  DebtWithCustomer({
    required this.debt,
    required this.customer,
  });

  final DebtsTableData debt;
  final CustomersTableData customer;
}

@DriftAccessor(tables: [DebtsTable, DebtPaymentsTable, CashLedgerTable, CustomersTable])
class DebtsDao extends DatabaseAccessor<PosDatabase> with _$DebtsDaoMixin {
  DebtsDao(PosDatabase db) : super(db);

  Stream<List<DebtWithCustomer>> watchOpenDebts() {
    final query = select(debtsTable).join([
      innerJoin(customersTable, customersTable.id.equalsExp(debtsTable.customerId)),
    ])
      ..where(debtsTable.status.equalsValue(DebtStatus.open))
      ..orderBy([
        OrderingTerm(expression: debtsTable.createdAt, mode: OrderingMode.asc),
      ]);

    return query.watch().map((rows) {
      return rows
          .map(
            (row) => DebtWithCustomer(
              debt: row.readTable(debtsTable),
              customer: row.readTable(customersTable),
            ),
          )
          .toList();
    });
  }

  Future<void> recordPayment({
    required int debtId,
    required int amount,
    required DebtPaymentMethod method,
    required int userId,
    String? note,
  }) async {
    await transaction(() async {
      final debt = await (select(debtsTable)
            ..where((tbl) => tbl.id.equals(debtId)))
          .getSingle();

      if (amount <= 0) {
        throw ArgumentError('Nominal pembayaran harus lebih besar dari 0');
      }

      if (amount > debt.remaining) {
        throw ArgumentError('Nominal pembayaran melebihi sisa kasbon');
      }

      final newRemaining = debt.remaining - amount;

      await into(debtPaymentsTable).insert(
        DebtPaymentsTableCompanion.insert(
          debtId: debtId,
          amount: amount,
          method: method,
          datetime: DateTime.now(),
          userId: userId,
          note: Value(note),
        ),
      );

      await (update(debtsTable)..where((tbl) => tbl.id.equals(debtId))).write(
        DebtsTableCompanion(
          remaining: Value(newRemaining),
          status: Value(newRemaining == 0 ? DebtStatus.closed : DebtStatus.open),
        ),
      );

      await into(cashLedgerTable).insert(
        CashLedgerTableCompanion.insert(
          type: CashLedgerType.inFlow,
          amount: amount,
          refType: CashLedgerRefType.debtPayment,
          refId: Value(debtId),
          note: Value(note ?? 'Pembayaran kasbon'),
          datetime: DateTime.now(),
          userId: userId,
        ),
      );
    });
  }

  Future<List<DebtPaymentsTableData>> paymentsForDebt(int debtId) {
    return (select(debtPaymentsTable)
          ..where((tbl) => tbl.debtId.equals(debtId))
          ..orderBy([(tbl) => OrderingTerm(expression: tbl.datetime, mode: OrderingMode.desc)]))
        .get();
  }
}

