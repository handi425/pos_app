import 'package:drift/drift.dart';

import '../pos_database.dart';
import '../tables.dart';

part 'cash_ledger_dao.g.dart';

@DriftAccessor(tables: [CashLedgerTable, UsersTable])
class CashLedgerDao extends DatabaseAccessor<PosDatabase>
    with _$CashLedgerDaoMixin {
  CashLedgerDao(PosDatabase db) : super(db);

  Stream<List<CashLedgerTableData>> watchRange(DateTime start, DateTime end) {
    return (select(cashLedgerTable)
          ..where((tbl) => tbl.datetime.isBetweenValues(start, end))
          ..orderBy([(tbl) => OrderingTerm(expression: tbl.datetime, mode: OrderingMode.desc)]))
        .watch();
  }

  Future<int> insertEntry(CashLedgerTableCompanion data) {
    return into(cashLedgerTable).insert(data);
  }
}
