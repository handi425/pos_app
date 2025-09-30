import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/utils/pin_hasher.dart';
import '../../../data/db/database_provider.dart';
import '../../../data/db/pos_database.dart';
import '../../../data/db/tables.dart';

final authControllerProvider =
    StateNotifierProvider<AuthController, AuthState>((ref) {
  return AuthController(ref);
});

enum AuthStatus { unknown, onboardingRequired, unauthenticated, authenticated }

class AuthState {
  const AuthState({
    required this.status,
    this.activeUserId,
    this.activeUserName,
    this.hasUsers = false,
  });

  final AuthStatus status;
  final int? activeUserId;
  final String? activeUserName;
  final bool hasUsers;

  AuthState copyWith({
    AuthStatus? status,
    int? activeUserId,
    String? activeUserName,
    bool? hasUsers,
  }) {
    return AuthState(
      status: status ?? this.status,
      activeUserId: activeUserId ?? this.activeUserId,
      activeUserName: activeUserName ?? this.activeUserName,
      hasUsers: hasUsers ?? this.hasUsers,
    );
  }

  static AuthState unknown() => const AuthState(status: AuthStatus.unknown);
}

class AuthController extends StateNotifier<AuthState> {
  AuthController(this._ref) : super(AuthState.unknown());

  final Ref _ref;

  PosDatabase get _db => _ref.read(posDatabaseProvider);

  Future<void> loadInitialState() async {
    final users = await _db.usersDao.getActiveUsers();
    if (users.isEmpty) {
      state = const AuthState(status: AuthStatus.onboardingRequired, hasUsers: false);
    } else {
      state = const AuthState(status: AuthStatus.unauthenticated, hasUsers: true);
    }
  }

  Future<void> completeOnboarding({
    required String name,
    required String pin,
    UserRole role = UserRole.admin,
  }) async {
    final hashed = PinHasher.hash(pin);
    await _db.usersDao.createUser(
      UsersTableCompanion.insert(
        name: name,
        role: role,
        pinHash: hashed,
      ),
    );
    state = const AuthState(status: AuthStatus.unauthenticated, hasUsers: true);
  }

  Future<bool> loginWithPin(String pin) async {
    final hashed = PinHasher.hash(pin);
    final user = await _db.usersDao.findByPinHash(hashed);
    if (user == null) {
      return false;
    }
    state = AuthState(
      status: AuthStatus.authenticated,
      activeUserId: user.id,
      activeUserName: user.name,
      hasUsers: true,
    );
    return true;
  }

  void logout() {
    state = state.copyWith(
      status: AuthStatus.unauthenticated,
      activeUserId: null,
      activeUserName: null,
    );
  }
}
