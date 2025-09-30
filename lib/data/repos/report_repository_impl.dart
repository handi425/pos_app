import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/report_summaries.dart';
import '../../domain/repositories/report_repository.dart';
import '../db/database_provider.dart';
import '../db/pos_database.dart';
import '../db/tables.dart' as db;

class ReportRepositoryImpl implements ReportRepository {
  ReportRepositoryImpl(this._db);

  final PosDatabase _db;

  @override
  Future<DashboardSummary> dashboardSummary(DateTime date) async {
    final start = DateTime(date.year, date.month, date.day);
    final end = start
        .add(const Duration(days: 1))
        .subtract(const Duration(milliseconds: 1));

    final salesRows = await (_db.select(
      _db.salesTable,
    )..where((tbl) => tbl.datetime.isBetweenValues(start, end))).get();
    final salesTotal = salesRows.fold<int>(0, (sum, row) => sum + row.total);

    final cashFlow = await _db.reportsDao.cashFlowSummary(start, end);
    final outstandingDebt = await _overallOutstandingDebt();
    final lowStock = await _db.productsDao.lowStockProducts();

    return DashboardSummary(
      totalSalesToday: salesTotal,
      transactionsToday: salesRows.length,
      cashInToday: cashFlow.cashIn,
      cashOutToday: cashFlow.cashOut,
      outstandingDebt: outstandingDebt,
      lowStockCount: lowStock.length,
    );
  }

  @override
  Future<SalesReportAggregate> salesSummary(
    DateTime start,
    DateTime end,
  ) async {
    final result = await _db.reportsDao.salesSummary(start, end);
    return SalesReportAggregate(
      totalAmount: result.totalAmount,
      totalDiscount: result.totalDiscount,
      totalTax: result.totalTax,
      totalQuantity: result.totalQuantity,
    );
  }

  @override
  Future<List<DailySalesReport>> dailySales(DateTime start, DateTime end) {
    return _db.reportsDao
        .dailySales(start, end)
        .then(
          (rows) => rows
              .map(
                (row) => DailySalesReport(
                  date: row.date,
                  totalAmount: row.totalAmount,
                  totalDiscount: row.totalDiscount,
                  totalQuantity: row.totalQuantity,
                ),
              )
              .toList(),
        );
  }

  @override
  Future<DebtReportAggregate> debtSummary(DateTime start, DateTime end) async {
    final result = await _db.reportsDao.debtSummary(start, end);
    return DebtReportAggregate(
      newDebts: result.newDebts,
      payments: result.payments,
    );
  }

  @override
  Future<CashFlowAggregate> cashFlowSummary(
    DateTime start,
    DateTime end,
  ) async {
    final result = await _db.reportsDao.cashFlowSummary(start, end);
    return CashFlowAggregate(cashIn: result.cashIn, cashOut: result.cashOut);
  }

  Future<int> _overallOutstandingDebt() async {
    final rows = await (_db.select(
      _db.debtsTable,
    )..where((tbl) => tbl.status.equalsValue(db.DebtStatus.open))).get();
    return rows.fold<int>(0, (sum, row) => sum + row.remaining);
  }
}

final reportRepositoryProvider = Provider<ReportRepository>((ref) {
  final db = ref.watch(posDatabaseProvider);
  return ReportRepositoryImpl(db);
});
