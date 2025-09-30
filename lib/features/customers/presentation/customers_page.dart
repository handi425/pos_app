import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/utils/money_formatter.dart';
import '../application/customer_providers.dart';

class CustomersPage extends ConsumerWidget {
  const CustomersPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final customersAsync = ref.watch(customersProvider);
    final debtSummaryAsync = ref.watch(customerDebtSummariesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pelanggan'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person_add_alt_1_outlined),
            tooltip: 'Tambah pelanggan',
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          TextField(
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.search),
              hintText: 'Cari nama atau nomor telepon',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onChanged: (_) {},
          ),
          const SizedBox(height: 16),
          debtSummaryAsync.when(
            loading: () => const _DebtSummaryPlaceholder(),
            error: (error, stackTrace) => _ErrorPlaceholder(message: '$error'),
            data: (summaries) {
              if (summaries.isEmpty) {
                return const SizedBox.shrink();
              }
              return Card(
                elevation: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const ListTile(
                      title: Text('Saldo Kasbon Aktif'),
                      subtitle: Text('Top 3 pelanggan dengan saldo terbesar'),
                    ),
                    const Divider(height: 1),
                    ...summaries
                        .take(3)
                        .map(
                          (summary) => ListTile(
                            leading: const Icon(Icons.receipt_long_outlined),
                            title: Text(summary.customer.name),
                            subtitle: Text(
                              MoneyFormatter.format(summary.totalRemaining),
                            ),
                          ),
                        ),
                  ],
                ),
              );
            },
          ),
          const SizedBox(height: 16),
          customersAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stackTrace) => _ErrorPlaceholder(message: '$error'),
            data: (customers) {
              if (customers.isEmpty) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 48),
                    child: Text(
                      'Belum ada pelanggan. Tambahkan pelanggan baru.',
                    ),
                  ),
                );
              }
              return Column(
                children: customers
                    .map(
                      (customer) => Card(
                        elevation: 1,
                        margin: const EdgeInsets.only(bottom: 16),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Theme.of(
                              context,
                            ).colorScheme.primary.withValues(alpha: 0.1),
                            foregroundColor: Theme.of(
                              context,
                            ).colorScheme.primary,
                            child: Text(
                              customer.name.substring(0, 1).toUpperCase(),
                            ),
                          ),
                          title: Text(customer.name),
                          subtitle: Text(customer.phone ?? '-'),
                          trailing: const Icon(Icons.chevron_right),
                          onTap: () {},
                        ),
                      ),
                    )
                    .toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _DebtSummaryPlaceholder extends StatelessWidget {
  const _DebtSummaryPlaceholder();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: const [
            CircularProgressIndicator(),
            SizedBox(width: 16),
            Text('Memuat ringkasan kasbon...'),
          ],
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
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(
              Icons.error_outline,
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(width: 12),
            Expanded(child: Text('Gagal memuat data: $message')),
          ],
        ),
      ),
    );
  }
}
