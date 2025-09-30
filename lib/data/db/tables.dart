import 'package:drift/drift.dart';

enum PaymentMethod { cash, transfer }

enum StockMovementType { inAdjustment, outSale, adjust }

enum DebtStatus { open, closed }

enum CashLedgerType { inFlow, outFlow }

enum CashLedgerRefType { sale, debtPayment, adjustment, purchase }

enum UserRole { admin, cashier }

enum DebtPaymentMethod { cash, transfer }

enum StockMovementSource { sale, manual, purchase, adjustment }

class CategoriesTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name =>
      text().withLength(min: 1, max: 120).customConstraint('UNIQUE NOT NULL')();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}

class ProductsTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get categoryId =>
      integer().references(CategoriesTable, #id, onDelete: KeyAction.cascade)();
  TextColumn get name => text().withLength(min: 1, max: 200)();
  TextColumn get sku =>
      text().withLength(min: 1, max: 64).customConstraint('UNIQUE NOT NULL')();
  TextColumn get barcode => text().withLength(min: 0, max: 128).nullable()();
  IntColumn get price => integer().withDefault(const Constant(0))();
  IntColumn get cost => integer().withDefault(const Constant(0))();
  RealColumn get stock => real().withDefault(const Constant(0))();
  RealColumn get lowStockThreshold => real().withDefault(const Constant(0))();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}

class CustomersTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 200)();
  TextColumn get phone => text().withLength(min: 0, max: 32).nullable()();
  TextColumn get notes => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}

class UsersTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 120)();
  IntColumn get role => intEnum<UserRole>()();
  TextColumn get pinHash => text().withLength(min: 1, max: 256)();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
}

class SalesTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get datetime => dateTime()();
  IntColumn get customerId => integer().nullable().references(
    CustomersTable,
    #id,
    onDelete: KeyAction.setNull,
  )();
  IntColumn get userId => integer().references(UsersTable, #id)();
  IntColumn get subtotal => integer()();
  IntColumn get discount => integer().withDefault(const Constant(0))();
  IntColumn get tax => integer().withDefault(const Constant(0))();
  IntColumn get total => integer()();
  IntColumn get paid => integer().withDefault(const Constant(0))();
  IntColumn get change => integer().withDefault(const Constant(0))();
  IntColumn get paymentMethod => intEnum<PaymentMethod>()();
  BoolColumn get isCredit => boolean().withDefault(const Constant(false))();
  TextColumn get notes => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

class SaleItemsTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get saleId =>
      integer().references(SalesTable, #id, onDelete: KeyAction.cascade)();
  IntColumn get productId => integer().references(ProductsTable, #id)();
  RealColumn get qty => real()();
  IntColumn get price => integer()();
  IntColumn get discount => integer().withDefault(const Constant(0))();
  IntColumn get total => integer()();
}

class StockMovementsTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get productId => integer().references(ProductsTable, #id)();
  IntColumn get userId => integer().references(UsersTable, #id)();
  IntColumn get type => intEnum<StockMovementType>()();
  RealColumn get qty => real()();
  TextColumn get note => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  IntColumn get source => intEnum<StockMovementSource>()();
  IntColumn get referenceId => integer().nullable()();
}

class DebtsTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get customerId => integer().references(CustomersTable, #id)();
  IntColumn get saleId =>
      integer().references(SalesTable, #id, onDelete: KeyAction.cascade)();
  IntColumn get principal => integer()();
  IntColumn get remaining => integer()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  IntColumn get status => intEnum<DebtStatus>()();
}

class DebtPaymentsTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get debtId =>
      integer().references(DebtsTable, #id, onDelete: KeyAction.cascade)();
  IntColumn get amount => integer()();
  IntColumn get method => intEnum<DebtPaymentMethod>()();
  DateTimeColumn get datetime => dateTime()();
  IntColumn get userId => integer().references(UsersTable, #id)();
  TextColumn get note => text().nullable()();
}

class CashLedgerTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get type => intEnum<CashLedgerType>()();
  IntColumn get amount => integer()();
  IntColumn get refType => intEnum<CashLedgerRefType>()();
  IntColumn get refId => integer().nullable()();
  TextColumn get note => text().nullable()();
  DateTimeColumn get datetime => dateTime()();
  IntColumn get userId => integer().references(UsersTable, #id)();
}

class StoreSettingsTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get storeName => text().withDefault(const Constant('Toko Saya'))();
  TextColumn get address => text().withDefault(const Constant(''))();
  TextColumn get phone => text().withDefault(const Constant(''))();
  IntColumn get defaultTax => integer().withDefault(const Constant(0))();
  TextColumn get printerName => text().nullable()();
  BoolColumn get darkMode => boolean().withDefault(const Constant(false))();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}
