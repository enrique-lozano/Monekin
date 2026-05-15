import 'package:flutter/material.dart';
import 'package:monekin/app/assets/widgets/asset_valuation_impact_section.dart';
import 'package:monekin/app/transactions/form/transaction_form_controller.dart';
import 'package:monekin/app/transactions/form/widgets/debt_link_banner.dart';
import 'package:monekin/app/transactions/form/widgets/transaction_date_selector.dart';
import 'package:monekin/app/transactions/form/widgets/transaction_form_fields.dart';
import 'package:monekin/app/transactions/form/widgets/transaction_selectors.dart';
import 'package:monekin/core/extensions/color.extensions.dart';
import 'package:monekin/core/presentation/app_colors.dart';
import 'package:monekin/core/presentation/responsive/breakpoints.dart';
import 'package:monekin/core/presentation/styles/borders.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

/// Details / extra / tags for the transaction form (keeps [TransactionFormScaffold] thin).
List<Widget> transactionFormDetailsSections(
  BuildContext context,
  TransactionFormController c,
  bool showValueIndicator,
) {
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
    TransactionDateSelector(
      date: c.date,
      fromAccount: c.fromAccount,
      onDateChanged: c.setDate,
    ),
    if (showValueIndicator)
      AssetValuationImpactSection(
        asset: c.asset!,
        isBuy: c.investmentIsBuy,
        cardMargin: EdgeInsets.zero,
        tradeDate: c.date,
        tradeAmountAbs: c.transactionValue.abs(),
        previousSignedValue: c.isEditMode ? c.transactionToEdit?.value : null,
        previousTradeDate: c.isEditMode ? c.transactionToEdit?.date : null,
        updateValuations: c.updateValuations,
        onUpdateValuationsChanged: (v) => c.updateValuations = v,
      ),
    if (!c.isAssetTradeInvestment)
      TransactionRecurrencySelector(
        recurrentRule: c.recurrentRule,
        onRecurrencyChanged: c.setRecurrency,
      ),
    TransactionStatusSelector(
      date: c.date,
      status: c.status,
      onStatusChanged: c.setStatus,
    ),
  ];

  final extraChildren = <Widget>[
    if (c.transactionType.isTransfer)
      TransactionValueInDestinyField(
        controller: c.valueInDestinyController,
        transferAccount: c.transferAccount,
        focusNode: c.valueInDestinyFocusNode,
        onFieldSubmitted: c.onValueInDestinyFieldSubmitted,
      ),
    TransactionDescriptionField(
      controller: c.notesController,
      focusNode: c.notesFocusNode,
      textInputAction: TextInputAction.done,
      onFieldSubmitted: (v) => c.onNotesFieldSubmitted(context, v),
    ),
  ];

  return [
    _formSectionHeader(context, t.general.details),
    _formCard(context, children: detailsChildren),
    const SizedBox(height: 4),
    _tagsStrip(context, c),
    const SizedBox(height: 8),
    _formSectionHeader(context, t.transaction.form.extra_info_section),
    _formCard(context, children: extraChildren),
  ];
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
          if (i != 0) Divider(height: 1, color: scheme.outlineVariant),
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
