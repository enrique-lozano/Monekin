import 'package:flutter/material.dart';
import 'package:monekin/app/layout/page_framework.dart';
import 'package:monekin/app/transactions/form/state/transaction_form_controller.dart';
import 'package:monekin/app/transactions/form/widgets/debt_link_banner.dart';
import 'package:monekin/app/transactions/form/widgets/transaction_account_category_selector.dart';
import 'package:monekin/app/transactions/form/widgets/transaction_form_amount_block.dart';
import 'package:monekin/app/transactions/form/widgets/transaction_form_details_sections.dart';
import 'package:monekin/app/transactions/form/widgets/transaction_form_dual_leg_amount_section.dart';
import 'package:monekin/app/transactions/form/widgets/transaction_form_type_selector.dart';
import 'package:monekin/core/extensions/color.extensions.dart';
import 'package:monekin/core/presentation/responsive/breakpoint_container.dart';
import 'package:monekin/core/presentation/responsive/breakpoints.dart';
import 'package:monekin/core/presentation/styles/button_styles.dart';
import 'package:monekin/core/presentation/widgets/persistent_footer_button.dart';
import 'package:monekin/i18n/generated/translations.g.dart';
import 'package:provider/provider.dart';

class TransactionFormScaffold extends StatelessWidget {
  const TransactionFormScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    final c = context.watch<TransactionFormController>();
    final scheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);

    final dualHorizontalPadding =
        BreakPoint.of(context).isLargerOrEqualTo(BreakpointID.md) ? 0.0 : 16.0;

    final amountOrDual = c.usesDualLegAmountLayout
        ? TransactionFormDualLegAmountSection(
            padding: EdgeInsets.fromLTRB(
              dualHorizontalPadding,
              0,
              dualHorizontalPadding,
              12,
            ),
          )
        : const TransactionFormAmountBlock();

    final mdLeadingColumn = _paddedColumn(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 24,
          children: [
            if (!c.isAssetTradeInvestment)
              const TransactionFormTypeSelector(padding: EdgeInsets.zero),
            amountOrDual,
          ],
        ),
        if (!c.usesDualLegAmountLayout)
          const TransactionAccountCategorySelector(),
        if (c.linkedDebt != null &&
            BreakPoint.of(context).isLargerThan(BreakpointID.sm)) ...[
          const SizedBox(height: 16),
          DebtLinkBanner(debt: c.linkedDebt!, padding: EdgeInsets.zero),
        ],
      ],
    );

    final mdTrailingColumn = _paddedColumn(
      padding: const EdgeInsets.fromLTRB(8, 16, 16, 24),
      children: const [TransactionFormDetailsSections()],
    );

    final mobileScrollInner = <Widget>[
      amountOrDual,
      if (!c.usesDualLegAmountLayout)
        const Padding(
          padding: EdgeInsets.fromLTRB(16, 6, 16, 0),
          child: TransactionAccountCategorySelector(),
        ),
      const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: TransactionFormDetailsSections(),
      ),
    ];

    final saveLabel = c.isAssetTradeInvestment
        ? (c.investmentIsBuy ? t.assets.details.buy : t.assets.details.sell)
        : c.isEditMode
        ? t.transaction.edit
        : '${t.ui_actions.save} ${c.transactionType.displayName(context)}';

    final saveButtonColor = c.isAssetTradeInvestment
        ? c.investmentAccent(context)
        : c.transactionType.color(context);

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
              style: getMediumButtonStyle(context).copyWith(
                backgroundColor: WidgetStatePropertyAll(saveButtonColor),
                foregroundColor: WidgetStatePropertyAll(
                  saveButtonColor.getContrastColor(),
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
                if (!c.isAssetTradeInvestment)
                  const Padding(
                    padding: EdgeInsets.fromLTRB(16, 12, 16, 14),
                    child: TransactionFormTypeSelector(
                      padding: EdgeInsets.zero,
                    ),
                  ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(0, 8, 0, 24),
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
}
