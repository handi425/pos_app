import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_user.freezed.dart';
part 'app_user.g.dart';

enum AppUserRole { admin, cashier }

@freezed
class AppUser with _$AppUser {
  const factory AppUser({
    required int id,
    required String name,
    required AppUserRole role,
    required bool isActive,
    DateTime? createdAt,
  }) = _AppUser;

  factory AppUser.fromJson(Map<String, dynamic> json) =>
      _$AppUserFromJson(json);
}
