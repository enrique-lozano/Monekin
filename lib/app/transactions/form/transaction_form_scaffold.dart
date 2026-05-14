import 'package:flutter/material.dart';
import 'package:monekin/app/assets/widgets/asset_valuation_impact_section.dart';
import 'package:monekin/app/layout/page_framework.dart';
import 'package:monekin/app/transactions/form/transaction_form_controller.dart';
import 'package:monekin/app/transactions/form/widgets/debt_link_banner.dart';
import 'package:monekin/app/transactions/form/widgets/transaction_account_selector_row.dart';
import 'package:monekin/app/transactions/form/widgets/transaction_amount_display.dart';
import 'package:monekin/app/transactions/form/widgets/transaction_date_selector.dart';
import 'package:monekin/app/transactions/form/widgets/transaction_form_fields.dart';
import 'package:monekin/app/transactions/form/widgets/transaction_selectors.dart';
import 'package:collection/collection.dart';
import 'package:monekin/core/extensions/color.extensions.dart';
import 'package:monekin/core/models/transaction/transaction_type.enum.dart';
import 'package:monekin/core/presentation/animations/animated_expanded.dart';
import 'package:monekin/core/presentation/app_colors.dart';
import 'package:monekin/core/presentation/responsive/breakpoint_container.dart';
import 'package:monekin/core/presentation/responsive/breakpoints.dart';
import 'package:monekin/core/presentation/styles/big_button_style.dart';
import 'package:monekin/core/presentation/styles/borders.dart';
import 'package:monekin/core/presentation/widgets/persistent_footer_button.dart';
import 'package:monekin/core/utils/text_field_utils.dart';
import 'package:monekin/i18n/generated/translations.g.dart';
import 'package:provider/provider.dart';

