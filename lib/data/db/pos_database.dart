import 'dart:async';
import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../../core/utils/pin_hasher.dart';
import 'daos/cash_ledger_dao.dart';
import 'daos/categories_dao.dart';
import 'daos/customers_dao.dart';
import 'daos/debts_dao.dart';
import 'daos/products_dao.dart';
import 'daos/reports_dao.dart';
import 'daos/sales_dao.dart';
import 'daos/settings_dao.dart';
import 'daos/users_dao.dart';
import 'tables.dart';

part 'pos_database.g.dart';

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File(p.join(directory.path, 'kaspos.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}

@DriftDatabase(
  tables: [
    CategoriesTable,
    ProductsTable,
    CustomersTable,
    UsersTable,
    SalesTable,
    SaleItemsTable,
    StockMovementsTable,
    DebtsTable,
    DebtPaymentsTable,
    CashLedgerTable,
    StoreSettingsTable,
  ],
  daos: [
    CategoriesDao,
    ProductsDao,
    CustomersDao,
    UsersDao,
    SalesDao,
    DebtsDao,
    CashLedgerDao,
    ReportsDao,
    SettingsDao,
  ],
)
class PosDatabase extends _$PosDatabase {
  PosDatabase({QueryExecutor? executor}) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (Migrator m) async {
      await m.createAll();
      await _seedInitialData();
    },
    onUpgrade: (Migrator m, int from, int to) async {
      // Reserved for future schema upgrades.
    },
  );

  Future<void> _seedInitialData() async {
    await into(storeSettingsTable).insert(
      StoreSettingsTableCompanion.insert(
        storeName: const Value('KasPOS Demo'),
        address: const Value('Jl. Contoh No.123, Jakarta'),
        phone: const Value('081234567890'),
        defaultTax: const Value(0),
      ),
      mode: InsertMode.insertOrIgnore,
    );

    final hasCategory = await (select(
      categoriesTable,
    )..limit(1)).get().then((value) => value.isNotEmpty);
    if (!hasCategory) {
      await batch((batch) {
        batch.insertAll(categoriesTable, [
          CategoriesTableCompanion.insert(name: 'Umum'),
          CategoriesTableCompanion.insert(name: 'Makanan & Minuman'),
          CategoriesTableCompanion.insert(name: 'Rumah Tangga'),
        ]);
      });
    }

    final hasAdmin = await (select(
      usersTable,
    )..limit(1)).get().then((value) => value.isNotEmpty);
    int adminId;
    if (!hasAdmin) {
      adminId = await into(usersTable).insert(
        UsersTableCompanion.insert(
          name: 'Admin',
          role: UserRole.admin,
          pinHash: PinHasher.hash('1234'),
        ),
      );
    } else {
      adminId = (await (select(usersTable)..limit(1)).getSingle()).id;
    }

    final categories = await select(categoriesTable).get();

    final hasProducts = await (select(
      productsTable,
    )..limit(1)).get().then((value) => value.isNotEmpty);
    if (!hasProducts && categories.isNotEmpty) {
      final umumId = categories
          .firstWhere((element) => element.name == 'Umum')
          .id;
      final makananId = categories
          .firstWhere((element) => element.name.contains('Makanan'))
          .id;

      await batch((batch) {
        batch.insertAll(productsTable, [
          ProductsTableCompanion.insert(
            categoryId: umumId,
            name: 'Kopi Bubuk Premium 250gr',
            sku: 'SKU-KOPI-001',
            barcode: const Value('8991234001'),
            price: const Value(28000),
            cost: const Value(18000),
            stock: const Value(48),
            lowStockThreshold: const Value(12),
            isActive: const Value(true),
          ),
          ProductsTableCompanion.insert(
            categoryId: makananId,
            name: 'Roti Tawar Susu',
            sku: 'SKU-ROTI-002',
            barcode: const Value('8991234002'),
            price: const Value(15000),
            cost: const Value(9000),
            stock: const Value(36),
            lowStockThreshold: const Value(10),
            isActive: const Value(true),
          ),
          ProductsTableCompanion.insert(
            categoryId: makananId,
            name: 'Air Mineral 600ml',
            sku: 'SKU-AIR-003',
            barcode: const Value('8991234003'),
            price: const Value(6000),
            cost: const Value(3000),
            stock: const Value(80),
            lowStockThreshold: const Value(20),
            isActive: const Value(true),
          ),
        ]);
      });
    }

    final hasCustomers = await (select(
      customersTable,
    )..limit(1)).get().then((value) => value.isNotEmpty);
    if (!hasCustomers) {
      await batch((batch) {
        batch.insertAll(customersTable, [
          CustomersTableCompanion.insert(
            name: 'Budi Santoso',
            phone: const Value('081234567801'),
            notes: const Value('Langganan warung kopi'),
          ),
          CustomersTableCompanion.insert(
            name: 'Siti Rahma',
            phone: const Value('081234567802'),
            notes: const Value('Sering pesan lewat WA'),
          ),
          CustomersTableCompanion.insert(
            name: 'Andi Wijaya',
            phone: const Value('081234567803'),
            notes: const Value('Pembayaran tempo 7 hari'),
          ),
        ]);
      });
    }

    final hasSales = await (select(
      salesTable,
    )..limit(1)).get().then((value) => value.isNotEmpty);
    if (!hasSales) {
      final products = await select(productsTable).get();
      final customers = await select(customersTable).get();
      if (products.isNotEmpty && customers.isNotEmpty) {
        final now = DateTime.now();
        for (var i = 0; i < 3; i++) {
          final product = products[i % products.length];
          final customer = customers[i % customers.length];
          final quantity = (i + 1).toDouble();
          final discountValue = i == 1 ? 2000 : 0;
          final subtotal = (product.price * quantity).round();
          final total = subtotal - discountValue;
          final paid = i == 2 ? total - 15000 : total;
          final isCredit = paid < total;
          final change = !isCredit && paid > total ? paid - total : 0;

          final saleCompanion = SalesTableCompanion.insert(
            datetime: now.subtract(Duration(days: 2 - i)),
            customerId: Value(customer.id),
            userId: adminId,
            subtotal: subtotal,
            discount: Value(discountValue),
            tax: const Value(0),
            total: total,
            paid: Value(paid),
            change: Value(change),
            paymentMethod: PaymentMethod.cash,
            isCredit: Value(isCredit),
            notes: Value('Transaksi contoh ${i + 1}'),
          );

          await salesDao.createSale(
            sale: saleCompanion,
            items: [
              SaleItemInput(
                productId: product.id,
                qty: quantity,
                price: product.price,
                discount: discountValue,
                total: total,
              ),
            ],
            userId: adminId,
          );
        }
      }
    }
  }
}
