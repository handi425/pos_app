import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/utils/money_formatter.dart';
import '../../../domain/entities/report_summaries.dart';
import '../application/dashboard_providers.dart';

class DashboardPage extends ConsumerWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final summaryAsync = ref.watch(dashboardSummaryProvider);
    final dailyAsync = ref.watch(dashboardDailyReportProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Beranda'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {},
            tooltip: 'Notifikasi',
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(dashboardSummaryProvider);
          ref.invalidate(dashboardDailyReportProvider);
          await ref.read(dashboardSummaryProvider.future);
        },
        child: ListView(
          padding: AppSpacing.page,
          children: [
            summaryAsync.when(
              data: (data) => _SummarySection(summary: data),
              error: (error, stackTrace) =>
                  _ErrorPlaceholder(message: error.toString()),
              loading: () => const _SummarySkeleton(),
            ),
            const SizedBox(height: AppSpacing.lg),
            _QuickMenuGrid(onNavigate: (route) => context.go(route)),
            const SizedBox(height: AppSpacing.lg),
            dailyAsync.when(
              data: (rows) => _ReportHighlights(reports: rows),
              loading: () => const _ReportsSkeleton(),
              error: (error, stackTrace) =>
                  _ErrorPlaceholder(message: error.toString()),
            ),
          ],
        ),
      ),
    );
  }
}

class _SummarySection extends StatelessWidget {
  const _SummarySection({required this.summary});

  final DashboardSummary summary;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    final cards = [
      _SummaryCardData(
        title: 'Omzet Hari Ini',
        value: MoneyFormatter.format(summary.totalSalesToday),
        icon: Icons.shopping_bag_outlined,
        color: scheme.primary,
      ),
      _SummaryCardData(
        title: 'Transaksi',
        value: '${summary.transactionsToday}',
        icon: Icons.receipt_long_outlined,
        color: scheme.secondary,
      ),
      _SummaryCardData(
        title: 'Kas Masuk',
        value: MoneyFormatter.format(summary.cashInToday),
        icon: Icons.trending_up,
        color: scheme.tertiary,
      ),
      _SummaryCardData(
        title: 'Kas Keluar',
        value: MoneyFormatter.format(summary.cashOutToday),
        icon: Icons.trending_down,
        color: scheme.error,
      ),
      _SummaryCardData(
        title: 'Piutang',
        value: MoneyFormatter.format(summary.outstandingDebt),
        icon: Icons.account_balance_wallet_outlined,
        color: scheme.primaryContainer,
      ),
      _SummaryCardData(
        title: 'Stok Menipis',
        value: '${summary.lowStockCount}',
        icon: Icons.inventory_2_outlined,
        color: scheme.secondaryContainer,
      ),
    ];

    return Wrap(
      spacing: AppSpacing.md,
      runSpacing: AppSpacing.md,
      children: cards.map((item) => _SummaryCard(data: item)).toList(),
    );
  }
}

