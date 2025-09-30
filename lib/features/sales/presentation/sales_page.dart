import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/utils/money_formatter.dart';
import '../../../domain/entities/category.dart';
import '../../../domain/entities/product.dart';
import '../../products/application/product_providers.dart';
import '../application/cart_controller.dart';

class SalesPage extends ConsumerWidget {
  const SalesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsAsync = ref.watch(productsStreamProvider);
    final categoriesAsync = ref.watch(productCategoriesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Kasir'),
        actions: [
          IconButton(
            icon: const Icon(Icons.qr_code_scanner),
            tooltip: 'Scan barcode',
            onPressed: () {},
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth > 960;
          return Padding(
            padding: const EdgeInsets.all(20),
            child: isWide
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 7,
                        child: _CatalogSection(
                          isWide: true,
                          productsAsync: productsAsync,
                          categoriesAsync: categoriesAsync,
                        ),
                      ),
                      const SizedBox(width: 24),
                      const Expanded(flex: 4, child: _CartSection()),
                    ],
                  )
                : ListView(
                    children: [
                      _CatalogSection(
                        isWide: false,
                        productsAsync: productsAsync,
                        categoriesAsync: categoriesAsync,
                      ),
                      const SizedBox(height: 24),
                      const _CartSection(),
                    ],
                  ),
          );
        },
      ),
    );
  }
}

class _CatalogSection extends ConsumerWidget {
  const _CatalogSection({
    required this.isWide,
    required this.productsAsync,
    required this.categoriesAsync,
  });

  final bool isWide;
  final AsyncValue<List<Product>> productsAsync;
  final AsyncValue<List<Category>> categoriesAsync;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchQuery = ref.watch(salesSearchQueryProvider);
    final selectedCategoryId = ref.watch(salesCategoryFilterProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Card(
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Cari nama produk atau SKU',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) =>
                      ref.read(salesSearchQueryProvider.notifier).state = value,
                ),
                const SizedBox(height: 12),
                categoriesAsync.when(
                  loading: () => const SizedBox(
                    height: 36,
                    child: Center(child: CircularProgressIndicator()),
                  ),
                  error: (error, stackTrace) =>
                      Text('Gagal memuat kategori: $error'),
                  data: (categories) {
                    return SizedBox(
                      height: 36,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        separatorBuilder: (_, __) => const SizedBox(width: 12),
                        itemCount: categories.length + 1,
                        itemBuilder: (context, index) {
                          if (index == 0) {
                            return FilterChip(
                              selected: selectedCategoryId == null,
                              onSelected: (_) =>
                                  ref
                                          .read(
                                            salesCategoryFilterProvider
                                                .notifier,
                                          )
                                          .state =
                                      null,
                              label: const Text('Semua'),
                            );
                          }
                          final category = categories[index - 1];
                          return FilterChip(
                            selected: selectedCategoryId == category.id,
                            onSelected: (_) =>
                                ref
                                    .read(salesCategoryFilterProvider.notifier)
                                    .state = category
                                    .id,
                            label: Text(category.name),
                          );
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        productsAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stackTrace) => Text('Gagal memuat produk: $error'),
          data: (products) {
            final query = searchQuery.toLowerCase();
            final filtered = products.where((product) {
              final matchCategory =
                  selectedCategoryId == null ||
                  product.categoryId == selectedCategoryId;
              final matchQuery =
                  query.isEmpty ||
                  product.name.toLowerCase().contains(query) ||
                  product.sku.toLowerCase().contains(query);
              return matchCategory && matchQuery;
            }).toList();

            if (filtered.isEmpty) {
              return const Padding(
                padding: EdgeInsets.symmetric(vertical: 32),
                child: Center(
                  child: Text(
                    'Belum ada produk yang cocok. Tambahkan produk baru terlebih dahulu.',
                  ),
                ),
              );
            }

            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: isWide ? 4 : 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.08,
              ),
              itemCount: filtered.length,
              itemBuilder: (context, index) {
                final product = filtered[index];
                return _ProductTile(product: product);
              },
            );
          },
        ),
      ],
    );
  }
}

class _ProductTile extends ConsumerWidget {
  const _ProductTile({required this.product});

