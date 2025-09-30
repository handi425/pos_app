// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cash_ledger_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CashLedgerEntryImpl _$$CashLedgerEntryImplFromJson(
  Map<String, dynamic> json,
) => _$CashLedgerEntryImpl(
  id: (json['id'] as num).toInt(),
  type: $enumDecode(_$CashMovementTypeEnumMap, json['type']),
  amount: (json['amount'] as num).toInt(),
  refType: $enumDecode(_$CashReferenceTypeEnumMap, json['refType']),
  refId: (json['refId'] as num?)?.toInt(),
  note: json['note'] as String?,
  datetime: DateTime.parse(json['datetime'] as String),
  user: json['user'] == null
      ? null
      : AppUser.fromJson(json['user'] as Map<String, dynamic>),
);

Map<String, dynamic> _$$CashLedgerEntryImplToJson(
  _$CashLedgerEntryImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'type': _$CashMovementTypeEnumMap[instance.type]!,
  'amount': instance.amount,
  'refType': _$CashReferenceTypeEnumMap[instance.refType]!,
  'refId': instance.refId,
  'note': instance.note,
  'datetime': instance.datetime.toIso8601String(),
  'user': instance.user,
};

const _$CashMovementTypeEnumMap = {
  CashMovementType.inFlow: 'inFlow',
  CashMovementType.outFlow: 'outFlow',
};

const _$CashReferenceTypeEnumMap = {
  CashReferenceType.sale: 'sale',
  CashReferenceType.debtPayment: 'debtPayment',
  CashReferenceType.adjustment: 'adjustment',
  CashReferenceType.purchase: 'purchase',
};
