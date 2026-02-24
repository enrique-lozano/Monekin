import 'package:monekin/core/database/app_db.dart';

class Debt extends DebtInDB {
  final CurrencyInDB currency;

  Debt({
    required super.id,
    required super.name,
    required super.startDate,
    required this.currency,
    required super.iconId,
    required super.initialAmount,
    required super.type,
    super.endDate,
  }) : super(currencyId: currency.code);
}
