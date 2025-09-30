import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/category.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../db/database_provider.dart';
import '../db/pos_database.dart';
import '../db/tables.dart' as db;
import 'mappers.dart';

class ProductRepositoryImpl implements ProductRepository {
  ProductRepositoryImpl(this._db);

  final PosDatabase _db;

  @override
  Future<Category> createCategory(String name) async {
    final id = await _db.categoriesDao.create(name);
    final list = await _db.categoriesDao.getAll();
    final created = list.firstWhere((element) => element.id == id);
    return mapCategory(created);
  }

  @override
  Future<Product> createProduct(Product product) async {
    final id = await _db.productsDao.createProduct(_toInsertCompanion(product));
    final created = await _db.productsDao.getById(id);
    final category = await _db.productsDao.getCategory(created.categoryId);
    return mapProduct(created, category: category);
  }

  @override
  Future<void> deactivateProduct(int id) =>
      _db.productsDao.deactivateProduct(id);

  @override
  Future<Product?> findBySkuOrBarcode(String query) async {
    final data = await _db.productsDao.findBySkuOrBarcode(query);
    if (data == null) {
      return null;
    }
    final category = await _db.productsDao.getCategory(data.categoryId);
    return mapProduct(data, category: category);
  }

  @override
  Future<List<Product>> lowStockProducts() async {
    final products = await _db.productsDao.lowStockProducts();
    final categories = await _db.categoriesDao.getAll();
    final categoryMap = {for (final c in categories) c.id: c};
    return products
        .map((item) => mapProduct(item, category: categoryMap[item.categoryId]))
        .toList();
  }

  @override
  Future<void> renameCategory(int id, String name) =>
      _db.categoriesDao.updateCategory(id, name);

  @override
  Future<Product> updateProduct(Product product) async {
    await _db.productsDao.updateProduct(
      product.id,
      _toUpdateCompanion(product),
    );
    final updated = await _db.productsDao.getById(product.id);
    final category = await _db.productsDao.getCategory(updated.categoryId);
    return mapProduct(updated, category: category);
  }

  @override
  Stream<List<Category>> watchCategories() {
    return _db.categoriesDao.watchAll().map(
      (rows) => rows.map(mapCategory).toList(),
    );
  }

  @override
  Stream<List<Product>> watchProducts() {
    return _db.productsDao.watchAll().map(
      (rows) => rows
          .map((row) => mapProduct(row.product, category: row.category))
          .toList(),
    );
  }

  @override
  Future<void> adjustStock({
    required int productId,
    required double delta,
    required int userId,
    String? note,
  }) {
    final type = delta >= 0
        ? db.StockMovementType.inAdjustment
        : db.StockMovementType.adjust;
    return _db.productsDao.adjustStock(
      productId: productId,
      delta: delta,
      userId: userId,
      type: type,
      source: db.StockMovementSource.manual,
      note: note,
    );
  }

  ProductsTableCompanion _toInsertCompanion(Product product) {
    return ProductsTableCompanion.insert(
      categoryId: product.categoryId,
      name: product.name,
      sku: product.sku,
      barcode: Value(product.barcode),
      price: Value(product.price),
      cost: Value(product.cost),
      stock: Value(product.stock),
      lowStockThreshold: Value(product.lowStockThreshold),
      isActive: Value(product.isActive),
    );
  }

  ProductsTableCompanion _toUpdateCompanion(Product product) {
    return ProductsTableCompanion(
      categoryId: Value(product.categoryId),
      name: Value(product.name),
      sku: Value(product.sku),
      barcode: Value(product.barcode),
      price: Value(product.price),
      cost: Value(product.cost),
      stock: Value(product.stock),
      lowStockThreshold: Value(product.lowStockThreshold),
      isActive: Value(product.isActive),
      updatedAt: Value(DateTime.now()),
    );
  }
}

final productRepositoryProvider = Provider<ProductRepository>((ref) {
  final db = ref.watch(posDatabaseProvider);
  return ProductRepositoryImpl(db);
});
