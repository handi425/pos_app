import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductsPage extends ConsumerWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Produk & Stok'),
          bottom: const TabBar(
            isScrollable: true,
            tabs: [
              Tab(text: 'Daftar Produk'),
              Tab(text: 'Kategori'),
              Tab(text: 'Stok Menipis'),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.cloud_upload_outlined),
              tooltip: 'Import CSV',
              onPressed: () {},
            ),
            const SizedBox(width: 8),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {},
          icon: const Icon(Icons.add),
          label: const Text('Produk baru'),
        ),
        body: const TabBarView(
          children: [_ProductListTab(), _CategoryTab(), _LowStockTab()],
        ),
      ),
    );
  }
}

class _ProductListTab extends StatelessWidget {
  const _ProductListTab();

  @override
  Widget build(BuildContext context) {
    final products = List.generate(12, (index) => index);

    return ListView.separated(
      padding: const EdgeInsets.all(20),
      itemCount: products.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        return Card(
          elevation: 1,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Theme.of(
                context,
              ).colorScheme.primary.withValues(alpha: 0.1),
              foregroundColor: Theme.of(context).colorScheme.primary,
              child: const Icon(Icons.inventory_2_outlined),
            ),
            title: Text('Produk ${index + 1}'),
            subtitle: Text('SKU-00${index + 1} - Stok ${(index + 2) * 3} pcs'),
            trailing: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Rp ${(index + 1) * 12000}'),
                Text(
                  'HPP Rp ${(index + 1) * 8000}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
            onTap: () {},
          ),
        );
      },
    );
  }
}

class _CategoryTab extends StatelessWidget {
  const _CategoryTab();

  @override
  Widget build(BuildContext context) {
    final categories = ['Umum', 'Makanan', 'Minuman', 'Rumah Tangga'];

    return GridView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: categories.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 1.5,
      ),
      itemBuilder: (context, index) {
        final label = categories[index];
        return Card(
          elevation: 1,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 8),
                Text(
                  '${(index + 2) * 5} produk',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const Spacer(),
                Align(
                  alignment: Alignment.bottomRight,
                  child: IconButton(
                    icon: const Icon(Icons.edit_outlined),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _LowStockTab extends StatelessWidget {
  const _LowStockTab();

  @override
  Widget build(BuildContext context) {
    final lowStockItems = List.generate(4, (index) => index);

    if (lowStockItems.isEmpty) {
      return const Center(child: Text('Semua stok aman. Mantap!'));
    }

    return ListView.separated(
      padding: const EdgeInsets.all(20),
      itemBuilder: (context, index) {
        return ListTile(
          leading: const Icon(
            Icons.warning_amber_rounded,
            color: Colors.orange,
          ),
          title: Text('Produk ${index + 1}'),
          subtitle: const Text('Sisa 3 pcs - Batas minimum 5 pcs'),
          trailing: TextButton(
            onPressed: () {},
            child: const Text('Tambah stok'),
          ),
        );
      },
      separatorBuilder: (_, __) => const Divider(),
      itemCount: lowStockItems.length,
    );
  }
}
