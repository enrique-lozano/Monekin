import 'package:monekin/core/database/services/account/investment_service.dart';

/// Calendar-day comparison (ignores time-of-day).
bool isTradeDateAfterCalendarDay(DateTime candidate, DateTime reference) {
  final c = DateTime(candidate.year, candidate.month, candidate.day);
  final r = DateTime(reference.year, reference.month, reference.day);
  return c.isAfter(r);
}

/// When editing a trade, optionally shift all valuations strictly after [tradeDate]
/// so portfolio history stays consistent with the new signed cash flow.
Future<void> shiftFollowingValuationsForTradeEdit({
  required String assetId,
  required DateTime tradeDate,
  required double previousSignedValue,
  required double newSignedValue,
  required bool applyShift,
}) async {
  if (!applyShift) return;

  final delta = -(newSignedValue - previousSignedValue);

  final valuations = await InvestmentService.instance
      .getValuationsForAsset(assetId)
      .first;

  final laterValuations = valuations
      .where((v) => isTradeDateAfterCalendarDay(v.date, tradeDate))
      .toList();

  if (laterValuations.isEmpty) return;

  await Future.wait(
    laterValuations.map(
      (valuation) => InvestmentService.instance.insertOrUpdateValuation(
        valuation.copyWith(value: valuation.value + delta),
      ),
    ),
  );
}
