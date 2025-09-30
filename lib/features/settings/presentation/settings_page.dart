import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pengaturan')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const _SectionHeader(title: 'Profil Toko'),
          Card(
            child: Column(
              children: const [
                ListTile(
                  leading: Icon(Icons.storefront_outlined),
                  title: Text('Informasi Toko'),
                  subtitle: Text('Nama usaha, alamat, dan kontak'),
                  trailing: Icon(Icons.chevron_right),
                ),
                Divider(height: 1),
                ListTile(
                  leading: Icon(Icons.lock_outline),
                  title: Text('Keamanan'),
                  subtitle: Text('Ubah PIN dan hak akses pengguna'),
                  trailing: Icon(Icons.chevron_right),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const _SectionHeader(title: 'Preferensi'),
          Card(
            child: Column(
              children: const [
                SwitchListTile(
                  value: true,
                  onChanged: null,
                  title: Text('Gunakan tema gelap otomatis'),
                  subtitle: Text('Menyesuaikan dengan pengaturan perangkat'),
                ),
                Divider(height: 1),
                ListTile(
                  leading: Icon(Icons.print_outlined),
                  title: Text('Perangkat Cetak'),
                  subtitle: Text('Kelola printer Bluetooth ESC/POS'),
                  trailing: Icon(Icons.chevron_right),
                ),
                Divider(height: 1),
                ListTile(
                  leading: Icon(Icons.backup_outlined),
                  title: Text('Backup & Restore'),
                  subtitle: Text('Ekspor basis data lokal dan impor cadangan'),
                  trailing: Icon(Icons.chevron_right),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const _SectionHeader(title: 'Tentang Aplikasi'),
          Card(
            child: Column(
              children: const [
                ListTile(
                  leading: Icon(Icons.info_outline),
                  title: Text('Versi 0.1.0'),
                  subtitle: Text('KasPOS Offline POS'),
                ),
                Divider(height: 1),
                ListTile(
                  leading: Icon(Icons.description_outlined),
                  title: Text('Dokumentasi & Catatan Rilis'),
                  trailing: Icon(Icons.open_in_new),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        title,
        style: Theme.of(
          context,
        ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }
}
