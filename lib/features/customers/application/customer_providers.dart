import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/repos/customer_repository_impl.dart';
import '../../../domain/entities/customer.dart';
import '../../../domain/entities/report_summaries.dart';

final customersProvider = StreamProvider<List<Customer>>((ref) {
  final repo = ref.watch(customerRepositoryProvider);
  return repo.watchCustomers();
});

final customerDebtSummariesProvider = StreamProvider<List<CustomerDebtSummary>>(
  (ref) {
    final repo = ref.watch(customerRepositoryProvider);
    return repo.watchCustomersWithDebt();
  },
);
