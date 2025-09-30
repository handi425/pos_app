import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/utils/money_formatter.dart';
import '../application/report_providers.dart';

class ReportsPage extends ConsumerWidget {
  const ReportsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final range = ref.watch(reportRangeProvider);
    final salesAggregate = ref.watch(salesAggregateProvider);
    final cashFlowAggregate = ref.watch(cashFlowAggregateProvider);
    final debtAggregate = ref.watch(debtAggregateProvider);
    final dailySales = ref.watch(dailySalesReportProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Laporan'),
        actions: [
          IconButton(
            icon: const Icon(Icons.download_outlined),
            tooltip: 'Export CSV',
            onPressed: () {},
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              SizedBox(
                width: 240,
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.calendar_today_outlined),
                  label: Text(
                    '${range.start.toIso8601String().substring(0, 10)} - ${range.end.toIso8601String().substring(0, 10)}',
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          salesAggregate.when(
            loading: () =>
                const _ReportLoadingCard(title: 'Ringkasan Penjualan'),
            error: (error, stackTrace) => _ReportErrorCard(
              title: 'Ringkasan Penjualan',
              message: '$error',
            ),
            data: (data) => _ReportSummaryCard(
              title: 'Ringkasan Penjualan',
              icon: Icons.stacked_bar_chart,
              color: Colors.blue,
              rows: [
                ('Omzet', MoneyFormatter.format(data.totalAmount)),
                ('Diskon', MoneyFormatter.format(data.totalDiscount)),
                ('Pajak', MoneyFormatter.format(data.totalTax)),
                ('Total Qty', data.totalQuantity.toStringAsFixed(0)),
              ],
            ),
          ),
          const SizedBox(height: 16),
          cashFlowAggregate.when(
            loading: () => const _ReportLoadingCard(title: 'Arus Kas'),
            error: (error, stackTrace) =>
                _ReportErrorCard(title: 'Arus Kas', message: '$error'),
            data: (data) => _ReportSummaryCard(
              title: 'Arus Kas',
              icon: Icons.account_balance_wallet_outlined,
              color: Colors.green,
              rows: [
                ('Kas Masuk', MoneyFormatter.format(data.cashIn)),
                ('Kas Keluar', MoneyFormatter.format(data.cashOut)),
              ],
            ),
          ),
          const SizedBox(height: 16),
          debtAggregate.when(
            loading: () =>
                const _ReportLoadingCard(title: 'Kasbon & Penagihan'),
            error: (error, stackTrace) => _ReportErrorCard(
              title: 'Kasbon & Penagihan',
              message: '$error',
            ),
            data: (data) => _ReportSummaryCard(
              title: 'Kasbon & Penagihan',
              icon: Icons.receipt_long_outlined,
              color: Colors.orange,
              rows: [
                ('Kasbon Baru', MoneyFormatter.format(data.newDebts)),
                ('Pembayaran Masuk', MoneyFormatter.format(data.payments)),
              ],
            ),
          ),
          const SizedBox(height: 24),
          dailySales.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stackTrace) =>
                Center(child: Text('Gagal memuat data harian: $error')),
            data: (rows) => Card(
              elevation: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const ListTile(
                    title: Text('Detail Penjualan Harian'),
                    subtitle: Text('7 hari terakhir'),
                  ),
                  const Divider(height: 1),
                  if (rows.isEmpty)
                    const Padding(
                      padding: EdgeInsets.all(16),
                      child: Text('Belum ada data penjualan.'),
                    )
                  else
                    ...rows.map(
                      (row) => ListTile(
                        leading: const Icon(Icons.calendar_today_outlined),
                        title: Text(
                          row.date.toIso8601String().substring(0, 10),
                        ),
                        subtitle: Text(
                          'Qty ${row.totalQuantity.toStringAsFixed(0)} - Diskon ${MoneyFormatter.format(row.totalDiscount)}',
                        ),
                        trailing: Text(MoneyFormatter.format(row.totalAmount)),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ReportSummaryCard extends StatelessWidget {
  const _ReportSummaryCard({
    required this.title,
    required this.icon,
    required this.color,
    required this.rows,
  });

  final String title;
  final IconData icon;
  final Color color;
  final List<(String, String)> rows;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: color.withValues(alpha: 0.12),
                  foregroundColor: color,
                  child: Icon(icon),
                ),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ...rows.map(
              (row) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(row.$1),
                    Text(
                      row.$2,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ReportLoadingCard extends StatelessWidget {
  const _ReportLoadingCard({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            const CircularProgressIndicator(),
            const SizedBox(width: 16),
            Text('Memuat $title...'),
          ],
        ),
      ),
    );
  }
}

class _ReportErrorCard extends StatelessWidget {
  const _ReportErrorCard({required this.title, required this.message});

  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.errorContainer,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(
              Icons.error_outline,
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(width: 12),
            Expanded(child: Text('$title: $message')),
          ],
        ),
      ),
    );
  }
}
