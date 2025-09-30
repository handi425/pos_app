import 'package:drift/drift.dart';

import '../pos_database.dart';
import '../tables.dart';

part 'users_dao.g.dart';

@DriftAccessor(tables: [UsersTable])
class UsersDao extends DatabaseAccessor<PosDatabase> with _$UsersDaoMixin {
  UsersDao(PosDatabase db) : super(db);

  Future<int> createUser(UsersTableCompanion data) {
    return into(usersTable).insert(data);
  }

  Future<void> updateUser(int id, UsersTableCompanion data) {
    return (update(usersTable)..where((tbl) => tbl.id.equals(id))).write(data);
  }

  Future<void> setActive(int id, bool isActive) {
    return (update(usersTable)..where((tbl) => tbl.id.equals(id))).write(
      UsersTableCompanion(isActive: Value(isActive)),
    );
  }

  Future<UsersTableData?> findByPinHash(String pinHash) {
    return (select(usersTable)
          ..where((tbl) => tbl.pinHash.equals(pinHash) & tbl.isActive.equals(true))
          ..limit(1))
        .getSingleOrNull();
  }

  Future<UsersTableData> getById(int id) {
    return (select(usersTable)..where((tbl) => tbl.id.equals(id))).getSingle();
  }

  Stream<List<UsersTableData>> watchAll() {
    return (select(usersTable)
          ..where((tbl) => tbl.isActive.equals(true))
          ..orderBy([(tbl) => OrderingTerm(expression: tbl.createdAt, mode: OrderingMode.desc)]))
        .watch();
  }

  Future<List<UsersTableData>> getActiveUsers() {
    return (select(usersTable)
          ..where((tbl) => tbl.isActive.equals(true))
          ..orderBy([(tbl) => OrderingTerm(expression: tbl.createdAt, mode: OrderingMode.desc)]))
        .get();
  }
}
