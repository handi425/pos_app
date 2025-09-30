import 'package:drift/drift.dart';

import '../pos_database.dart';
import '../tables.dart';

part 'customers_dao.g.dart';

class CustomerWithDebt {
  const CustomerWithDebt({
    required this.customer,
    required this.totalRemaining,
  });

  final CustomersTableData customer;
  final int totalRemaining;
}

@DriftAccessor(tables: [CustomersTable, DebtsTable])
class CustomersDao extends DatabaseAccessor<PosDatabase>
    with _$CustomersDaoMixin {
  CustomersDao(super.db);

  Future<int> createCustomer(CustomersTableCompanion data) {
    return into(customersTable).insert(data);
  }

  Future<void> updateCustomer(int id, CustomersTableCompanion data) {
    return (update(customersTable)..where((tbl) => tbl.id.equals(id))).write(
      data.copyWith(updatedAt: Value(DateTime.now())),
    );
  }

  Future<void> deleteCustomer(int id) {
    return (delete(customersTable)..where((tbl) => tbl.id.equals(id))).go();
  }

  Stream<List<CustomersTableData>> watchAll() {
    return (select(
      customersTable,
    )..orderBy([(tbl) => OrderingTerm(expression: tbl.name)])).watch();
  }

  Stream<List<CustomerWithDebt>> watchWithDebtSummary() {
    final debtAlias = alias(debtsTable, 'd');
    final remainingSum = debtAlias.remaining.sum();

    final query =
        select(customersTable).join([
            leftOuterJoin(
              debtAlias,
              debtAlias.customerId.equalsExp(customersTable.id) &
                  debtAlias.status.equalsValue(DebtStatus.open),
            ),
          ])
          ..addColumns([remainingSum])
          ..groupBy([customersTable.id])
          ..orderBy([OrderingTerm(expression: customersTable.name)]);

    return query.watch().map((rows) {
      return rows.map((row) {
        final customer = row.readTable(customersTable);
        final remaining = row.read(remainingSum) ?? 0;
        return CustomerWithDebt(customer: customer, totalRemaining: remaining);
      }).toList();
    });
  }

  Future<CustomersTableData?> getById(int id) {
    return (select(
      customersTable,
    )..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
  }
}
