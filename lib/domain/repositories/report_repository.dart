import '../entities/report_summaries.dart';

abstract class ReportRepository {
  Future<DashboardSummary> dashboardSummary(DateTime date);
  Future<SalesReportAggregate> salesSummary(DateTime start, DateTime end);
  Future<List<DailySalesReport>> dailySales(DateTime start, DateTime end);
  Future<DebtReportAggregate> debtSummary(DateTime start, DateTime end);
  Future<CashFlowAggregate> cashFlowSummary(DateTime start, DateTime end);
}
