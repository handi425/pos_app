import '../entities/customer.dart';
import '../entities/report_summaries.dart';

abstract class CustomerRepository {
  Stream<List<Customer>> watchCustomers();
  Stream<List<CustomerDebtSummary>> watchCustomersWithDebt();
  Future<Customer> createCustomer(Customer customer);
  Future<void> updateCustomer(Customer customer);
  Future<void> deleteCustomer(int id);
}

