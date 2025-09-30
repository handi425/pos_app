// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_summaries.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DashboardSummaryImpl _$$DashboardSummaryImplFromJson(
  Map<String, dynamic> json,
) => _$DashboardSummaryImpl(
  totalSalesToday: (json['totalSalesToday'] as num).toInt(),
  transactionsToday: (json['transactionsToday'] as num).toInt(),
  cashInToday: (json['cashInToday'] as num).toInt(),
  cashOutToday: (json['cashOutToday'] as num).toInt(),
  outstandingDebt: (json['outstandingDebt'] as num).toInt(),
  lowStockCount: (json['lowStockCount'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$$DashboardSummaryImplToJson(
  _$DashboardSummaryImpl instance,
) => <String, dynamic>{
  'totalSalesToday': instance.totalSalesToday,
  'transactionsToday': instance.transactionsToday,
  'cashInToday': instance.cashInToday,
  'cashOutToday': instance.cashOutToday,
  'outstandingDebt': instance.outstandingDebt,
  'lowStockCount': instance.lowStockCount,
};

_$SalesReportAggregateImpl _$$SalesReportAggregateImplFromJson(
  Map<String, dynamic> json,
) => _$SalesReportAggregateImpl(
  totalAmount: (json['totalAmount'] as num).toInt(),
  totalDiscount: (json['totalDiscount'] as num).toInt(),
  totalTax: (json['totalTax'] as num).toInt(),
  totalQuantity: (json['totalQuantity'] as num).toDouble(),
);

Map<String, dynamic> _$$SalesReportAggregateImplToJson(
  _$SalesReportAggregateImpl instance,
) => <String, dynamic>{
  'totalAmount': instance.totalAmount,
  'totalDiscount': instance.totalDiscount,
  'totalTax': instance.totalTax,
  'totalQuantity': instance.totalQuantity,
};

_$DailySalesReportImpl _$$DailySalesReportImplFromJson(
  Map<String, dynamic> json,
) => _$DailySalesReportImpl(
  date: DateTime.parse(json['date'] as String),
  totalAmount: (json['totalAmount'] as num).toInt(),
  totalDiscount: (json['totalDiscount'] as num).toInt(),
  totalQuantity: (json['totalQuantity'] as num).toDouble(),
);

Map<String, dynamic> _$$DailySalesReportImplToJson(
  _$DailySalesReportImpl instance,
) => <String, dynamic>{
  'date': instance.date.toIso8601String(),
  'totalAmount': instance.totalAmount,
  'totalDiscount': instance.totalDiscount,
  'totalQuantity': instance.totalQuantity,
};

_$CashFlowAggregateImpl _$$CashFlowAggregateImplFromJson(
  Map<String, dynamic> json,
) => _$CashFlowAggregateImpl(
  cashIn: (json['cashIn'] as num).toInt(),
  cashOut: (json['cashOut'] as num).toInt(),
);

Map<String, dynamic> _$$CashFlowAggregateImplToJson(
  _$CashFlowAggregateImpl instance,
) => <String, dynamic>{'cashIn': instance.cashIn, 'cashOut': instance.cashOut};

_$DebtReportAggregateImpl _$$DebtReportAggregateImplFromJson(
  Map<String, dynamic> json,
) => _$DebtReportAggregateImpl(
  newDebts: (json['newDebts'] as num).toInt(),
  payments: (json['payments'] as num).toInt(),
);

Map<String, dynamic> _$$DebtReportAggregateImplToJson(
  _$DebtReportAggregateImpl instance,
) => <String, dynamic>{
  'newDebts': instance.newDebts,
  'payments': instance.payments,
};

_$CustomerDebtSummaryImpl _$$CustomerDebtSummaryImplFromJson(
  Map<String, dynamic> json,
) => _$CustomerDebtSummaryImpl(
  customer: Customer.fromJson(json['customer'] as Map<String, dynamic>),
  totalRemaining: (json['totalRemaining'] as num).toInt(),
);

Map<String, dynamic> _$$CustomerDebtSummaryImplToJson(
  _$CustomerDebtSummaryImpl instance,
) => <String, dynamic>{
  'customer': instance.customer,
  'totalRemaining': instance.totalRemaining,
};

_$LowStockAlertImpl _$$LowStockAlertImplFromJson(Map<String, dynamic> json) =>
    _$LowStockAlertImpl(
      product: Product.fromJson(json['product'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$LowStockAlertImplToJson(_$LowStockAlertImpl instance) =>
    <String, dynamic>{'product': instance.product};
