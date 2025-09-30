import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_sizes.dart';
import '../../../core/utils/money_formatter.dart';
import '../../products/application/product_providers.dart';

class ProductsPage extends ConsumerWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Produk & Stok'),
          bottom: TabBar(
            isScrollable: true,
            onTap: (index) {
              if (index != 0) {
                ref.read(productSearchQueryProvider.notifier).state = '';
              }
            },
            tabs: const [
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

class _ProductListTab extends ConsumerWidget {
  const _ProductListTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = ref.watch(filteredProductsProvider);
    final categoriesAsync = ref.watch(productCategoriesProvider);
    final searchQuery = ref.watch(productSearchQueryProvider);

    return ListView(
      padding: AppSpacing.page,
      children: [
        TextField(
          decoration: const InputDecoration(
            prefixIcon: Icon(Icons.search),
            hintText: 'Cari nama, SKU, atau barcode',
            isDense: true,
          ),
          onChanged: (value) =>
              ref.read(productSearchQueryProvider.notifier).state = value,
        ),
        const SizedBox(height: AppSpacing.md),
        categoriesAsync.when(
          loading: () => const LinearProgressIndicator(),
          error: (error, stackTrace) => Text('Gagal memuat kategori: $error'),
          data: (categories) {
            return Wrap(
              spacing: AppSpacing.sm,
              children: [
                ChoiceChip(
                  label: const Text('Semua'),
                  selected: ref.watch(productCategoryFilterProvider) == null,
                  onSelected: (_) =>
                      ref.read(productCategoryFilterProvider.notifier).state =
                          null,
                ),
                ...categories.map(
                  (category) => ChoiceChip(
                    label: Text(category.name),
                    selected:
                        ref.watch(productCategoryFilterProvider) == category.id,
                    onSelected: (_) =>
                        ref.read(productCategoryFilterProvider.notifier).state =
                            category.id,
                  ),
                ),
              ],
            );
          },
        ),
        const SizedBox(height: AppSpacing.lg),
        if (products.isEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.xl),
            child: Text(
              searchQuery.isEmpty
                  ? 'Belum ada produk. Tambahkan produk baru untuk mulai berjualan.'
                  : 'Tidak ditemukan produk sesuai pencarian.',
              textAlign: TextAlign.center,
            ),
          )
        else
          ...products.map(
            (product) => Card(
              margin: const EdgeInsets.only(bottom: AppSpacing.md),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Theme.of(
                    context,
                  ).colorScheme.primary.withValues(alpha: 0.12),
                  foregroundColor: Theme.of(context).colorScheme.primary,
                  child: const Icon(Icons.inventory_2_outlined),
                ),
                title: Text(
                  product.name,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                subtitle: Text(
                  '${product.sku} - Stok ${product.stock.toStringAsFixed(0)} pcs',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                trailing: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      MoneyFormatter.format(product.price),
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (product.cost > 0)
                      Text(
                        'HPP ${MoneyFormatter.format(product.cost)}',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                  ],
                ),
                onTap: () {},
              ),
            ),
          ),
      ],
    );
  }
}

class _CategoryTab extends ConsumerWidget {
  const _CategoryTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoriesAsync = ref.watch(productCategoriesProvider);

    return categoriesAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) =>
          Center(child: Text('Gagal memuat kategori: $error')),
      data: (categories) {
        if (categories.isEmpty) {
          return const Center(child: Text('Belum ada kategori.'));
        }
        return GridView.builder(
          padding: AppSpacing.page,
          itemCount: categories.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: AppSpacing.lg,
            crossAxisSpacing: AppSpacing.lg,
            childAspectRatio: 1.5,
          ),
          itemBuilder: (context, index) {
            final category = categories[index];
            return Card(
              child: Padding(
                padding: AppSpacing.card,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      category.name,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      'ID: ${category.id}',
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
      },
    );
  }
}

class _LowStockTab extends ConsumerWidget {
  const _LowStockTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lowStockAsync = ref.watch(lowStockProductsProvider);

    return lowStockAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => Center(child: Text('Error: $error')),
      data: (products) {
        if (products.isEmpty) {
          return const Center(child: Text('Semua stok aman. Mantap!'));
        }
        return ListView.separated(
          padding: AppSpacing.page,
          separatorBuilder: (_, __) => const Divider(),
          itemBuilder: (context, index) {
            final product = products[index];
            return ListTile(
              leading: Icon(
                Icons.warning_amber_rounded,
                color: Theme.of(context).colorScheme.tertiary,
              ),
              title: Text(
                product.name,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              subtitle: Text(
                'Sisa ${product.stock.toStringAsFixed(0)} pcs - Batas minimum ${product.lowStockThreshold.toStringAsFixed(0)} pcs',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              trailing: TextButton(
                onPressed: () {},
                child: const Text('Tambah stok'),
              ),
            );
          },
          itemCount: products.length,
        );
      },
    );
  }
}
