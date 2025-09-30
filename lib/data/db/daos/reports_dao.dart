import 'package:drift/drift.dart';

import '../pos_database.dart';
import '../tables.dart';

part 'reports_dao.g.dart';

class SalesReportSummary {
  const SalesReportSummary({
    required this.totalAmount,
    required this.totalDiscount,
    required this.totalTax,
    required this.totalQuantity,
  });

  final int totalAmount;
  final int totalDiscount;
  final int totalTax;
  final double totalQuantity;
}

class DailySalesSummary {
  const DailySalesSummary({
    required this.date,
    required this.totalAmount,
    required this.totalDiscount,
    required this.totalQuantity,
  });

  final DateTime date;
  final int totalAmount;
  final int totalDiscount;
  final double totalQuantity;
}

class DebtReportSummary {
  const DebtReportSummary({required this.newDebts, required this.payments});

  final int newDebts;
  final int payments;
}

class CashFlowSummary {
  const CashFlowSummary({required this.cashIn, required this.cashOut});

  final int cashIn;
  final int cashOut;
}

@DriftAccessor(
  tables: [
    SalesTable,
    SaleItemsTable,
    DebtsTable,
    DebtPaymentsTable,
    CashLedgerTable,
  ],
)
class ReportsDao extends DatabaseAccessor<PosDatabase> with _$ReportsDaoMixin {
  ReportsDao(PosDatabase db) : super(db);

  Future<SalesReportSummary> salesSummary(DateTime start, DateTime end) async {
    const sql = '''
      SELECT
        COALESCE(SUM(s.total), 0) AS total_amount,
        COALESCE(SUM(s.discount), 0) AS total_discount,
        COALESCE(SUM(s.tax), 0) AS total_tax,
        COALESCE(SUM(si.qty), 0) AS total_qty
      FROM sales s
      LEFT JOIN sale_items si ON si.sale_id = s.id
      WHERE s.datetime BETWEEN ? AND ?
    ''';

    final result = await customSelect(
      sql,
      variables: [Variable.withDateTime(start), Variable.withDateTime(end)],
      readsFrom: {salesTable, saleItemsTable},
    ).getSingle();

    final totalAmount = result.read<int?>('total_amount') ?? 0;
    final totalDiscount = result.read<int?>('total_discount') ?? 0;
    final totalTax = result.read<int?>('total_tax') ?? 0;
    final totalQty = result.read<double?>('total_qty') ?? 0;

    return SalesReportSummary(
      totalAmount: totalAmount,
      totalDiscount: totalDiscount,
      totalTax: totalTax,
      totalQuantity: totalQty.toDouble(),
    );
  }

  Future<List<DailySalesSummary>> dailySales(
    DateTime start,
    DateTime end,
  ) async {
    const sql = '''
      SELECT
        DATE(s.datetime) AS sale_date,
        COALESCE(SUM(s.total), 0) AS total_amount,
        COALESCE(SUM(s.discount), 0) AS total_discount,
        COALESCE(SUM(si.qty), 0) AS total_qty
      FROM sales s
      LEFT JOIN sale_items si ON si.sale_id = s.id
      WHERE s.datetime BETWEEN ? AND ?
      GROUP BY sale_date
      ORDER BY sale_date ASC
    ''';

    final rows = await customSelect(
      sql,
      variables: [Variable.withDateTime(start), Variable.withDateTime(end)],
      readsFrom: {salesTable, saleItemsTable},
    ).get();

    return rows
        .map(
          (row) => DailySalesSummary(
            date: DateTime.parse(row.read<String>('sale_date')),
            totalAmount: row.read<int?>('total_amount') ?? 0,
            totalDiscount: row.read<int?>('total_discount') ?? 0,
            totalQuantity: (row.read<double?>('total_qty') ?? 0).toDouble(),
          ),
        )
        .toList();
  }

  Future<DebtReportSummary> debtSummary(DateTime start, DateTime end) async {
    final debtsTotal =
        await (selectOnly(debtsTable)
              ..where(debtsTable.createdAt.isBetweenValues(start, end))
              ..addColumns([debtsTable.principal.sum()]))
            .getSingleOrNull();

    final paymentsTotal =
        await (selectOnly(debtPaymentsTable)
              ..where(debtPaymentsTable.datetime.isBetweenValues(start, end))
              ..addColumns([debtPaymentsTable.amount.sum()]))
            .getSingleOrNull();

    return DebtReportSummary(
      newDebts: debtsTotal?.read(debtsTable.principal.sum()) ?? 0,
      payments: paymentsTotal?.read(debtPaymentsTable.amount.sum()) ?? 0,
    );
  }

  Future<CashFlowSummary> cashFlowSummary(DateTime start, DateTime end) async {
    final cashIn =
        await (selectOnly(cashLedgerTable)
              ..where(
                cashLedgerTable.datetime.isBetweenValues(start, end) &
                    cashLedgerTable.type.equalsValue(CashLedgerType.inFlow),
              )
              ..addColumns([cashLedgerTable.amount.sum()]))
            .getSingleOrNull();

    final cashOut =
        await (selectOnly(cashLedgerTable)
              ..where(
                cashLedgerTable.datetime.isBetweenValues(start, end) &
                    cashLedgerTable.type.equalsValue(CashLedgerType.outFlow),
              )
              ..addColumns([cashLedgerTable.amount.sum()]))
            .getSingleOrNull();

    return CashFlowSummary(
      cashIn: cashIn?.read(cashLedgerTable.amount.sum()) ?? 0,
      cashOut: cashOut?.read(cashLedgerTable.amount.sum()) ?? 0,
    );
  }
}
