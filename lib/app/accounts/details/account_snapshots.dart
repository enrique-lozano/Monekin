import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:monekin/app/accounts/account_selector.dart';
import 'package:monekin/app/accounts/details/holdings_card.dart'
    show showSecurityPicker;
import 'package:monekin/app/layout/page_framework.dart';
import 'package:monekin/app/securities/widgets/security_avatar.dart';
import 'package:monekin/core/database/app_db.dart';
import 'package:monekin/core/database/services/account/account_service.dart';
import 'package:monekin/core/database/services/account/holding_service.dart';
import 'package:monekin/core/extensions/numbers.extensions.dart';
import 'package:monekin/core/models/account/account.dart';
import 'package:monekin/core/models/asset/holding.dart';
import 'package:monekin/core/presentation/responsive/breakpoints.dart';
import 'package:monekin/core/presentation/styles/button_styles.dart';
import 'package:monekin/core/presentation/widgets/confirm_dialog.dart';
import 'package:monekin/core/presentation/widgets/form_fields/date_field.dart';
import 'package:monekin/core/presentation/widgets/form_fields/date_form_field.dart';
import 'package:monekin/core/presentation/widgets/form_fields/list_tile_field.dart';
import 'package:monekin/core/presentation/widgets/inline_info_card.dart';
import 'package:monekin/core/presentation/widgets/no_results.dart';
import 'package:monekin/core/presentation/widgets/number_ui_formatters/currency_displayer.dart';
import 'package:monekin/core/presentation/widgets/persistent_footer_button.dart';
import 'package:monekin/core/presentation/widgets/trailing_value.dart';
import 'package:monekin/core/routes/route_utils.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

/// Plain, locale-agnostic string for a number editable in a text field
/// (e.g. `1`, `204`, `98.5`), stripping a trailing `.0`.
String _plainNumber(double value) {
  return value == value.roundToDouble()
      ? value.toInt().toString()
      : value.toString();
}

// ---------------------------------------------------------------------------
// Snapshot history page
// ---------------------------------------------------------------------------

/// Lists every portfolio snapshot of an investment account (newest first),
/// marking the one currently in effect. Snapshots can be added, edited or
/// deleted. A snapshot is the complete portfolio photo for a date.
class AccountSnapshotsPage extends StatefulWidget {
  const AccountSnapshotsPage({super.key, required this.account});

  final Account account;

  @override
  State<AccountSnapshotsPage> createState() => _AccountSnapshotsPageState();
}

class _AccountSnapshotsPageState extends State<AccountSnapshotsPage> {
  late Account account;

