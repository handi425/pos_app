import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/store_settings.dart';
import '../../domain/repositories/settings_repository.dart';
import '../db/database_provider.dart';
import '../db/pos_database.dart';
import 'mappers.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  SettingsRepositoryImpl(this._db);

  final PosDatabase _db;

  @override
  Future<StoreSettings> load() async {
    final data = await _db.settingsDao.load();
    if (data != null) {
      return mapStoreSettings(data);
    }
    final defaultSettings = StoreSettings(
      id: 0,
      storeName: 'Toko Saya',
      address: '',
      phone: '',
      defaultTax: 0,
      printerName: null,
      darkMode: false,
    );
    await save(defaultSettings);
    final inserted = await _db.settingsDao.load();
    return mapStoreSettings(inserted!);
  }

  @override
  Future<void> save(StoreSettings settings) {
    final companion = StoreSettingsTableCompanion(
      id: settings.id == 0 ? const Value.absent() : Value(settings.id),
      storeName: Value(settings.storeName),
      address: Value(settings.address),
      phone: Value(settings.phone),
      defaultTax: Value(settings.defaultTax),
      printerName: Value(settings.printerName),
      darkMode: Value(settings.darkMode),
      updatedAt: Value(DateTime.now()),
    );
    return _db.settingsDao.upsert(companion);
  }

  @override
  Stream<StoreSettings?> watchSettings() {
    return _db.settingsDao
        .watchSettings()
        .map((data) => data != null ? mapStoreSettings(data) : null);
  }
}

final settingsRepositoryProvider = Provider<SettingsRepository>((ref) {
  final db = ref.watch(posDatabaseProvider);
  return SettingsRepositoryImpl(db);
});


