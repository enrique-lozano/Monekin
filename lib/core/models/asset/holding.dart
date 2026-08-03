import 'package:monekin/core/database/app_db.dart';
import 'package:monekin/core/models/asset/security_type.enum.dart';

/// A holding valued **as of a specific date** (time-aware): quantity, market
/// value and cost basis are reconstructed for that date. Monetary values are in
/// the security currency. Used by date-aware breakdowns (e.g. the portfolio
/// composition chart).
class HoldingValuationAtDate {
  final String accountId;
  final String securityId;
  final String securityName;
  final SecurityType securityType;
  final String currencyId;

  /// Market value at the date (`quantity × price`), in the security currency.
  final double market;

  /// Cost basis at the date (`quantity × avg cost`), in the security currency.
  final double cost;

  const HoldingValuationAtDate({
    required this.accountId,
    required this.securityId,
    required this.securityName,
    required this.securityType,
    required this.currencyId,
    required this.market,
    required this.cost,
  });
}

/// A single position inside a portfolio snapshot, joined with its security.
/// Monetary getters are expressed in the **security currency**.
class SnapshotPosition {
  final HoldingSnapshotInDB row;
  final SecurityInDB security;

  const SnapshotPosition({required this.row, required this.security});

  double get quantity => row.quantity;

  double get avgCostPrice => row.avgCostPrice;

  /// Cost basis of this position: `quantity * avgCostPrice`.
  double get cost => quantity * avgCostPrice;
}

/// A portfolio snapshot (the complete state of an investment account's holdings
/// on a date) together with its positions. Used by accounts tracked in
/// [AccountTrackingMode.holdings].
class AccountSnapshotWithPositions {
  final AccountSnapshotInDB snapshot;
  final List<SnapshotPosition> positions;

  const AccountSnapshotWithPositions({
    required this.snapshot,
    required this.positions,
  });

  String get id => snapshot.id;

  DateTime get date => snapshot.date;

  int get positionsCount => positions.length;

  bool get isEmpty => positions.isEmpty;

  /// Sum of the positions' cost basis, in each security's own currency (raw
  /// sum; convert at the call site if the account mixes currencies).
  double get totalCost => positions.fold(0, (sum, p) => sum + p.cost);
}

/// A holding joined with its security, plus derived cost/market/P&L helpers.
///
/// All monetary getters are expressed in the **security currency**.
class HoldingWithSecurity {
  final HoldingInDB holding;
  final SecurityInDB security;

  const HoldingWithSecurity({required this.holding, required this.security});

  double get quantity => holding.quantity;

  double get currentPrice => security.currentPrice ?? 0;

  /// Current market value: `quantity * currentPrice`.
  double get marketValue => quantity * currentPrice;

  /// Total invested: `quantity * avgCostPrice`.
  double get costBasis => quantity * holding.avgCostPrice;

  /// Unrealized profit/loss: `marketValue - costBasis`.
  double get unrealizedPnl => marketValue - costBasis;

  /// Unrealized P&L as a fraction of the cost basis (e.g. `0.1` = +10%).
  double get unrealizedPnlPercent =>
      costBasis == 0 ? 0 : unrealizedPnl / costBasis;
}
