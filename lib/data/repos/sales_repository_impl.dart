import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/sale.dart';
import '../../domain/entities/sale_draft.dart';
import '../../domain/entities/sale_item.dart';
import '../../domain/repositories/sales_repository.dart';
import '../db/daos/sales_dao.dart';
import '../db/database_provider.dart';
import '../db/pos_database.dart';
import 'mappers.dart';

class SalesRepositoryImpl implements SalesRepository {
  SalesRepositoryImpl(this._db);

  final PosDatabase _db;

  @override
  Future<Sale> createSale({
    required SaleDraft draft,
    required int userId,
  }) async {
    final now = DateTime.now();
    final saleCompanion = SalesTableCompanion.insert(
      datetime: now,
      customerId: Value(draft.customer?.id),
      userId: userId,
      subtotal: draft.subtotal,
      discount: Value(draft.itemDiscountTotal + draft.transactionDiscount),
      tax: Value(draft.tax),
      total: draft.grandTotal,
      paid: Value(draft.paid),
      change: Value(draft.change),
      paymentMethod: mapPaymentMethodToDb(draft.paymentMethod),
      isCredit: Value(draft.asDebt || draft.paid < draft.grandTotal),
      notes: Value(draft.notes),
    );

    final itemInputs = draft.items.map(_mapCartItem).toList();

    final result = await _db.salesDao.createSale(
      sale: saleCompanion,
      items: itemInputs,
      userId: userId,
    );

    return _loadSaleById(result.saleId);
  }

  @override
  Future<List<Sale>> salesBetween(DateTime start, DateTime end) async {
    final rows = await (_db.select(
      _db.salesTable,
    )..where((tbl) => tbl.datetime.isBetweenValues(start, end))).get();
    final sales = <Sale>[];
    for (final row in rows) {
      sales.add(await _loadSaleById(row.id));
    }
    return sales;
  }

  @override
  Stream<List<Sale>> watchRecentSales({int limit = 20}) {
    return _db.salesDao.watchRecentSales(limit: limit).asyncMap((rows) async {
      final result = <Sale>[];
      for (final row in rows) {
        result.add(await _loadSaleById(row.id));
      }
      return result;
    });
  }

  @override
  Future<List<SaleItem>> itemsForSale(int saleId) async {
    final rows = await _db.salesDao.itemsForSale(saleId);
    final products = <int, ProductsTableData>{};
    final items = <SaleItem>[];
    for (final row in rows) {
      var product = products[row.productId];
      product ??= await _db.productsDao.getById(row.productId);
      products[row.productId] = product;
      items.add(mapSaleItem(row, product: product));
    }
    return items;
  }

  SaleItemInput _mapCartItem(CartItem item) {
    final lineBase = (item.price * item.quantity).round();
    final lineDiscount = item.discount.clamp(0, lineBase);
    final lineTotal = (lineBase - lineDiscount).clamp(0, lineBase);
    return SaleItemInput(
      productId: item.productId,
      qty: item.quantity,
      price: item.price,
      discount: lineDiscount,
      total: lineTotal,
    );
  }

  Future<Sale> _loadSaleById(int id) async {
    final saleRow = await _db.salesDao.getById(id);
    final customerData = saleRow.customerId != null
        ? await _db.customersDao.getById(saleRow.customerId!)
        : null;
    final userData = await _db.usersDao.getById(saleRow.userId);
    final itemRows = await _db.salesDao.itemsForSale(id);

    final productsCache = <int, ProductsTableData>{};
    final items = <SaleItem>[];
    for (final row in itemRows) {
      var product = productsCache[row.productId];
      product ??= await _db.productsDao.getById(row.productId);
      productsCache[row.productId] = product;
      items.add(mapSaleItem(row, product: product));
    }

    return Sale(
      id: saleRow.id,
      datetime: saleRow.datetime,
      customer: customerData != null ? mapCustomer(customerData) : null,
      user: mapUser(userData),
      subtotal: saleRow.subtotal,
      discount: saleRow.discount,
      tax: saleRow.tax,
      total: saleRow.total,
      paid: saleRow.paid,
      change: saleRow.change,
      paymentMethod: mapPaymentMethod(saleRow.paymentMethod),
      isCredit: saleRow.isCredit,
      notes: saleRow.notes,
      items: items,
    );
  }
}

final salesRepositoryProvider = Provider<SalesRepository>((ref) {
  final db = ref.watch(posDatabaseProvider);
  return SalesRepositoryImpl(db);
});
