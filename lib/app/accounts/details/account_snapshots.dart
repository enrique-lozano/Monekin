import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:monekin/app/accounts/details/holdings_card.dart'
    show showSecurityPicker;
import 'package:monekin/app/layout/page_framework.dart';
import 'package:monekin/app/securities/widgets/security_avatar.dart';
import 'package:monekin/core/database/app_db.dart';
import 'package:monekin/core/database/services/account/holding_service.dart';
import 'package:monekin/core/models/account/account.dart';
import 'package:monekin/core/models/asset/holding.dart';
import 'package:monekin/core/presentation/responsive/breakpoints.dart';
import 'package:monekin/core/presentation/styles/button_styles.dart';
import 'package:monekin/core/presentation/widgets/confirm_dialog.dart';
import 'package:monekin/core/presentation/widgets/form_fields/date_field.dart';
import 'package:monekin/core/presentation/widgets/form_fields/date_form_field.dart';
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
class AccountSnapshotsPage extends StatelessWidget {
  const AccountSnapshotsPage({super.key, required this.account});

  final Account account;

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
              Text(account.name, style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 4),
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

    final tickers = data.positions
        .map((p) => p.security.ticker ?? p.security.name)
        .join(', ');

    final subtitle = data.isEmpty
        ? t.assets.holdings.snapshots.empty_portfolio
        : '${t.assets.holdings.snapshots.positions_count(n: data.positionsCount)}'
              '${tickers.isEmpty ? '' : ' · $tickers'}';

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        title: Wrap(
          spacing: 8,
          runSpacing: 4,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Text(
              DateFormat.yMMMd().format(data.date),
              style: theme.textTheme.titleSmall,
            ),
            _Badge(label: t.assets.holdings.snapshots.manual),
            if (isCurrent)
              _Badge(
                label: t.assets.holdings.snapshots.current,
                color: theme.colorScheme.primary,
              ),
          ],
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 2),
          child: Text(subtitle, maxLines: 2, overflow: TextOverflow.ellipsis),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            TrailingValue(
              amount: data.totalCost,
              currency: account.currency,
              secondary: Text(
                t.assets.holdings.snapshots.cost_label,
                style: theme.textTheme.bodySmall,
              ),
            ),
            IconButton(
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

class _Badge extends StatelessWidget {
  const _Badge({required this.label, this.color});

  final String label;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final c = color ?? Theme.of(context).colorScheme.outline;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: c.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        label.toUpperCase(),
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
          color: c,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.4,
        ),
      ),
    );
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
  }

  @override
  void dispose() {
    for (final row in _rows) {
      row.dispose();
    }
    super.dispose();
  }

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
  /// in effect on that date (the most recent snapshot on or before it), so
  /// you always start editing from the right baseline instead of today's.
  void _onDateSelected(
    DateTime value,
    List<AccountSnapshotWithPositions> snapshots,
  ) {
    setState(() {
      _date = value;

      if (_isEditing) return;

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

  Future<void> _submit() async {
    await HoldingService.instance.saveAccountSnapshot(
      accountId: widget.account.id,
      date: _date,
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
        Text(
          t.assets.holdings.snapshots.editor_intro(
            date: DateFormat.yMMMd().format(_date),
          ),
          style: theme.textTheme.bodySmall,
        ),
        const SizedBox(height: 16),
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
        if (_rows.isEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Text(
              t.assets.holdings.snapshots.empty_portfolio,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium,
            ),
          )
        else ...[
          _buildTableHeader(cols),
          ..._rows.map((row) => _buildRow(row, cols)),
        ],
        const SizedBox(height: 8),
        OutlinedButton.icon(
          onPressed: _addPosition,
          icon: const Icon(Icons.add_circle_outline_rounded),
          label: Text(t.assets.holdings.snapshots.add_position),
        ),
        const Spacer(),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: theme.colorScheme.primary.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                t.assets.holdings.snapshots.total_cost.toUpperCase(),
                style: theme.textTheme.labelMedium?.copyWith(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.w700,
                ),
              ),
              DefaultTextStyle.merge(
                style: theme.textTheme.titleMedium!.copyWith(
                  color: theme.colorScheme.primary,
                ),
                child: CurrencyDisplayer(
                  amountToConvert: _totalCost,
                  currency: widget.account.currency,
                ),
              ),
            ],
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
