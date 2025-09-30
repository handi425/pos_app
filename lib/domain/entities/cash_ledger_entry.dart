import 'package:freezed_annotation/freezed_annotation.dart';

import 'app_user.dart';
import 'value_enums.dart';

part 'cash_ledger_entry.freezed.dart';
part 'cash_ledger_entry.g.dart';

@freezed
class CashLedgerEntry with _$CashLedgerEntry {
  const factory CashLedgerEntry({
    required int id,
    required CashMovementType type,
    required int amount,
    required CashReferenceType refType,
    int? refId,
    String? note,
    required DateTime datetime,
    AppUser? user,
  }) = _CashLedgerEntry;

  factory CashLedgerEntry.fromJson(Map<String, dynamic> json) =>
      _$CashLedgerEntryFromJson(json);
}
