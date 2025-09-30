// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sale.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SaleImpl _$$SaleImplFromJson(Map<String, dynamic> json) => _$SaleImpl(
  id: (json['id'] as num).toInt(),
  datetime: DateTime.parse(json['datetime'] as String),
  customer: json['customer'] == null
      ? null
      : Customer.fromJson(json['customer'] as Map<String, dynamic>),
  user: json['user'] == null
      ? null
      : AppUser.fromJson(json['user'] as Map<String, dynamic>),
  subtotal: (json['subtotal'] as num).toInt(),
  discount: (json['discount'] as num).toInt(),
  tax: (json['tax'] as num).toInt(),
  total: (json['total'] as num).toInt(),
  paid: (json['paid'] as num).toInt(),
  change: (json['change'] as num).toInt(),
  paymentMethod: $enumDecode(_$PaymentMethodEnumMap, json['paymentMethod']),
  isCredit: json['isCredit'] as bool,
  items:
      (json['items'] as List<dynamic>?)
          ?.map((e) => SaleItem.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <SaleItem>[],
  notes: json['notes'] as String?,
);

Map<String, dynamic> _$$SaleImplToJson(_$SaleImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'datetime': instance.datetime.toIso8601String(),
      'customer': instance.customer,
      'user': instance.user,
      'subtotal': instance.subtotal,
      'discount': instance.discount,
      'tax': instance.tax,
      'total': instance.total,
      'paid': instance.paid,
      'change': instance.change,
      'paymentMethod': _$PaymentMethodEnumMap[instance.paymentMethod]!,
      'isCredit': instance.isCredit,
      'items': instance.items,
      'notes': instance.notes,
    };

const _$PaymentMethodEnumMap = {
  PaymentMethod.cash: 'cash',
  PaymentMethod.transfer: 'transfer',
};
