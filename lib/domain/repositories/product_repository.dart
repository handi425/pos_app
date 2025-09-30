import '../entities/category.dart';
import '../entities/product.dart';

abstract class ProductRepository {
  Stream<List<Category>> watchCategories();
  Stream<List<Product>> watchProducts();
  Future<Category> createCategory(String name);
  Future<void> renameCategory(int id, String name);
  Future<Product> createProduct(Product product);
  Future<void> updateProduct(Product product);
  Future<void> deactivateProduct(int id);
  Future<void> adjustStock({
    required int productId,
    required double delta,
    required int userId,
    String? note,
  });
  Future<List<Product>> lowStockProducts();
  Future<Product?> findBySkuOrBarcode(String query);
}
