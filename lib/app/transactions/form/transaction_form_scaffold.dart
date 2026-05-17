import 'package:flutter/material.dart';
import 'package:monekin/app/layout/page_framework.dart';
import 'package:monekin/app/transactions/form/transaction_form_controller.dart';
import 'package:monekin/app/transactions/form/widgets/debt_link_banner.dart';
import 'package:monekin/app/transactions/form/widgets/transaction_account_category_selector.dart';
import 'package:monekin/app/transactions/form/widgets/transaction_form_amount_block.dart';
import 'package:monekin/app/transactions/form/widgets/transaction_form_details_sections.dart';
import 'package:monekin/app/transactions/form/widgets/transaction_form_dual_leg_amount_section.dart';
import 'package:monekin/app/transactions/form/widgets/transaction_form_type_selector.dart';
import 'package:monekin/core/extensions/color.extensions.dart';
import 'package:monekin/core/presentation/responsive/breakpoint_container.dart';
import 'package:monekin/core/presentation/responsive/breakpoints.dart';
import 'package:monekin/core/presentation/styles/big_button_style.dart';
import 'package:monekin/core/presentation/widgets/persistent_footer_button.dart';
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

        final formSections = transactionFormDetailsSections(
          context,
          c,
          showValueIndicator,
        );

        final accountBlock = TransactionAccountCategorySelector(form: c);
        final dualHorizontalPadding =
            BreakPoint.of(context).isLargerOrEqualTo(BreakpointID.md)
            ? 0.0
            : 16.0;

        final amountOrDual = c.usesDualLegAmountLayout
            ? TransactionFormDualLegAmountSection(
                controller: c,
                padding: EdgeInsets.fromLTRB(
                  dualHorizontalPadding,
                  0,
                  dualHorizontalPadding,
                  12,
                ),
              )
            : TransactionFormAmountBlock(
                controller: c,
                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 12),
              );

        final mdLeadingColumn = _paddedColumn(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: 24,
              children: [
                TransactionFormTypeSelector(
                  controller: c,
                  padding: EdgeInsets.zero,
                ),
                amountOrDual,
              ],
            ),
            if (!c.usesDualLegAmountLayout) accountBlock,
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
          amountOrDual,
          if (!c.usesDualLegAmountLayout)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 6, 16, 0),
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
                      padding: const EdgeInsets.fromLTRB(16, 12, 16, 14),
                      child: TransactionFormTypeSelector(
                        controller: c,
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
      },
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
