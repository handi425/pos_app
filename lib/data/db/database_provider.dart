import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'pos_database.dart';

final posDatabaseProvider = Provider<PosDatabase>((ref) {
  final db = PosDatabase();
  ref.onDispose(db.close);
  return db;
});
