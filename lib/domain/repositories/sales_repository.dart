import '../entities/sale.dart';
import '../entities/sale_draft.dart';
import '../entities/sale_item.dart';

abstract class SalesRepository {
  Stream<List<Sale>> watchRecentSales({int limit = 20});
  Future<Sale> createSale({
    required SaleDraft draft,
    required int userId,
  });
  Future<List<Sale>> salesBetween(DateTime start, DateTime end);
  Future<List<SaleItem>> itemsForSale(int saleId);
}