  final Product product;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () =>
          ref.read(cartControllerProvider.notifier).addProduct(product),
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
          ),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: theme.colorScheme.primary.withValues(alpha: 0.08),
                ),
                child: const Center(
                  child: Icon(Icons.inventory_2_outlined, size: 32),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              product.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.titleMedium,
            ),
            const SizedBox(height: 4),
            Text('SKU ${product.sku}', style: theme.textTheme.bodySmall),
            const SizedBox(height: 4),
            Text(
              MoneyFormatter.format(product.price),
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              'Stok ${product.stock.toStringAsFixed(0)} pcs',
              style: theme.textTheme.labelSmall,
            ),
          ],
        ),
      ),
    );
  }
}

class _CartSection extends ConsumerWidget {
  const _CartSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cart = ref.watch(cartControllerProvider);
    final cartNotifier = ref.read(cartControllerProvider.notifier);
    final theme = Theme.of(context);
    final items = cart.items;

    return LayoutBuilder(
      builder: (context, constraints) {
        final availableHeight = constraints.maxHeight.isFinite
            ? constraints.maxHeight
            : 480;
        final listHeight = (availableHeight - 240)
            .clamp(200.0, 360.0)
            .toDouble();

        return Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Keranjang', style: theme.textTheme.titleLarge),
                    TextButton.icon(
                      onPressed: items.isEmpty ? null : cartNotifier.clear,
                      icon: const Icon(Icons.delete_sweep_outlined),
                      label: const Text('Kosongkan'),
                    ),
                  ],
                ),
                const Divider(height: 24),
                if (items.isEmpty)
                  const Expanded(
                    child: Center(child: Text('Belum ada item di keranjang.')),
                  )
                else
                  SizedBox(
                    height: listHeight,
                    child: ListView.separated(
                      itemCount: items.length,
                      separatorBuilder: (_, __) => const Divider(),
                      itemBuilder: (context, index) {
                        final item = items[index];
                        return ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: CircleAvatar(
                            backgroundColor: theme.colorScheme.primary
                                .withValues(alpha: 0.1),
                            child: Text('${index + 1}'),
                          ),
                          title: Text(item.name),
                          subtitle: Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.remove_circle_outline),
                                onPressed: () =>
                                    cartNotifier.decrement(item.productId),
                              ),
                              Text(item.quantity.toStringAsFixed(0)),
                              IconButton(
                                icon: const Icon(Icons.add_circle_outline),
                                onPressed: () =>
                                    cartNotifier.increment(item.productId),
                              ),
                            ],
                          ),
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                MoneyFormatter.format(item.lineTotal),
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              TextButton.icon(
                                onPressed: () =>
                                    cartNotifier.removeProduct(item.productId),
                                icon: const Icon(Icons.close, size: 16),
                                label: const Text('Hapus'),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                const Divider(height: 24),
                _CartSummaryRow(
                  label: 'Subtotal',
                  value: MoneyFormatter.format(cart.subtotal),
                ),
                const SizedBox(height: 8),
                _CartSummaryRow(
                  label: 'Diskon',
                  value: MoneyFormatter.format(cart.discountTotal),
                ),
                const SizedBox(height: 8),
                _CartSummaryRow(
                  label: 'Pajak',
                  value: MoneyFormatter.format(cart.tax),
                ),
                const SizedBox(height: 12),
                _CartSummaryRow(
                  label: 'Total Bayar',
                  value: MoneyFormatter.format(cart.grandTotal),
                  emphasize: true,
                ),
                const SizedBox(height: 16),
                FilledButton.icon(
                  onPressed: items.isEmpty ? null : () {},
                  icon: const Icon(Icons.check_circle_outline),
                  label: const Text('Bayar Sekarang'),
                  style: FilledButton.styleFrom(
                    minimumSize: const Size.fromHeight(48),
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

class _CartSummaryRow extends StatelessWidget {
  const _CartSummaryRow({
    required this.label,
    required this.value,
    this.emphasize = false,
  });

  final String label;
  final String value;
  final bool emphasize;

  @override
  Widget build(BuildContext context) {
    final style = emphasize
        ? Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)
        : Theme.of(context).textTheme.bodyMedium;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: style),
        Text(value, style: style),
      ],
    );
  }
}
