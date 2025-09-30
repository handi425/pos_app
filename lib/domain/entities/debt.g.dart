// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'debt.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DebtImpl _$$DebtImplFromJson(Map<String, dynamic> json) => _$DebtImpl(
  id: (json['id'] as num).toInt(),
  saleId: (json['saleId'] as num).toInt(),
  customer: Customer.fromJson(json['customer'] as Map<String, dynamic>),
  principal: (json['principal'] as num).toInt(),
  remaining: (json['remaining'] as num).toInt(),
  status: $enumDecode(_$DebtStatusViewEnumMap, json['status']),
  createdAt: DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$$DebtImplToJson(_$DebtImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'saleId': instance.saleId,
      'customer': instance.customer,
      'principal': instance.principal,
      'remaining': instance.remaining,
      'status': _$DebtStatusViewEnumMap[instance.status]!,
      'createdAt': instance.createdAt.toIso8601String(),
    };

const _$DebtStatusViewEnumMap = {
  DebtStatusView.open: 'open',
  DebtStatusView.closed: 'closed',
};

_$DebtPaymentImpl _$$DebtPaymentImplFromJson(Map<String, dynamic> json) =>
    _$DebtPaymentImpl(
      id: (json['id'] as num).toInt(),
      debtId: (json['debtId'] as num).toInt(),
      amount: (json['amount'] as num).toInt(),
      method: $enumDecode(_$DebtPaymentMethodViewEnumMap, json['method']),
      datetime: DateTime.parse(json['datetime'] as String),
      user: json['user'] == null
          ? null
          : AppUser.fromJson(json['user'] as Map<String, dynamic>),
      note: json['note'] as String?,
    );

Map<String, dynamic> _$$DebtPaymentImplToJson(_$DebtPaymentImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'debtId': instance.debtId,
      'amount': instance.amount,
      'method': _$DebtPaymentMethodViewEnumMap[instance.method]!,
      'datetime': instance.datetime.toIso8601String(),
      'user': instance.user,
      'note': instance.note,
    };

const _$DebtPaymentMethodViewEnumMap = {
  DebtPaymentMethodView.cash: 'cash',
  DebtPaymentMethodView.transfer: 'transfer',
};
