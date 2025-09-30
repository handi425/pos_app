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
    if (!hasAdmin) {
      await into(usersTable).insert(
        UsersTableCompanion.insert(
          name: 'Admin',
          role: UserRole.admin,
          pinHash: PinHasher.hash('1234'),
        ),
      );
    }
  }
}
