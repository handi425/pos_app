import '../entities/store_settings.dart';

abstract class SettingsRepository {
  Stream<StoreSettings?> watchSettings();
  Future<StoreSettings> load();
  Future<void> save(StoreSettings settings);
}
