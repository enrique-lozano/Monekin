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
import 'package:monekin/core/presentation/widgets/bottomSheetFooter.dart';
import 'package:monekin/core/presentation/widgets/confirm_dialog.dart';
import 'package:monekin/core/presentation/widgets/form_fields/date_form_field.dart';
import 'package:monekin/core/presentation/widgets/modal_container.dart';
import 'package:monekin/core/presentation/widgets/no_results.dart';
import 'package:monekin/core/presentation/widgets/number_ui_formatters/currency_displayer.dart';
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
        title: Row(
          children: [
            Flexible(
              child: Text(
                DateFormat.yMMMd().format(data.date),
                style: theme.textTheme.titleSmall,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 8),
            _Badge(label: t.assets.holdings.snapshots.manual),
            if (isCurrent) ...[
              const SizedBox(width: 4),
              _Badge(
                label: t.assets.holdings.snapshots.current,
                color: theme.colorScheme.primary,
              ),
            ],
          ],
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 2),
          child: Text(subtitle, maxLines: 2, overflow: TextOverflow.ellipsis),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                CurrencyDisplayer(
                  amountToConvert: data.totalCost,
                  currency: account.currency,
                ),
                Text(
                  t.assets.holdings.snapshots.cost_label,
                  style: theme.textTheme.bodySmall,
                ),
              ],
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
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (context) => _SnapshotEditorSheet(
      account: account,
      snapshotToEdit: snapshotToEdit,
      prefillPositions: prefillPositions,
    ),
  );
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
    final theme = Theme.of(context);

    return ModalContainer(
      title: _isEditing
          ? t.assets.holdings.snapshots.update_positions
          : t.assets.holdings.snapshots.new_snapshot,
      subtitle:
          '${widget.account.name} · ${t.assets.holdings.snapshots.full_portfolio}',
      bodyPadding: const EdgeInsets.symmetric(horizontal: 16),
      footer: BottomSheetFooter(
        submitText: t.assets.holdings.snapshots.save,
        submitIcon: Icons.save_rounded,
        onSaved: _submit,
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            t.assets.holdings.snapshots.editor_descr,
            style: theme.textTheme.bodySmall,
          ),
          const SizedBox(height: 16),
          DateTimeFormField(
            decoration: InputDecoration(
              suffixIcon: const Icon(Icons.event),
              labelText: '${t.assets.holdings.snapshots.date_label} *',
              helperText: t.assets.holdings.snapshots.date_helper,
              helperMaxLines: 2,
            ),
            initialDate: _date,
            dateFormat: DateFormat.yMMMd(),
            lastDate: DateTime.now(),
            onDateSelected: (value) => setState(() => _date = value),
          ),
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
          else
            ..._rows.map(_buildRow),
          const SizedBox(height: 8),
          OutlinedButton.icon(
            onPressed: _addPosition,
            icon: const Icon(Icons.add_circle_outline_rounded),
            label: Text(t.assets.holdings.snapshots.add_position),
          ),
          const SizedBox(height: 16),
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
          const SizedBox(height: 12),
          Text(
            t.assets.holdings.snapshots.remove_hint,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.outline,
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildRow(_EditorRow row) {
    final t = Translations.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SecurityAvatar(security: row.security, size: 34),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  row.security.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text(
                  row.security.type.displayName(context),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
          const SizedBox(width: 6),
          SizedBox(
            width: 64,
            child: TextFormField(
              controller: row.quantity,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                labelText: t.assets.holdings.quantity,
                isDense: true,
              ),
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              onChanged: (_) => setState(() {}),
            ),
          ),
          const SizedBox(width: 6),
          SizedBox(
            width: 76,
            child: TextFormField(
              controller: row.avgCost,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                labelText: t.assets.holdings.avg_cost,
                isDense: true,
              ),
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              onChanged: (_) => setState(() {}),
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.delete_outline_rounded,
              color: Theme.of(context).colorScheme.error,
            ),
            onPressed: () => _removeRow(row),
          ),
        ],
      ),
    );
  }
}
