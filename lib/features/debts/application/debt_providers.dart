import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/repos/debt_repository_impl.dart';
import '../../../domain/entities/debt.dart';

final debtsProvider = StreamProvider<List<Debt>>((ref) {
  final repo = ref.watch(debtRepositoryProvider);
  return repo.watchOpenDebts();
});
