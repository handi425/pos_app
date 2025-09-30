import 'package:freezed_annotation/freezed_annotation.dart';

part 'product.freezed.dart';
part 'product.g.dart';

@freezed
class Product with _$Product {
  const factory Product({
    required int id,
    required int categoryId,
    required String name,
    required String sku,
    String? barcode,
    required int price,
    required int cost,
    required double stock,
    required double lowStockThreshold,
    required bool isActive,
    String? categoryName,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _Product;

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);
}
