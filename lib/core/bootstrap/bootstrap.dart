import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/db/database_provider.dart';
import '../../features/auth/application/auth_controller.dart';

final appBootstrapProvider = FutureProvider<void>((ref) async {
  ref.read(posDatabaseProvider);
  try {
    final authController = ref.read(authControllerProvider.notifier);
    await authController.loadInitialState();
  } catch (error, stackTrace) {
    debugPrint('Bootstrap error: $error');
    debugPrint('$stackTrace');
    rethrow;
  }
});
