import 'package:freezed_annotation/freezed_annotation.dart';

part 'store_settings.freezed.dart';
part 'store_settings.g.dart';

@freezed
class StoreSettings with _$StoreSettings {
  const factory StoreSettings({
    required int id,
    required String storeName,
    required String address,
    required String phone,
    required int defaultTax,
    String? printerName,
    required bool darkMode,
    DateTime? updatedAt,
  }) = _StoreSettings;

  factory StoreSettings.fromJson(Map<String, dynamic> json) =>
      _$StoreSettingsFromJson(json);
}