class TransactionFormScaffold extends StatelessWidget {
  const TransactionFormScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);

    return Consumer<TransactionFormController>(
      builder: (context, c, _) {
        final showValueIndicator =
            c.asset != null &&
            c.isAssetTradeInvestment &&
            c.transactionValue.abs() > 0;

        final formSections = _formFieldSections(context, c, showValueIndicator);
        final accountBlock = _accountBlock(context, c);

        final mdLeadingColumn = _paddedColumn(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
          children: [
            _amountAndTypeSection(context, c),
            if (c.isAssetTradeInvestment) _investmentAmountHeader(context, c),
            accountBlock,
            if (c.linkedDebt != null &&
                BreakPoint.of(context).isLargerThan(BreakpointID.sm)) ...[
              const SizedBox(height: 16),
              DebtLinkBanner(debt: c.linkedDebt!, padding: EdgeInsets.zero),
            ],
          ],
        );

        final mdTrailingColumn = _paddedColumn(
          padding: const EdgeInsets.fromLTRB(8, 16, 16, 24),
          children: formSections,
        );

        final mobileScrollInner = <Widget>[
          _amountOnlySection(context, c),
          if (c.isAssetTradeInvestment) _investmentAmountHeader(context, c),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: accountBlock,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: formSections,
            ),
          ),
        ];

        final saveLabel = c.isEditMode
            ? t.transaction.edit
            : c.isAssetTradeInvestment
            ? t.transaction.create
            : '${t.ui_actions.save} ${c.transactionType.displayName(context)}';

        return SafeArea(
          bottom: false,
          left: false,
          right: false,
          top: BreakPoint.of(context).isLargerOrEqualTo(BreakpointID.md),
          child: PageFramework(
            title: c.resolveFrameworkTitle(t),
            persistentFooterButtons: [
              PersistentFooterButton(
                child: FilledButton.icon(
                  style: getBigButtonStyle(context).copyWith(
                    backgroundColor: WidgetStatePropertyAll(
                      c.transactionType.color(context),
                    ),
                    foregroundColor: WidgetStatePropertyAll(
                      c.transactionType.color(context).getContrastColor(),
                    ),
                    fixedSize: const WidgetStatePropertyAll(
                      Size.fromHeight(42),
                    ),
                  ),
                  onPressed: () => c.onSavePressed(context),
                  icon: const Icon(Icons.save),
                  label: Text(saveLabel),
                ),
              ),
            ],
            body: Form(
              key: c.formKey,
              child: BreakpointContainer(
                mdChild: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: mdLeadingColumn),
                    VerticalDivider(
                      width: 1,
                      thickness: 1,
                      color: scheme.outlineVariant,
                    ),
                    Expanded(child: mdTrailingColumn),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                      child: _typeSegmented(context, c),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: mobileScrollInner,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  /// Amount row only (used on mobile where type tabs sit above the scroll view).
  static Widget _amountOnlySection(
    BuildContext context,
    TransactionFormController c,
  ) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      child: ListenableBuilder(
        listenable: c.amountTextController,
        builder: (context, _) => _amountInputRow(context, c),
      ),
    );
  }

  static Widget _paddedColumn({
    required List<Widget> children,
    EdgeInsetsGeometry padding = const EdgeInsets.fromLTRB(16, 16, 16, 24),
  }) {
    return SingleChildScrollView(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: children,
      ),
    );
  }

  static Widget _formSectionHeader(BuildContext context, String label) {
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

  static Widget _formCard(
    BuildContext context, {
    required List<Widget> children,
  }) {
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

  static List<Widget> _formFieldSections(
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
        onFieldSubmitted: (_) {
          (c.transactionType.isTransfer
                  ? c.valueInDestinyFocusNode
                  : c.notesFocusNode)
              .requestFocus();
        },
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
          onFieldSubmitted: (_) => c.notesFocusNode.requestFocus(),
        ),
      TransactionDescriptionField(
        controller: c.notesController,
        focusNode: c.notesFocusNode,
        textInputAction: TextInputAction.done,
        onFieldSubmitted: (_) => FocusScope.of(context).unfocus(),
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

  static Widget _tagsStrip(BuildContext context, TransactionFormController c) {
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

  static Widget _investmentAmountHeader(
    BuildContext context,
    TransactionFormController c,
  ) {
    return TransactionAmountDisplay(
      transactionType: c.transactionType,
      transactionValue: c.transactionValue,
      fromAccount: c.fromAccount,
      displayCurrencyOverride: c.asset?.currency,
      accentColor: c.investmentAccent(context),
      mathIconOverride: c.investmentIsBuy
          ? TransactionType.income.icon
          : TransactionType.expense.icon,
      onTap: () => c.openAmountSelectorSheet(context),
    );
  }

  static Widget _accountBlock(
    BuildContext context,
    TransactionFormController c,
  ) {
    return TransactionAccountSelectorRow(
      transactionType: c.transactionType,
      fromAccount: c.fromAccount,
      transferAccount: c.transferAccount,
      selectedCategory: c.selectedCategory,
      shakeKey: c.shakeKey,
      investmentAssetName: c.isAssetTradeInvestment
          ? (c.asset?.name ?? '…')
          : null,
      onSwapTransferAccounts: c.transactionType.isTransfer
          ? c.swapTransferAccounts
          : null,
      onFromAccountTap: () async {
        final modalRes = await c.showAccountSelector(context, c.fromAccount);
        if (modalRes != null && modalRes.isNotEmpty) {
          c.setFromAccount(modalRes.first);
        }
      },
      onTransferAccountTap: () async {
        final modalRes = await c.showAccountSelector(
          context,
          c.transferAccount,
        );
        if (modalRes != null && modalRes.isNotEmpty) {
          c.setTransferAccount(modalRes.first);
        }
      },
      onCategoryTap: () => c.selectCategory(context),
    );
  }

  static Widget _amountAndTypeSection(
    BuildContext context,
    TransactionFormController c,
  ) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        spacing: 24,
        children: [
          _typeSegmented(context, c),
          ListenableBuilder(
            listenable: c.amountTextController,
            builder: (context, _) => _amountInputRow(context, c),
          ),
        ],
      ),
    );
  }

  static Widget _typeSegmented(
    BuildContext context,
    TransactionFormController c,
  ) {
    final selectedColor = c.transactionType.color(context);
    final fg = c.foregroundColor(context);
    final types = [
      TransactionType.income,
      TransactionType.expense,
      TransactionType.transfer,
    ];

    return SizedBox(
      width: double.infinity,
      child: SegmentedButton<TransactionType>(
        segments: types
            .map(
              (e) => ButtonSegment<TransactionType>(
                value: e,
                label: Text(
                  e.displayName(context),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            )
            .toList(),
        selected: {c.transactionType},
        onSelectionChanged: (next) {
          final v = next.firstOrNull;
          if (v != null) c.onTransactionTypeChanged(v);
        },
        showSelectedIcon: false,
        style: ButtonStyle(
          animationDuration: const Duration(milliseconds: 250),
          side: WidgetStateProperty.resolveWith(
            (s) => const BorderSide(style: BorderStyle.none, width: 0),
          ),
          foregroundColor: WidgetStateProperty.resolveWith(
            (s) => s.contains(WidgetState.selected)
                ? selectedColor.getContrastColor()
                : fg.withOpacity(0.85),
          ),
          backgroundColor: WidgetStateProperty.resolveWith(
            (s) => s.contains(WidgetState.selected)
                ? selectedColor
                : Theme.of(context).colorScheme.surfaceContainerHigh,
          ),
        ),
      ),
    );
  }

  static Widget _amountInputRow(
    BuildContext context,
    TransactionFormController c,
  ) {
    final baseColor = c.transactionType.color(context);
    final ctrl = c.amountTextController;
    double fontSize = 48;
    switch (ctrl.text.length) {
      case > 8:
        fontSize = 24;
        break;
      case > 6:
        fontSize = 28;
        break;
      case > 4:
        fontSize = 36;
    }

    return AnimatedSizeSwitcher(
      duration: const Duration(milliseconds: 1250),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            margin: const EdgeInsets.only(left: 6, right: 2),
            decoration: BoxDecoration(
              color: c.foregroundColor(context),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Icon(c.transactionType.mathIcon, color: baseColor, size: 24),
          ),
          Flexible(
            child: IntrinsicWidth(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Semantics(
                  label: Translations.of(context).transaction.form.value,
                  textField: true,
                  child: TextField(
                    controller: ctrl,
                    focusNode: c.amountFocusNode,
                    textInputAction: TextInputAction.next,
                    onSubmitted: (_) => c.titleFocusNode.requestFocus(),
                    textAlign: TextAlign.center,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    inputFormatters: decimalDigitFormatter(
                      c.fromAccount?.currency.decimalPlaces ?? 2,
                      allowNegative: true,
                    ),
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      color: c.foregroundColor(context),
                      fontWeight: FontWeight.bold,
                      fontSize: fontSize,
                    ),
                    decoration: InputDecoration(
                      isDense: true,
                      fillColor: Colors.transparent,
                      hoverColor: Theme.of(
                        context,
                      ).colorScheme.surfaceContainerHigh.withOpacity(0.05),
                      border: InputBorder.none,
                      hintText: '0',
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      prefixText: c.fromAccount?.currency.symbol,
                      suffixText: ctrl.text.endsWith('.') ? '00' : null,
                      hintStyle: TextStyle(
                        color: c.foregroundColor(context).withOpacity(0.35),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          IconButton.outlined(
            color: c.foregroundColor(context),
            onPressed: () => c.openAmountSelectorSheet(context),
            icon: const Icon(Icons.calculate),
          ),
        ],
      ),
    );
  }
}
