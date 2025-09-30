import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReportsPage extends ConsumerWidget {
  const ReportsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reportCards = [
      _ReportCard(
        title: 'Ringkasan Penjualan',
        description: 'Total omzet, diskon, dan pajak dalam periode terpilih.',
        icon: Icons.stacked_bar_chart,
        color: Colors.blue,
      ),
      _ReportCard(
        title: 'Arus Kas',
        description: 'Lihat kas masuk dan keluar per hari atau per akun.',
        icon: Icons.account_balance_wallet_outlined,
        color: Colors.green,
      ),
      _ReportCard(
        title: 'Kasbon & Penagihan',
        description: 'Monitor kasbon baru dan pembayaran yang masuk.',
        icon: Icons.receipt_long_outlined,
        color: Colors.orange,
      ),
    ];

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
                width: 220,
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.calendar_today_outlined),
                  label: const Text('Tanggal: Minggu ini'),
                ),
              ),
              SizedBox(
                width: 200,
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.storefront_outlined),
                  label: const Text('Semua toko'),
                ),
              ),
              SizedBox(
                width: 200,
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.badge_outlined),
                  label: const Text('Semua kasir'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          ...reportCards.map(
            (card) => Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Card(
                elevation: 1,
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: card.color.withValues(alpha: 0.12),
                    foregroundColor: card.color,
                    child: Icon(card.icon),
                  ),
                  title: Text(card.title),
                  subtitle: Text(card.description),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {},
                ),
              ),
            ),
          ),
          Card(
            elevation: 1,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Snapshot Komisi Kasir',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 12),
                  _CommissionRow(name: 'Kasir A', amount: 'Rp 115000'),
                  Divider(),
                  _CommissionRow(name: 'Kasir B', amount: 'Rp 87500'),
                  Divider(),
                  _CommissionRow(name: 'Kasir C', amount: 'Rp 45000'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ReportCard {
  const _ReportCard({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
  });

  final String title;
  final String description;
  final IconData icon;
  final Color color;
}

class _CommissionRow extends StatelessWidget {
  const _CommissionRow({required this.name, required this.amount});

  final String name;
  final String amount;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(name),
        Text(amount, style: const TextStyle(fontWeight: FontWeight.w600)),
      ],
    );
  }
}
