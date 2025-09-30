// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProductImpl _$$ProductImplFromJson(Map<String, dynamic> json) =>
    _$ProductImpl(
      id: (json['id'] as num).toInt(),
      categoryId: (json['categoryId'] as num).toInt(),
      name: json['name'] as String,
      sku: json['sku'] as String,
      barcode: json['barcode'] as String?,
      price: (json['price'] as num).toInt(),
      cost: (json['cost'] as num).toInt(),
      stock: (json['stock'] as num).toDouble(),
      lowStockThreshold: (json['lowStockThreshold'] as num).toDouble(),
      isActive: json['isActive'] as bool,
      categoryName: json['categoryName'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$ProductImplToJson(_$ProductImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'categoryId': instance.categoryId,
      'name': instance.name,
      'sku': instance.sku,
      'barcode': instance.barcode,
      'price': instance.price,
      'cost': instance.cost,
      'stock': instance.stock,
      'lowStockThreshold': instance.lowStockThreshold,
      'isActive': instance.isActive,
      'categoryName': instance.categoryName,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
