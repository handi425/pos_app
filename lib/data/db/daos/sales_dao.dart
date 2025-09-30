import 'package:drift/drift.dart';

import '../pos_database.dart';
import '../tables.dart';

part 'sales_dao.g.dart';

class SaleItemInput {
  const SaleItemInput({
    required this.productId,
    required this.qty,
    required this.price,
    required this.discount,
    required this.total,
  });

  final int productId;
  final double qty;
  final int price;
  final int discount;
  final int total;
}

class SaleInsertResult {
  const SaleInsertResult({required this.saleId, this.debtId});

  final int saleId;
  final int? debtId;
}

@DriftAccessor(
  tables: [
    SalesTable,
    SaleItemsTable,
    ProductsTable,
    StockMovementsTable,
    DebtsTable,
    CashLedgerTable,
  ],
)
class SalesDao extends DatabaseAccessor<PosDatabase> with _$SalesDaoMixin {
  SalesDao(super.db);

  Future<SaleInsertResult> createSale({
    required SalesTableCompanion sale,
    required List<SaleItemInput> items,
    required int userId,
  }) async {
    return transaction(() async {
      final saleId = await into(salesTable).insert(sale);

      for (final item in items) {
        await into(saleItemsTable).insert(
          SaleItemsTableCompanion.insert(
            saleId: saleId,
            productId: item.productId,
            qty: item.qty,
            price: item.price,
            discount: Value(item.discount),
            total: item.total,
          ),
        );

        final product = await (select(
          productsTable,
        )..where((tbl) => tbl.id.equals(item.productId))).getSingle();

        final updatedStock = product.stock - item.qty;
        await (update(
          productsTable,
        )..where((tbl) => tbl.id.equals(item.productId))).write(
          ProductsTableCompanion(
            stock: Value(updatedStock),
            updatedAt: Value(DateTime.now()),
          ),
        );

        await into(stockMovementsTable).insert(
          StockMovementsTableCompanion.insert(
            productId: item.productId,
            userId: userId,
            type: StockMovementType.outSale,
            qty: -item.qty,
            note: const Value('Penjualan kasir'),
            source: StockMovementSource.sale,
            referenceId: Value(saleId),
          ),
        );
      }

      if (sale.paid.present && sale.paid.value > 0) {
        await into(cashLedgerTable).insert(
          CashLedgerTableCompanion.insert(
            type: CashLedgerType.inFlow,
            amount: sale.paid.value,
            refType: CashLedgerRefType.sale,
            refId: Value(saleId),
            note: Value(
              sale.notes.present ? sale.notes.value : 'Penjualan kasir',
            ),
            datetime: sale.datetime.present
                ? sale.datetime.value
                : DateTime.now(),
            userId: userId,
          ),
        );
      }

      int? debtId;
      if (sale.isCredit.present &&
          sale.isCredit.value &&
          sale.customerId.present) {
        final creditAmount =
            sale.total.value - (sale.paid.present ? sale.paid.value : 0);
        debtId = await into(debtsTable).insert(
          DebtsTableCompanion.insert(
            customerId: sale.customerId.value!,
            saleId: saleId,
            principal: creditAmount,
            remaining: creditAmount,
            status: DebtStatus.open,
          ),
        );
      }

      return SaleInsertResult(saleId: saleId, debtId: debtId);
    });
  }

  Stream<List<SalesTableData>> watchRecentSales({int limit = 20}) {
    final query = (select(salesTable)
      ..orderBy([
        (tbl) =>
            OrderingTerm(expression: tbl.datetime, mode: OrderingMode.desc),
      ])
      ..limit(limit));
    return query.watch();
  }

  Future<List<SaleItemsTableData>> itemsForSale(int saleId) {
    return (select(
      saleItemsTable,
    )..where((tbl) => tbl.saleId.equals(saleId))).get();
  }

  Future<SalesTableData> getById(int id) {
    return (select(salesTable)..where((tbl) => tbl.id.equals(id))).getSingle();
  }
}
