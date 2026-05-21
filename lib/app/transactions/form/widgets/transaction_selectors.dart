import 'package:flutter/material.dart';
import 'package:monekin/app/tags/tags_selector.modal.dart';
import 'package:monekin/app/transactions/form/dialogs/transaction_status_selector.dart';
import 'package:monekin/app/transactions/form/state/transaction_form_controller.dart';
import 'package:monekin/app/transactions/form/widgets/custom_interval_selector.dart';
import 'package:monekin/app/transactions/form/widgets/tr_form_interval_selector.dart';
import 'package:monekin/core/extensions/color.extensions.dart';
import 'package:monekin/core/models/tags/tag.dart';
import 'package:monekin/core/models/transaction/recurrency_data.dart';
import 'package:monekin/core/models/transaction/transaction_status.enum.dart';
import 'package:monekin/core/presentation/animations/scaled_animated_switcher.dart';
import 'package:monekin/core/presentation/app_colors.dart';
import 'package:monekin/core/presentation/widgets/dynamic_selector_modal.dart';
import 'package:monekin/core/routes/route_utils.dart';
import 'package:monekin/core/utils/focus.dart';
import 'package:monekin/i18n/generated/translations.g.dart';
import 'package:provider/provider.dart';

class TransactionStatusSelector extends StatelessWidget {
  const TransactionStatusSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final c = context.watch<TransactionFormController>();
    final date = c.date;
    final status = c.status;
    final isSelectorDisabled = date.compareTo(DateTime.now()) > 0;

    final selectedStatus = isSelectorDisabled
        ? TransactionStatus.pending
        : status;

    return ListTile(
      leading: ScaledAnimatedSwitcher(
        keyToWatch: selectedStatus.icon.toString(),
        child: Icon(
          selectedStatus.icon,
          color: selectedStatus.color.withOpacity(isSelectorDisabled ? 0.3 : 1),
        ),
      ),
      title: Text(selectedStatus.displayName(context)),
      enabled: !isSelectorDisabled,
      onTap: () {
        unfocusCurrentFocusedItem(context);

        showTransactionStatusModal(context, initialStatus: status).then((
          modalRes,
        ) {
          if (modalRes == null) return;

          c.setStatus(modalRes.result);
        });
      },
    );
  }
}

class TransactionRecurrencySelector extends StatelessWidget {
  const TransactionRecurrencySelector({super.key});

  @override
  Widget build(BuildContext context) {
    final c = context.watch<TransactionFormController>();
    final recurrentRule = c.recurrentRule;

    return ListTile(
      leading: Icon(
        recurrentRule.isRecurrent ? Icons.repeat_rounded : Icons.repeat_one,
      ),
      title: Text(recurrentRule.formText(context)),
      onTap: () {
        showDynamicSelectorBottomSheet(
          context,
          selectorWidget: getTransactionFormIntervalSelector(
            context,
            recurrentRule,
          ),
        ).then((res) {
          if (res == null) return;

          if (res.result != null) {
            c.setRecurrency(res.result!);
          } else {
            RouteUtils.pushRoute(
              IntervalSelectorPage(preselectedRecurrentRule: recurrentRule),
            ).then((value) {
              if (value == null) return;
              c.setRecurrency(value as RecurrencyData);
            });
          }
        });
      },
    );
  }
}

class TransactionTagsSelector extends StatelessWidget {
  const TransactionTagsSelector({
    super.key,
    required this.tags,
    required this.onTagsChanged,
  });

  final List<Tag> tags;
  final ValueChanged<List<Tag>> onTagsChanged;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final Widget tagsChips = Wrap(
      spacing: 6,
      runSpacing: 0,
      children: List.generate(tags.length, (index) {
        final tag = tags[index];

        return FilterChip(
          label: Text(tag.name, style: TextStyle(color: tag.colorData)),
          selected: true,
          onSelected: (value) {
            final newTags = List<Tag>.from(tags);
            newTags.removeWhere((element) => element.id == tag.id);
            onTagsChanged(newTags);
          },
          showCheckmark: false,
          selectedColor: tag.colorData.lighten(0.8),
          avatar: tag.displayIcon(),
        );
      }),
    );

    return ListTile(
      leading: Icon(Tag.icon),
      onTap: () {
        showTagListModal(
          context,
          modal: TagSelector(
            selectedTags: tags,
            allowEmptySubmit: true,
            includeNullTag: false,
          ),
        ).then((value) {
          if (value == null) {
            return;
          }
          onTagsChanged(value.selectedTags.nonNulls.toList());
        });
      },
      title: tags.isEmpty
          ? Text(
              t.tags.select.title,
              style: TextStyle(color: AppColors.of(context).textHint),
            )
          : tagsChips,
    );
  }
}
