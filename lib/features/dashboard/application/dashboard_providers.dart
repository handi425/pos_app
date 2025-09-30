import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/repos/report_repository_impl.dart';
import '../../../domain/entities/report_summaries.dart';

final dashboardSummaryProvider = FutureProvider<DashboardSummary>((ref) async {
  final repo = ref.watch(reportRepositoryProvider);
  try {
    return await repo.dashboardSummary(DateTime.now());
  } catch (_) {
    return const DashboardSummary(
      totalSalesToday: 0,
      transactionsToday: 0,
      cashInToday: 0,
      cashOutToday: 0,
      outstandingDebt: 0,
    );
  }
});

final dashboardDailyReportProvider = FutureProvider<List<DailySalesReport>>((
  ref,
) async {
  final repo = ref.watch(reportRepositoryProvider);
  final now = DateTime.now();
  final start = DateTime(
    now.year,
    now.month,
    now.day,
  ).subtract(const Duration(days: 6));
  try {
    return await repo.dailySales(start, now);
  } catch (_) {
    return const [];
  }
});
