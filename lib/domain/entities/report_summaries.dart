import 'package:freezed_annotation/freezed_annotation.dart';

import 'customer.dart';
import 'product.dart';

part 'report_summaries.freezed.dart';
part 'report_summaries.g.dart';

@freezed
class DashboardSummary with _$DashboardSummary {
  const factory DashboardSummary({
    required int totalSalesToday,
    required int transactionsToday,
    required int cashInToday,
    required int cashOutToday,
    required int outstandingDebt,
    @Default(0) int lowStockCount,
  }) = _DashboardSummary;

  factory DashboardSummary.fromJson(Map<String, dynamic> json) =>
      _$DashboardSummaryFromJson(json);
}

@freezed
class SalesReportAggregate with _$SalesReportAggregate {
  const factory SalesReportAggregate({
    required int totalAmount,
    required int totalDiscount,
    required int totalTax,
    required double totalQuantity,
  }) = _SalesReportAggregate;

  factory SalesReportAggregate.fromJson(Map<String, dynamic> json) =>
      _$SalesReportAggregateFromJson(json);
}

@freezed
class DailySalesReport with _$DailySalesReport {
  const factory DailySalesReport({
    required DateTime date,
    required int totalAmount,
    required int totalDiscount,
    required double totalQuantity,
  }) = _DailySalesReport;

  factory DailySalesReport.fromJson(Map<String, dynamic> json) =>
      _$DailySalesReportFromJson(json);
}

@freezed
class CashFlowAggregate with _$CashFlowAggregate {
  const factory CashFlowAggregate({required int cashIn, required int cashOut}) =
      _CashFlowAggregate;

  factory CashFlowAggregate.fromJson(Map<String, dynamic> json) =>
      _$CashFlowAggregateFromJson(json);
}

@freezed
class DebtReportAggregate with _$DebtReportAggregate {
  const factory DebtReportAggregate({
    required int newDebts,
    required int payments,
  }) = _DebtReportAggregate;

  factory DebtReportAggregate.fromJson(Map<String, dynamic> json) =>
      _$DebtReportAggregateFromJson(json);
}

@freezed
class CustomerDebtSummary with _$CustomerDebtSummary {
  const factory CustomerDebtSummary({
    required Customer customer,
    required int totalRemaining,
  }) = _CustomerDebtSummary;

  factory CustomerDebtSummary.fromJson(Map<String, dynamic> json) =>
      _$CustomerDebtSummaryFromJson(json);
}

@freezed
class LowStockAlert with _$LowStockAlert {
  const factory LowStockAlert({required Product product}) = _LowStockAlert;

  factory LowStockAlert.fromJson(Map<String, dynamic> json) =>
      _$LowStockAlertFromJson(json);
}
