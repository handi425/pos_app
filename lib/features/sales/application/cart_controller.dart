import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entities/product.dart';
import '../../../domain/entities/sale_draft.dart';

final salesCategoryFilterProvider = StateProvider<int?>((ref) => null);
final salesSearchQueryProvider = StateProvider<String>((ref) => '');

final cartControllerProvider = StateNotifierProvider<CartController, SaleDraft>(
  (ref) => CartController(),
);

class CartController extends StateNotifier<SaleDraft> {
  CartController() : super(const SaleDraft(items: []));

  void addProduct(Product product) {
    final items = [...state.items];
    final index = items.indexWhere(
      (element) => element.productId == product.id,
    );
    if (index >= 0) {
      final existing = items[index];
      items[index] = existing.copyWith(quantity: existing.quantity + 1);
    } else {
      items.add(
        CartItem(
          productId: product.id,
          name: product.name,
          quantity: 1,
          price: product.price,
        ),
      );
    }
    state = state.copyWith(items: items);
  }

  void increment(int productId) {
    final items = [...state.items];
    final index = items.indexWhere((element) => element.productId == productId);
    if (index == -1) return;
    final existing = items[index];
    items[index] = existing.copyWith(quantity: existing.quantity + 1);
    state = state.copyWith(items: items);
  }

  void decrement(int productId) {
    final items = [...state.items];
    final index = items.indexWhere((element) => element.productId == productId);
    if (index == -1) return;
    final existing = items[index];
    final newQty = existing.quantity - 1;
    if (newQty <= 0) {
      items.removeAt(index);
    } else {
      items[index] = existing.copyWith(quantity: newQty);
    }
    state = state.copyWith(items: items);
  }

  void removeProduct(int productId) {
    final items = state.items
        .where((element) => element.productId != productId)
        .toList(growable: false);
    state = state.copyWith(items: items);
  }

  void clear() {
    state = state.copyWith(items: const []);
  }
}
