import 'package:drift/drift.dart';

import '../pos_database.dart';
import '../tables.dart';

part 'products_dao.g.dart';

class ProductWithCategory {
  ProductWithCategory({required this.product, required this.category});

  final ProductsTableData product;
  final CategoriesTableData category;
}

class ProductStockBalance {
  const ProductStockBalance({
    required this.product,
    required this.currentStock,
    required this.threshold,
  });

  final ProductsTableData product;
  final double currentStock;
  final double threshold;
}

@DriftAccessor(tables: [ProductsTable, CategoriesTable, StockMovementsTable])
class ProductsDao extends DatabaseAccessor<PosDatabase>
    with _$ProductsDaoMixin {
  ProductsDao(PosDatabase db) : super(db);

  Future<int> createProduct(ProductsTableCompanion data) {
    return into(productsTable).insert(data);
  }

  Future<void> updateProduct(int id, ProductsTableCompanion data) {
    return (update(productsTable)..where((tbl) => tbl.id.equals(id))).write(
      data.copyWith(updatedAt: Value(DateTime.now())),
    );
  }

  Future<void> deactivateProduct(int id) {
    return (update(productsTable)..where((tbl) => tbl.id.equals(id))).write(
      const ProductsTableCompanion(isActive: Value(false)),
    );
  }

  Stream<List<ProductWithCategory>> watchAll() {
    final query = select(productsTable).join([
      innerJoin(categoriesTable, categoriesTable.id.equalsExp(productsTable.categoryId)),
    ])
      ..orderBy([
        OrderingTerm(expression: categoriesTable.name),
        OrderingTerm(expression: productsTable.name),
      ]);

    return query.watch().map((rows) {
      return rows
          .map(
            (row) => ProductWithCategory(
              product: row.readTable(productsTable),
              category: row.readTable(categoriesTable),
            ),
          )
          .toList();
    });
  }

  Future<List<ProductStockBalance>> stockBalances() async {
    final results = await (select(productsTable)
          ..orderBy([(tbl) => OrderingTerm(expression: tbl.name)]))
        .get();

    return results
        .map(
          (product) => ProductStockBalance(
            product: product,
            currentStock: product.stock,
            threshold: product.lowStockThreshold,
          ),
        )
        .toList();
  }

  Future<void> adjustStock({
    required int productId,
    required double delta,
    required int userId,
    required StockMovementType type,
    required StockMovementSource source,
    int? referenceId,
    String? note,
  }) async {
    await transaction(() async {
      final product = await getById(productId);
      final newStock = product.stock + delta;

      await (update(productsTable)..where((tbl) => tbl.id.equals(productId))).write(
        ProductsTableCompanion(
          stock: Value(newStock),
          updatedAt: Value(DateTime.now()),
        ),
      );

      await into(stockMovementsTable).insert(
        StockMovementsTableCompanion.insert(
          productId: productId,
          userId: userId,
          type: type,
          qty: delta,
          note: Value(note),
          source: source,
          referenceId: Value(referenceId),
        ),
      );
    });
  }

  Future<List<ProductsTableData>> lowStockProducts() {
    final query = select(productsTable)
      ..where(
        (tbl) => tbl.isActive.equals(true) &
            tbl.stock.isSmallerOrEqual(tbl.lowStockThreshold) &
            tbl.lowStockThreshold.isBiggerThanValue(0.0),
      )
      ..orderBy([(tbl) => OrderingTerm(expression: tbl.stock)]);

    return query.get();
  }

  Future<ProductsTableData?> findBySkuOrBarcode(String query) {
    final normalized = query.trim();
    if (normalized.isEmpty) {
      return Future.value(null);
    }
    final condition = productsTable.sku.equals(normalized) |
        productsTable.barcode.equals(normalized);
    return (select(productsTable)..where((tbl) => condition)..limit(1))
        .getSingleOrNull();
  }

  Future<ProductsTableData> getById(int id) {
    return (select(productsTable)..where((tbl) => tbl.id.equals(id))).getSingle();
  }

  Future<CategoriesTableData> getCategory(int id) {
    return (select(categoriesTable)..where((tbl) => tbl.id.equals(id))).getSingle();
  }
}