class _SummaryCardData {
  const _SummaryCardData({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  final String title;
  final String value;
  final IconData icon;
  final Color color;
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({required this.data});

  final _SummaryCardData data;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ConstrainedBox(
      constraints: const BoxConstraints(minWidth: 160, maxWidth: 200),
      child: Card(
        child: Padding(
          padding: AppSpacing.card,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: data.color.withValues(alpha: 0.12),
                foregroundColor: data.color,
                child: Icon(data.icon),
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                data.value,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                data.title,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _QuickMenuGrid extends StatelessWidget {
  const _QuickMenuGrid({required this.onNavigate});

  final void Function(String route) onNavigate;

  @override
  Widget build(BuildContext context) {
    final quickActions = [
      _QuickAction(
        icon: Icons.point_of_sale,
        label: 'Kasir Cepat',
        description: 'Mulai transaksi baru',
        route: AppRoute.sales.path,
      ),
      _QuickAction(
        icon: Icons.inventory_2,
        label: 'Produk',
        description: 'Kelola stok dan harga',
        route: AppRoute.products.path,
      ),
      _QuickAction(
        icon: Icons.people_alt_outlined,
        label: 'Pelanggan',
        description: 'Riwayat transaksi dan kasbon',
        route: AppRoute.customers.path,
      ),
      _QuickAction(
        icon: Icons.receipt_long,
        label: 'Kasbon',
        description: 'Tagih atau catat pembayaran',
        route: AppRoute.debts.path,
      ),
      _QuickAction(
        icon: Icons.bar_chart_outlined,
        label: 'Laporan',
        description: 'Monitor performa toko',
        route: AppRoute.reports.path,
      ),
      _QuickAction(
        icon: Icons.settings_outlined,
        label: 'Pengaturan',
        description: 'Profil toko dan preferensi',
        route: AppRoute.settings.path,
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Menu Cepat', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: AppSpacing.md),
        Wrap(
          spacing: AppSpacing.md,
          runSpacing: AppSpacing.md,
          children: quickActions
              .map(
                (action) => _QuickActionTile(
                  action: action,
                  onTap: () => onNavigate(action.route),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}

class _QuickAction {
  const _QuickAction({
    required this.icon,
    required this.label,
    required this.description,
    required this.route,
  });

  final IconData icon;
  final String label;
  final String description;
  final String route;
}

class _QuickActionTile extends StatelessWidget {
  const _QuickActionTile({required this.action, required this.onTap});

  final _QuickAction action;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      width: 180,
      child: InkWell(
        borderRadius: AppSpacing.borderRadius,
        onTap: onTap,
        child: Ink(
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: AppSpacing.borderRadius,
            border: Border.all(color: theme.colorScheme.outlineVariant),
          ),
          padding: AppSpacing.compactCard,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(action.icon, size: 26, color: theme.colorScheme.primary),
              const SizedBox(height: AppSpacing.sm),
              Text(
                action.label,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(action.description, style: theme.textTheme.bodySmall),
            ],
          ),
        ),
      ),
    );
  }
}

class _ReportHighlights extends StatelessWidget {
  const _ReportHighlights({required this.reports});

  final List<DailySalesReport> reports;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final items = reports.isEmpty
        ? [
            ListTile(
              leading: const Icon(Icons.info_outline),
              title: const Text('Belum ada data penjualan minggu ini'),
              subtitle: const Text(
                'Tambah transaksi untuk melihat tren harian.',
              ),
            ),
          ]
        : reports
              .map(
                (report) => ListTile(
                  leading: CircleAvatar(
                    backgroundColor: theme.colorScheme.primary.withValues(
                      alpha: 0.12,
                    ),
                    foregroundColor: theme.colorScheme.primary,
                    child: Text(
                      report.date.day.toString().padLeft(2, '0'),
                      style: theme.textTheme.labelLarge,
                    ),
                  ),
                  title: Text(
                    MoneyFormatter.format(report.totalAmount),
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: Text(
                    'Diskon ${MoneyFormatter.format(report.totalDiscount)} - Qty ${report.totalQuantity.toStringAsFixed(0)}',
                    style: theme.textTheme.bodySmall,
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                ),
              )
              .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Laporan 7 Hari Terakhir',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: AppSpacing.md),
        Card(
          child: ListView.separated(
            itemCount: items.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (context, index) => items[index],
          ),
        ),
      ],
    );
  }
}

class _SummarySkeleton extends StatelessWidget {
  const _SummarySkeleton();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: AppSpacing.md,
      runSpacing: AppSpacing.md,
      children: List.generate(
        4,
        (index) => ConstrainedBox(
          constraints: const BoxConstraints(minWidth: 160, maxWidth: 220),
          child: const _SkeletonBox(height: 110),
        ),
      ),
    );
  }
}

class _ReportsSkeleton extends StatelessWidget {
  const _ReportsSkeleton();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: List.generate(
          3,
          (index) => const Padding(
            padding: AppSpacing.card,
            child: _SkeletonBox(height: 52),
          ),
        ),
      ),
    );
  }
}

class _SkeletonBox extends StatelessWidget {
  const _SkeletonBox({required this.height});

  final double height;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: AppSpacing.borderRadius,
      child: Container(
        height: height,
        decoration: BoxDecoration(
          color: Theme.of(
            context,
          ).colorScheme.surfaceContainerHighest.withValues(alpha: 0.35),
        ),
      ),
    );
  }
}

class _ErrorPlaceholder extends StatelessWidget {
  const _ErrorPlaceholder({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.errorContainer,
      child: Padding(
        padding: AppSpacing.card,
        child: Row(
          children: [
            Icon(
              Icons.warning_amber_rounded,
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Text(
                'Tidak dapat memuat ringkasan: $message',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onErrorContainer,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
