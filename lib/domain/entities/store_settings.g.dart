// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StoreSettingsImpl _$$StoreSettingsImplFromJson(Map<String, dynamic> json) =>
    _$StoreSettingsImpl(
      id: (json['id'] as num).toInt(),
      storeName: json['storeName'] as String,
      address: json['address'] as String,
      phone: json['phone'] as String,
      defaultTax: (json['defaultTax'] as num).toInt(),
      printerName: json['printerName'] as String?,
      darkMode: json['darkMode'] as bool,
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$StoreSettingsImplToJson(_$StoreSettingsImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'storeName': instance.storeName,
      'address': instance.address,
      'phone': instance.phone,
      'defaultTax': instance.defaultTax,
      'printerName': instance.printerName,
      'darkMode': instance.darkMode,
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
