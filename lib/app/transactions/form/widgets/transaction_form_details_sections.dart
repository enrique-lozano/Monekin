import 'package:flutter/material.dart';
import 'package:monekin/app/transactions/form/state/transaction_form_controller.dart';
import 'package:monekin/app/transactions/form/widgets/transaction_form_asset_valuation_switch.dart';
import 'package:monekin/app/transactions/form/widgets/debt_link_banner.dart';
import 'package:monekin/app/transactions/form/widgets/transaction_date_selector.dart';
import 'package:monekin/app/transactions/form/widgets/transaction_form_fields.dart';
import 'package:monekin/app/transactions/form/widgets/transaction_selectors.dart';
import 'package:monekin/core/extensions/color.extensions.dart';
import 'package:monekin/core/presentation/app_colors.dart';
import 'package:monekin/core/presentation/responsive/breakpoints.dart';
import 'package:monekin/core/presentation/styles/borders.dart';
import 'package:monekin/i18n/generated/translations.g.dart';
import 'package:provider/provider.dart';

/// Details / extra / tags for the transaction form (keeps [TransactionFormScaffold] thin).
class TransactionFormDetailsSections extends StatelessWidget {
  const TransactionFormDetailsSections({super.key});

  @override
  Widget build(BuildContext context) {
    final c = context.watch<TransactionFormController>();
    final t = Translations.of(context);
    final detailsChildren = <Widget>[
      TransactionTitleField(
        controller: c.titleController,
        focusNode: c.titleFocusNode,
        textInputAction: TextInputAction.next,
        onFieldSubmitted: (v) => c.onTitleFieldSubmitted(context, v),
      ),
      if (c.linkedDebt != null &&
          BreakPoint.of(context).isSmallerOrEqualTo(BreakpointID.sm))
        DebtLinkBanner(debt: c.linkedDebt!),
      const TransactionDateSelector(),
      if (c.isAssetTradeInvestment)
        const TransactionFormAssetValuationSwitch(),
      if (!c.isAssetTradeInvestment) const TransactionRecurrencySelector(),
      const TransactionStatusSelector(),
    ];

    final extraChildren = <Widget>[
      TransactionDescriptionField(
        controller: c.notesController,
        focusNode: c.notesFocusNode,
        textInputAction: TextInputAction.done,
        onFieldSubmitted: (v) => c.onNotesFieldSubmitted(context, v),
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _formSectionHeader(context, t.general.details),
        _formCard(context, children: detailsChildren),
        const SizedBox(height: 4),
        _tagsStrip(context, c),
        const SizedBox(height: 8),
        _formSectionHeader(context, t.transaction.form.extra_info_section),
        _formCard(context, children: extraChildren),
      ],
    );
  }
}

Widget _formSectionHeader(BuildContext context, String label) {
  final theme = Theme.of(context);
  return Padding(
    padding: const EdgeInsets.fromLTRB(4, 16, 4, 8),
    child: Text(
      label.toUpperCase(),
      style: theme.textTheme.labelSmall?.copyWith(
        letterSpacing: 0.85,
        fontWeight: FontWeight.w600,
        color: theme.colorScheme.onSurfaceVariant,
      ),
    ),
  );
}

Widget _formCard(BuildContext context, {required List<Widget> children}) {
  final scheme = Theme.of(context).colorScheme;
  return Card(
    margin: EdgeInsets.zero,
    elevation: 0,
    color: scheme.surfaceContainerHigh,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(inputBorderRadius),
      side: BorderSide(color: scheme.surfaceContainerHighest),
    ),
    clipBehavior: Clip.antiAlias,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (int i = 0; i < children.length; i++) ...[
          if (i != 0) Divider(height: 1, color: scheme.surface),
          children[i],
        ],
      ],
    ),
  );
}

Widget _tagsStrip(BuildContext context, TransactionFormController c) {
  final t = Translations.of(context);
  final hint = AppColors.of(context).textHint;
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _formSectionHeader(context, t.tags.display(n: 10)),
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.only(bottom: 4),
        child: Row(
          spacing: 6,
          children: [
            ActionChip(
              avatar: Icon(Icons.new_label_rounded, size: 18, color: hint),
              label: Text(t.tags.add, style: TextStyle(color: hint)),
              onPressed: () => c.openTagPicker(context),
            ),
            ...c.tags.map(
              (tag) => FilterChip(
                label: Text(tag.name, style: TextStyle(color: tag.colorData)),
                selected: true,
                onSelected: (_) => c.removeTag(tag),
                showCheckmark: false,
                selectedColor: tag.colorData.lighten(0.8),
                avatar: tag.displayIcon(),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
