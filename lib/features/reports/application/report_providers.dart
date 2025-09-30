import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/repos/report_repository_impl.dart';
import '../../../domain/entities/report_summaries.dart';

final reportRangeProvider = StateProvider<({DateTime start, DateTime end})>((
  ref,
) {
  final now = DateTime.now();
  final start = DateTime(
    now.year,
    now.month,
    now.day,
  ).subtract(const Duration(days: 6));
  return (start: start, end: now);
});

final salesAggregateProvider = FutureProvider<SalesReportAggregate>((
  ref,
) async {
  final repo = ref.watch(reportRepositoryProvider);
  final range = ref.watch(reportRangeProvider);
  return repo.salesSummary(range.start, range.end);
});

final cashFlowAggregateProvider = FutureProvider<CashFlowAggregate>((
  ref,
) async {
  final repo = ref.watch(reportRepositoryProvider);
  final range = ref.watch(reportRangeProvider);
  return repo.cashFlowSummary(range.start, range.end);
});

final debtAggregateProvider = FutureProvider<DebtReportAggregate>((ref) async {
  final repo = ref.watch(reportRepositoryProvider);
  final range = ref.watch(reportRangeProvider);
  return repo.debtSummary(range.start, range.end);
});

final dailySalesReportProvider = FutureProvider<List<DailySalesReport>>((
  ref,
) async {
  final repo = ref.watch(reportRepositoryProvider);
  final range = ref.watch(reportRangeProvider);
  return repo.dailySales(range.start, range.end);
});
