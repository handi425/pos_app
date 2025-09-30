import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/customer.dart';
import '../../domain/entities/report_summaries.dart';
import '../../domain/repositories/customer_repository.dart';
import '../db/database_provider.dart';
import '../db/pos_database.dart';
import 'mappers.dart';

class CustomerRepositoryImpl implements CustomerRepository {
  CustomerRepositoryImpl(this._db);

  final PosDatabase _db;

  @override
  Future<Customer> createCustomer(Customer customer) async {
    final id = await _db.customersDao.createCustomer(_toInsertCompanion(customer));
    return customer.copyWith(id: id);
  }

  @override
  Future<void> deleteCustomer(int id) => _db.customersDao.deleteCustomer(id);

  @override
  Future<void> updateCustomer(Customer customer) {
    return _db.customersDao.updateCustomer(customer.id, _toUpdateCompanion(customer));
  }

  @override
  Stream<List<Customer>> watchCustomers() {
    return _db.customersDao.watchAll().map((rows) => rows.map(mapCustomer).toList());
  }

  @override
  Stream<List<CustomerDebtSummary>> watchCustomersWithDebt() {
    return _db.customersDao.watchWithDebtSummary().map(
      (rows) => rows
          .map(
            (row) => CustomerDebtSummary(
              customer: mapCustomer(row.customer),
              totalRemaining: row.totalRemaining,
            ),
          )
          .toList(),
    );
  }

  CustomersTableCompanion _toInsertCompanion(Customer customer) {
    return CustomersTableCompanion.insert(
      name: customer.name,
      phone: Value(customer.phone),
      notes: Value(customer.notes),
    );
  }

  CustomersTableCompanion _toUpdateCompanion(Customer customer) {
    return CustomersTableCompanion(
      name: Value(customer.name),
      phone: Value(customer.phone),
      notes: Value(customer.notes),
      updatedAt: Value(DateTime.now()),
    );
  }
}

final customerRepositoryProvider = Provider<CustomerRepository>((ref) {
  final db = ref.watch(posDatabaseProvider);
  return CustomerRepositoryImpl(db);
});


