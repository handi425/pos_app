import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/utils/pin_hasher.dart';
import '../../domain/entities/app_user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../db/database_provider.dart';
import '../db/pos_database.dart';
import 'mappers.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._db);

  final PosDatabase _db;

  @override
  Future<AppUser?> authenticatePin(String pin) async {
    final hashed = PinHasher.hash(pin);
    final user = await _db.usersDao.findByPinHash(hashed);
    if (user == null) {
      return null;
    }
    return mapUser(user);
  }

  @override
  Future<AppUser> createUser({
    required String name,
    required String pin,
    AppUserRole role = AppUserRole.cashier,
  }) async {
    final hashed = PinHasher.hash(pin);
    final id = await _db.usersDao.createUser(
      UsersTableCompanion.insert(
        name: name,
        role: mapUserRoleToDb(role),
        pinHash: hashed,
      ),
    );
    final created = await _db.usersDao.getById(id);
    return mapUser(created);
  }

  @override
  Future<void> deactivateUser(int id) => _db.usersDao.setActive(id, false);

  @override
  Future<bool> hasAnyUser() async {
    final users = await _db.usersDao.getActiveUsers();
    return users.isNotEmpty;
  }

  @override
  Stream<List<AppUser>> watchUsers() {
    return _db.usersDao.watchAll().map((rows) => rows.map(mapUser).toList());
  }
}

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final db = ref.watch(posDatabaseProvider);
  return AuthRepositoryImpl(db);
});
