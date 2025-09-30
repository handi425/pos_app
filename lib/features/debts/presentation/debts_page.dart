import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/utils/money_formatter.dart';
import '../../../domain/entities/value_enums.dart';
import '../application/debt_providers.dart';

class DebtsPage extends ConsumerWidget {
  const DebtsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final debtsAsync = ref.watch(debtsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Kasbon & Piutang'),
        actions: [
          TextButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.add_card_outlined),
            label: const Text('Catat pembayaran'),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: debtsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Text('Gagal memuat data kasbon: $error'),
          ),
        ),
        data: (debts) {
          if (debts.isEmpty) {
            return const Center(child: Text('Belum ada kasbon aktif.'));
          }
          return ListView.separated(
            padding: const EdgeInsets.all(20),
            itemCount: debts.length,
            separatorBuilder: (_, __) => const Divider(),
            itemBuilder: (context, index) {
              final debt = debts[index];
              return ListTile(
                leading: const Icon(Icons.receipt_long_outlined),
                title: Text(debt.customer.name),
                subtitle: Text(
                  'Kasbon sejak ${debt.createdAt.toIso8601String().substring(0, 10)}',
                ),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Sisa ${MoneyFormatter.format(debt.remaining)}',
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      debt.status == DebtStatusView.open
                          ? 'Status: BELUM LUNAS'
                          : 'Status: LUNAS',
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                ),
                onTap: () {},
              );
            },
          );
        },
      ),
    );
  }
}
