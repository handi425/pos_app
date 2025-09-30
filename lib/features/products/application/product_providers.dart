import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/repos/product_repository_impl.dart';
import '../../../domain/entities/category.dart';
import '../../../domain/entities/product.dart';

final productCategoryFilterProvider = StateProvider<int?>((ref) => null);
final productSearchQueryProvider = StateProvider<String>((ref) => '');

final productsStreamProvider = StreamProvider<List<Product>>((ref) {
  final repo = ref.watch(productRepositoryProvider);
  return repo.watchProducts();
});

final productCategoriesProvider = StreamProvider<List<Category>>((ref) {
  final repo = ref.watch(productRepositoryProvider);
  return repo.watchCategories();
});

final lowStockProductsProvider = FutureProvider<List<Product>>((ref) {
  final repo = ref.watch(productRepositoryProvider);
  return repo.lowStockProducts();
});

final filteredProductsProvider = Provider<List<Product>>((ref) {
  final products = ref
      .watch(productsStreamProvider)
      .maybeWhen(data: (data) => data, orElse: () => const <Product>[]);
  final query = ref.watch(productSearchQueryProvider).toLowerCase();
  final categoryId = ref.watch(productCategoryFilterProvider);

  return products.where((product) {
    final matchesCategory =
        categoryId == null || product.categoryId == categoryId;
    final matchesQuery =
        query.isEmpty ||
        product.name.toLowerCase().contains(query) ||
        product.sku.toLowerCase().contains(query);
    return matchesCategory && matchesQuery;
  }).toList();
});
