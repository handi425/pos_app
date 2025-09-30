import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DebtsPage extends ConsumerWidget {
  const DebtsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final debts = List.generate(6, (index) => index);

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
      body: ListView.separated(
        padding: const EdgeInsets.all(20),
        itemCount: debts.length,
        separatorBuilder: (_, __) => const Divider(),
        itemBuilder: (context, index) {
          return ListTile(
            leading: const Icon(Icons.receipt_long_outlined),
            title: Text('Pelanggan ${index + 1}'),
            subtitle: const Text('Kasbon sejak 12 Mei 2025'),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: const [
                Text(
                  'Sisa Rp 240000',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 4),
                Text('Status - BELUM LUNAS', style: TextStyle(fontSize: 12)),
              ],
            ),
            onTap: () {},
          );
        },
      ),
    );
  }
}
