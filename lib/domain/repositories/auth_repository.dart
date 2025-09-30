import '../entities/app_user.dart';

abstract class AuthRepository {
  Future<bool> hasAnyUser();
  Future<AppUser?> authenticatePin(String pin);
  Future<AppUser> createUser({
    required String name,
    required String pin,
    AppUserRole role = AppUserRole.cashier,
  });
  Future<void> deactivateUser(int id);
  Stream<List<AppUser>> watchUsers();
}