  @override
  void initState() {
    super.initState();
    account = widget.account;
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return PageFramework(
      title: t.assets.holdings.snapshots.history_title,
      body: StreamBuilder<List<AccountSnapshotWithPositions>>(
        stream: HoldingService.instance.getAccountSnapshots(account.id),
        builder: (context, snapshot) {
          final snapshots = snapshot.data ?? [];
          final now = DateTime.now();

          // The snapshot in effect right now: newest with date <= now.
          final current = snapshots
              .cast<AccountSnapshotWithPositions?>()
              .firstWhere((s) => !s!.date.isAfter(now), orElse: () => null);

          return ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            children: [
              ListTileField(
                title: t.general.account,
                subtitle: account.name,
                leading: account.displayIcon(context),
                trailing: const Icon(Icons.expand_more_rounded),
                onTap: () => unawaited(_selectAccount(context)),
              ),
              const SizedBox(height: 12),
              Text(
                t.assets.holdings.snapshots.history_intro,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    t.assets.holdings.snapshots.count(n: snapshots.length),
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  TextButton.icon(
                    onPressed: () => showPortfolioSnapshotEditor(
                      context,
                      account: account,
                      prefillPositions: current?.positions,
                    ),
                    icon: const Icon(Icons.add_rounded, size: 18),
                    label: Text(t.assets.holdings.snapshots.new_snapshot),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              if (snapshots.isEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 32),
                  child: NoResults(
                    title: t.general.empty_warn,
                    description: t.assets.holdings.snapshots.no_snapshots,
                  ),
                )
              else
                ...snapshots.map(
                  (s) => _SnapshotTile(
                    account: account,
                    data: s,
                    isCurrent: current != null && current.id == s.id,
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  Future<void> _selectAccount(BuildContext context) async {
    final selection = await showAccountSelectorBottomSheet(
      context,
      AccountSelectorModal(
        allowMultiSelection: false,
        filterSavingAccounts: false,
        trackingMode: AccountTrackingMode.holdings,
        selectedAccounts: [account],
      ),
    );

    if (selection == null || selection.isEmpty || !mounted) return;

    setState(() => account = selection.first);
  }
}

class _SnapshotTile extends StatelessWidget {
  const _SnapshotTile({
    required this.account,
    required this.data,
    required this.isCurrent,
  });

  final Account account;
  final AccountSnapshotWithPositions data;
  final bool isCurrent;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final theme = Theme.of(context);

    final positions = data.isEmpty
        ? t.assets.holdings.snapshots.empty_portfolio
        : t.assets.holdings.snapshots.positions_count(n: data.positionsCount);

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      clipBehavior: Clip.antiAlias,
      child: ListTile(
        contentPadding: const EdgeInsets.only(left: 16, right: 4),
        title: Row(
          children: [
            if (isCurrent) ...[
              Tooltip(
                message: t.assets.holdings.snapshots.current,
                child: Icon(
                  Icons.adjust_rounded,
                  size: 16,
                  color: theme.colorScheme.primary,
                ),
              ),
              const SizedBox(width: 6),
            ],
            Expanded(
              child: Text(
                DateFormat.yMMMd().format(data.date),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.titleSmall,
              ),
            ),
          ],
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 2),
          child: Text(positions, maxLines: 1, overflow: TextOverflow.ellipsis),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          spacing: 4,
          children: [
            StreamBuilder(
              stream: AccountService.instance.getAccountMoney(
                account: account,
                date: data.date,
              ),
              builder: (context, balanceSnapshot) {
                if (!balanceSnapshot.hasData) {
                  return const SizedBox.square(
                    dimension: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  );
                }

                return TrailingValue(
                  amount: balanceSnapshot.data!,
                  currency: account.currency,
                  secondary: Text(
                    t.account.balance,
                    style: theme.textTheme.bodySmall,
                  ),
                );
              },
            ),
            IconButton(
              visualDensity: VisualDensity.compact,
              icon: Icon(
                Icons.delete_outline_rounded,
                color: theme.colorScheme.error,
              ),
              onPressed: () => _confirmDelete(context),
            ),
          ],
        ),
        onTap: () => showPortfolioSnapshotEditor(
          context,
          account: account,
          snapshotToEdit: data,
        ),
      ),
    );
  }

  Future<void> _confirmDelete(BuildContext context) async {
    final t = Translations.of(context);

    final confirmed = await confirmDialog(
      context,
      dialogTitle: t.assets.holdings.snapshots.delete_title,
      contentParagraphs: [Text(t.assets.holdings.snapshots.delete_descr)],
      confirmationText: t.ui_actions.delete,
      showCancelButton: true,
      icon: Icons.delete,
    );

    if (confirmed != true) return;

    await HoldingService.instance.deleteAccountSnapshot(data.id, account.id);
  }
}

// ---------------------------------------------------------------------------
// Snapshot editor (create/edit a full portfolio snapshot)
// ---------------------------------------------------------------------------

/// Opens the portfolio snapshot editor. Pass [snapshotToEdit] to edit an
/// existing snapshot (its date can change), or [prefillPositions] to seed a new
/// snapshot from the current portfolio.
Future<void> showPortfolioSnapshotEditor(
  BuildContext context, {
  required Account account,
  AccountSnapshotWithPositions? snapshotToEdit,
  List<SnapshotPosition>? prefillPositions,
}) {
  return RouteUtils.showResponsiveForm<Object>(
    _SnapshotEditorSheet(
      account: account,
      snapshotToEdit: snapshotToEdit,
      prefillPositions: prefillPositions,
    ),
    desktopWidth: 600,
  );
}

const _totalColWidth = 88.0;
const _actionColWidth = 32.0;
const _colGap = 6.0;

typedef _ColumnLayout = ({double qty, double cost, bool showTotal});

/// Widths of the editable columns, scaled to the room the sheet actually has.
/// On phones the (derived) total is dropped, since the symbol column needs it.
_ColumnLayout _columnLayout(double maxWidth) {
  final isTabletOrLarger =
      maxWidth >= BreakPoint.getById(BreakpointID.sm).width;

  return isTabletOrLarger
      ? (qty: 84, cost: 96, showTotal: true)
      : (qty: 68, cost: 78, showTotal: false);
}

class _EditorRow {
  final SecurityInDB security;
  final TextEditingController quantity;
  final TextEditingController avgCost;

  _EditorRow({
    required this.security,
    required this.quantity,
    required this.avgCost,
  });

  double get cost =>
      (double.tryParse(quantity.text) ?? 0) *
      (double.tryParse(avgCost.text) ?? 0);

  void dispose() {
    quantity.dispose();
    avgCost.dispose();
  }
}

class _SnapshotEditorSheet extends StatefulWidget {
  const _SnapshotEditorSheet({
    required this.account,
    this.snapshotToEdit,
    this.prefillPositions,
  });

  final Account account;
  final AccountSnapshotWithPositions? snapshotToEdit;
  final List<SnapshotPosition>? prefillPositions;

  @override
  State<_SnapshotEditorSheet> createState() => _SnapshotEditorSheetState();
}

class _SnapshotEditorSheetState extends State<_SnapshotEditorSheet> {
  final List<_EditorRow> _rows = [];
  final TextEditingController _cash = TextEditingController();
  late DateTime _date;

  bool get _isEditing => widget.snapshotToEdit != null;

  @override
  void initState() {
    super.initState();

    _date = widget.snapshotToEdit?.date ?? DateTime.now();

    final source = widget.snapshotToEdit?.positions ?? widget.prefillPositions;
    for (final p in source ?? const <SnapshotPosition>[]) {
      _rows.add(
        _EditorRow(
          security: p.security,
          quantity: TextEditingController(text: _plainNumber(p.quantity)),
          avgCost: TextEditingController(text: _plainNumber(p.avgCostPrice)),
        ),
      );
    }

    if (_isEditing) {
      _cash.text = _plainNumber(widget.snapshotToEdit!.cash);
    } else {
      unawaited(_prefillCashFromLedger(_date));
    }
  }

  @override
  void dispose() {
    for (final row in _rows) {
      row.dispose();
    }
    _cash.dispose();
    super.dispose();
  }

  /// Seeds the cash field with what the app believes the account held on
  /// [date], so confirming the snapshot unchanged never moves the balance and
  /// the user only has to type when the broker says something different.
  Future<void> _prefillCashFromLedger(DateTime date) async {
    final cash = await AccountService.instance
        .getAccountCash(account: widget.account, date: date)
        .first;

    if (!mounted) return;
    setState(() {
      _cash.text = _plainNumber(
        cash.roundWithDecimals(widget.account.currency.decimalPlaces),
      );
    });
  }

  double get _cashValue => double.tryParse(_cash.text) ?? 0;

  double get _totalCost => _rows.fold(0, (sum, r) => sum + r.cost);

  Future<void> _addPosition() async {
    final security = await showSecurityPicker(context);
    if (security == null || !mounted) return;

    if (_rows.any((r) => r.security.id == security.id)) return;

    setState(() {
      _rows.add(
        _EditorRow(
          security: security,
          quantity: TextEditingController(),
          avgCost: TextEditingController(
            text: (security.currentPrice ?? 0) == 0
                ? ''
                : _plainNumber(security.currentPrice!),
          ),
        ),
      );
    });
  }

  void _removeRow(_EditorRow row) {
    setState(() {
      _rows.remove(row);
      row.dispose();
    });
  }

  static bool _isSameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  /// When creating a new snapshot, picking a date should load whatever was
  /// in effect on that date (the most recent snapshot on or before it, plus the
  /// cash the account held then), so you always start editing from the right
  /// baseline instead of today's.
  void _onDateSelected(
    DateTime value,
    List<AccountSnapshotWithPositions> snapshots,
  ) {
    setState(() {
      _date = value;

      if (_isEditing) return;

      unawaited(_prefillCashFromLedger(value));

      final effective = snapshots
          .cast<AccountSnapshotWithPositions?>()
          .firstWhere((s) => !s!.date.isAfter(value), orElse: () => null);

      for (final row in _rows) {
        row.dispose();
      }

      _rows
        ..clear()
        ..addAll(
          (effective?.positions ?? const <SnapshotPosition>[]).map(
            (p) => _EditorRow(
              security: p.security,
              quantity: TextEditingController(text: _plainNumber(p.quantity)),
              avgCost: TextEditingController(
                text: _plainNumber(p.avgCostPrice),
              ),
            ),
          ),
        );
    });
  }

  /// The editor is a form, not a tutorial: what a snapshot is and what its cash
  /// means live behind this, so the fields stay uncluttered.
  Future<void> _showInfo() async {
    final t = Translations.of(context);

    await confirmDialog(
      context,
      dialogTitle: t.assets.holdings.snapshots.how_it_works,
      icon: Icons.help_outline_rounded,
      contentParagraphs: [
        Text(
          t.assets.holdings.snapshots.snapshot_contents_description(
            date: DateFormat.yMMMd().format(_date),
          ),
        ),
        Text(t.assets.holdings.snapshots.balance_effect_description),
      ],
    );
  }

  Future<void> _submit() async {
    await HoldingService.instance.saveAccountSnapshot(
      accountId: widget.account.id,
      date: _date,
      cash: _cashValue,
      replaceSnapshotId: widget.snapshotToEdit?.id,
      positions: _rows
          .map(
            (r) => (
              securityId: r.security.id,
              quantity: double.tryParse(r.quantity.text) ?? 0,
              avgCostPrice: double.tryParse(r.avgCost.text) ?? 0,
            ),
          )
          .toList(),
    );

    if (mounted) RouteUtils.popRoute();
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return PageFramework(
      title: _isEditing
          ? t.assets.holdings.edit_snapshot
          : t.assets.holdings.snapshots.update_positions,
      subtitle: Text(
        '${widget.account.name} · ${t.assets.holdings.snapshots.full_portfolio}',
      ),
      appBarActions: [
        IconButton(
          icon: const Icon(Icons.help_outline_rounded),
          tooltip: t.assets.holdings.snapshots.how_it_works,
          onPressed: _showInfo,
        ),
      ],
      persistentFooterButtons: [
        PersistentFooterButton(
          child: FilledButton.icon(
            style: getMediumButtonStyle(context),
            onPressed: _submit,
            icon: const Icon(Icons.save_rounded),
            label: Text(t.assets.holdings.snapshots.save),
          ),
        ),
      ],
      body: StreamBuilder<List<AccountSnapshotWithPositions>>(
        stream: HoldingService.instance.getAccountSnapshots(widget.account.id),
        builder: (context, snap) {
          final snapshots = snap.data ?? const <AccountSnapshotWithPositions>[];

          return LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight - 20,
                  ),
                  child: IntrinsicHeight(
                    child: _buildBody(
                      _columnLayout(constraints.maxWidth),
                      snapshots,
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildBody(
    _ColumnLayout cols,
    List<AccountSnapshotWithPositions> snapshots,
  ) {
    final t = Translations.of(context);
    final theme = Theme.of(context);

    final willOverwrite =
        !_isEditing && snapshots.any((s) => _isSameDay(s.date, _date));

    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DateTimeFormField(
          decoration: InputDecoration(
            suffixIcon: const Icon(Icons.event),
            labelText: '${t.assets.holdings.snapshots.date_label} *',
          ),
          initialDate: _date,
          dateFormat: DateFormat.yMMMd(),
          mode: DateTimeFieldPickerMode.date,
          lastDate: DateTime.now(),
          onDateSelected: (value) => _onDateSelected(value, snapshots),
        ),
        if (willOverwrite) ...[
          const SizedBox(height: 8),
          InlineInfoCard(
            text: t.assets.holdings.snapshots.overwrite_warning,
            mode: InlineInfoCardMode.info,
          ),
        ],
        const SizedBox(height: 16),
        TextFormField(
          controller: _cash,
          textAlign: TextAlign.end,
          keyboardType: const TextInputType.numberWithOptions(
            decimal: true,
            signed: true,
          ),
          decoration: InputDecoration(
            labelText: '${t.assets.holdings.snapshots.cash_label} *',
            suffixText: widget.account.currency.symbol,
          ),
          onChanged: (_) => setState(() {}),
        ),
        const SizedBox(height: 16),
        if (_rows.isEmpty)
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: _addPosition,
              icon: const Icon(Icons.add_circle_outline_rounded),
              label: Text(t.assets.holdings.snapshots.add_first_position),
            ),
          )
        else ...[
          _buildTableHeader(cols),
          ..._rows.map((row) => _buildRow(row, cols)),
          const SizedBox(height: 8),
          OutlinedButton.icon(
            onPressed: _addPosition,
            icon: const Icon(Icons.add_circle_outline_rounded),
            label: Text(t.assets.holdings.snapshots.add_position),
          ),
        ],
        const SizedBox(height: 16),
        const Spacer(),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: theme.colorScheme.primary.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              _buildSummaryRow(
                t.assets.holdings.snapshots.cash_label,
                _cashValue,
              ),
              const SizedBox(height: 4),
              _buildSummaryRow(
                t.assets.holdings.snapshots.total_cost,
                _totalCost,
              ),
              const Divider(height: 16),
              _buildSummaryRow(
                t.assets.holdings.snapshots.snapshot_total,
                _cashValue + _totalCost,
                emphasized: true,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryRow(
    String label,
    double amount, {
    bool emphasized = false,
  }) {
    final theme = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label.toUpperCase(),
          style: theme.textTheme.labelMedium?.copyWith(
            color: theme.colorScheme.primary,
            fontWeight: emphasized ? FontWeight.w700 : FontWeight.w500,
          ),
        ),
        DefaultTextStyle.merge(
          style:
              (emphasized
                      ? theme.textTheme.titleMedium!
                      : theme.textTheme.bodyMedium!)
                  .copyWith(color: theme.colorScheme.primary),
          child: CurrencyDisplayer(
            amountToConvert: amount,
            currency: widget.account.currency,
          ),
        ),
      ],
    );
  }

  Widget _buildTableHeader(_ColumnLayout cols) {
    final t = Translations.of(context);
    final theme = Theme.of(context);

    final style = theme.textTheme.labelSmall?.copyWith(
      color: theme.colorScheme.outline,
    );

    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Text(t.assets.holdings.snapshots.col_symbol, style: style),
          ),
          const SizedBox(width: _colGap),
          SizedBox(
            width: cols.qty,
            child: Text(
              t.assets.holdings.quantity,
              style: style,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(width: _colGap),
          SizedBox(
            width: cols.cost,
            child: Text(
              t.assets.holdings.avg_cost,
              style: style,
              textAlign: TextAlign.center,
            ),
          ),
          if (cols.showTotal) ...[
            const SizedBox(width: _colGap),
            SizedBox(
              width: _totalColWidth,
              child: Text(
                t.assets.holdings.total,
                style: style,
                textAlign: TextAlign.right,
              ),
            ),
          ],
          const SizedBox(width: _actionColWidth),
        ],
      ),
    );
  }

  Widget _buildRow(_EditorRow row, _ColumnLayout cols) {
    final t = Translations.of(context);
    final theme = Theme.of(context);

    final ticker = row.security.ticker?.trim();
    final hasTicker = ticker != null && ticker.isNotEmpty;

    final parsedQty = double.tryParse(row.quantity.text);
    final isZeroQty = parsedQty != null && parsedQty == 0;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                SecurityAvatar(security: row.security, size: 32),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        hasTicker ? ticker : row.security.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        hasTicker
                            ? row.security.name
                            : row.security.type.displayName(context),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.outline,
                        ),
                      ),
                    ],
                  ),
                ),
                if (isZeroQty) ...[
                  const SizedBox(width: 4),
                  Tooltip(
                    message: t.assets.holdings.snapshots.zero_qty_hint,
                    triggerMode: TooltipTriggerMode.tap,
                    constraints: BoxConstraints(maxWidth: 200),
                    showDuration: const Duration(seconds: 6),
                    child: Icon(
                      Icons.info_outline_rounded,
                      size: 18,
                      color: theme.colorScheme.tertiary,
                    ),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(width: _colGap),
          SizedBox(width: cols.qty, child: _buildCellField(row.quantity)),
          const SizedBox(width: _colGap),
          SizedBox(width: cols.cost, child: _buildCellField(row.avgCost)),
          if (cols.showTotal) ...[
            const SizedBox(width: _colGap),
            SizedBox(
              width: _totalColWidth,
              child: Align(
                alignment: Alignment.centerRight,
                child: DefaultTextStyle.merge(
                  style: theme.textTheme.bodyMedium!,
                  child: CurrencyDisplayer(
                    amountToConvert: row.cost,
                    currency: widget.account.currency,
                  ),
                ),
              ),
            ),
          ],
          SizedBox(
            width: _actionColWidth,
            child: IconButton(
              padding: EdgeInsets.zero,
              visualDensity: VisualDensity.compact,
              constraints: const BoxConstraints(),
              icon: Icon(
                Icons.delete_outline_rounded,
                size: 20,
                color: theme.colorScheme.error,
              ),
              onPressed: () => _removeRow(row),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCellField(TextEditingController controller) {
    return TextFormField(
      controller: controller,
      textAlign: TextAlign.center,
      decoration: const InputDecoration(
        isDense: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      ),
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      onChanged: (_) => setState(() {}),
    );
  }
}
