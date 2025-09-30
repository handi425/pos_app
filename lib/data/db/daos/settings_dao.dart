import 'package:drift/drift.dart';

import '../pos_database.dart';
import '../tables.dart';

part 'settings_dao.g.dart';

@DriftAccessor(tables: [StoreSettingsTable])
class SettingsDao extends DatabaseAccessor<PosDatabase>
    with _$SettingsDaoMixin {
  SettingsDao(PosDatabase db) : super(db);

  Future<StoreSettingsTableData?> load() {
    return (select(storeSettingsTable)..limit(1)).getSingleOrNull();
  }

  Future<void> upsert(StoreSettingsTableCompanion data) async {
    final current = await load();
    if (current == null) {
      await into(storeSettingsTable).insert(data);
    } else {
      await (update(storeSettingsTable)..where((tbl) => tbl.id.equals(current.id))).write(data);
    }
  }

  Stream<StoreSettingsTableData?> watchSettings() {
    return select(storeSettingsTable).watchSingleOrNull();
  }
}
