import '../../domain/entities/app_user.dart';
import '../../domain/entities/cash_ledger_entry.dart';
import '../../domain/entities/category.dart';
import '../../domain/entities/customer.dart';
import '../../domain/entities/debt.dart';
import '../../domain/entities/product.dart';
import '../../domain/entities/report_summaries.dart';
import '../../domain/entities/sale_item.dart';
import '../../domain/entities/store_settings.dart';
import '../../domain/entities/value_enums.dart' as domain;
import '../db/pos_database.dart';
import '../db/tables.dart' as db;

Category mapCategory(CategoriesTableData data) =>
    Category(id: data.id, name: data.name);

Product mapProduct(ProductsTableData data, {CategoriesTableData? category}) =>
    Product(
      id: data.id,
      categoryId: data.categoryId,
      name: data.name,
      sku: data.sku,
      barcode: data.barcode,
      price: data.price,
      cost: data.cost,
      stock: data.stock,
      lowStockThreshold: data.lowStockThreshold,
      isActive: data.isActive,
      categoryName: category?.name,
      createdAt: data.createdAt,
      updatedAt: data.updatedAt,
    );

Customer mapCustomer(CustomersTableData data) => Customer(
      id: data.id,
      name: data.name,
      phone: data.phone,
      notes: data.notes,
      createdAt: data.createdAt,
      updatedAt: data.updatedAt,
    );

AppUser mapUser(UsersTableData data) => AppUser(
      id: data.id,
      name: data.name,
      role: mapUserRole(data.role),
      isActive: data.isActive,
      createdAt: data.createdAt,
    );

domain.PaymentMethod mapPaymentMethod(db.PaymentMethod method) {
  switch (method) {
    case db.PaymentMethod.cash:
      return domain.PaymentMethod.cash;
    case db.PaymentMethod.transfer:
      return domain.PaymentMethod.transfer;
  }
}

db.PaymentMethod mapPaymentMethodToDb(domain.PaymentMethod method) {
  switch (method) {
    case domain.PaymentMethod.cash:
      return db.PaymentMethod.cash;
    case domain.PaymentMethod.transfer:
      return db.PaymentMethod.transfer;
  }
}

domain.DebtStatusView mapDebtStatus(db.DebtStatus status) {
  switch (status) {
    case db.DebtStatus.open:
      return domain.DebtStatusView.open;
    case db.DebtStatus.closed:
      return domain.DebtStatusView.closed;
  }
}

domain.DebtPaymentMethodView mapDebtPaymentMethod(
    db.DebtPaymentMethod method) {
  switch (method) {
    case db.DebtPaymentMethod.cash:
      return domain.DebtPaymentMethodView.cash;
    case db.DebtPaymentMethod.transfer:
      return domain.DebtPaymentMethodView.transfer;
  }
}

db.DebtPaymentMethod mapDebtPaymentMethodToDb(
    domain.DebtPaymentMethodView method) {
  switch (method) {
    case domain.DebtPaymentMethodView.cash:
      return db.DebtPaymentMethod.cash;
    case domain.DebtPaymentMethodView.transfer:
      return db.DebtPaymentMethod.transfer;
  }
}

domain.CashMovementType mapLedgerType(db.CashLedgerType type) {
  switch (type) {
    case db.CashLedgerType.inFlow:
      return domain.CashMovementType.inFlow;
    case db.CashLedgerType.outFlow:
      return domain.CashMovementType.outFlow;
  }
}

domain.CashReferenceType mapLedgerRefType(db.CashLedgerRefType type) {
  switch (type) {
    case db.CashLedgerRefType.sale:
      return domain.CashReferenceType.sale;
    case db.CashLedgerRefType.debtPayment:
      return domain.CashReferenceType.debtPayment;
    case db.CashLedgerRefType.adjustment:
      return domain.CashReferenceType.adjustment;
    case db.CashLedgerRefType.purchase:
      return domain.CashReferenceType.purchase;
  }
}

StoreSettings mapStoreSettings(StoreSettingsTableData data) => StoreSettings(
      id: data.id,
      storeName: data.storeName,
      address: data.address,
      phone: data.phone,
      defaultTax: data.defaultTax,
      printerName: data.printerName,
      darkMode: data.darkMode,
      updatedAt: data.updatedAt,
    );

AppUserRole mapUserRole(db.UserRole role) {
  switch (role) {
    case db.UserRole.admin:
      return AppUserRole.admin;
    case db.UserRole.cashier:
      return AppUserRole.cashier;
  }
}

db.UserRole mapUserRoleToDb(AppUserRole role) {
  switch (role) {
    case AppUserRole.admin:
      return db.UserRole.admin;
    case AppUserRole.cashier:
      return db.UserRole.cashier;
  }
}

CashLedgerEntry mapLedgerEntry(CashLedgerTableData data, {UsersTableData? user}) =>
    CashLedgerEntry(
      id: data.id,
      type: mapLedgerType(data.type),
      amount: data.amount,
      refType: mapLedgerRefType(data.refType),
      refId: data.refId,
      note: data.note,
      datetime: data.datetime,
      user: user != null ? mapUser(user) : null,
    );

SaleItem mapSaleItem(SaleItemsTableData data, {ProductsTableData? product}) =>
    SaleItem(
      id: data.id,
      saleId: data.saleId,
      productId: data.productId,
      productName: product?.name ?? '',
      quantity: data.qty,
      price: data.price,
      discount: data.discount,
      total: data.total,
    );

Debt mapDebt(DebtsTableData data, Customer customer) => Debt(
      id: data.id,
      saleId: data.saleId,
      customer: customer,
      principal: data.principal,
      remaining: data.remaining,
      status: mapDebtStatus(data.status),
      createdAt: data.createdAt,
    );

DebtPayment mapDebtPayment(DebtPaymentsTableData data, {UsersTableData? user}) =>
    DebtPayment(
      id: data.id,
      debtId: data.debtId,
      amount: data.amount,
      method: mapDebtPaymentMethod(data.method),
      datetime: data.datetime,
      user: user != null ? mapUser(user) : null,
      note: data.note,
    );

DashboardSummary mapDashboardSummary(
  int totalSales,
  int transactions,
  int cashIn,
  int cashOut,
  int outstanding,
  int lowStock,
) =>
    DashboardSummary(
      totalSalesToday: totalSales,
      transactionsToday: transactions,
      cashInToday: cashIn,
      cashOutToday: cashOut,
      outstandingDebt: outstanding,
      lowStockCount: lowStock,
    );





