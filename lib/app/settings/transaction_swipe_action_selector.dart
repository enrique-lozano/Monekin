import 'package:flutter/material.dart';
import 'package:monekin/core/database/services/user-setting/enum/transaction-swipe-actions.enum.dart';
import 'package:monekin/core/presentation/widgets/dynamic_selector_modal.dart';
import 'package:monekin/core/presentation/widgets/modal_container.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

Future<ModalResult<TransactionSwipeAction?>?>
showTransactionSwipeActionSelector(
  BuildContext context,
  TransactionSwipeActionSelector selector,
) {
  return showModalBottomSheet<ModalResult<TransactionSwipeAction?>>(
    context: context,
    showDragHandle: true,
    isScrollControlled: true,
    builder: (context) {
      return selector;
    },
  );
}

class TransactionSwipeActionSelector extends StatelessWidget {
  const TransactionSwipeActionSelector({
    super.key,
    required this.selectedAction,
    required this.title,
  });

  /// Currently selected action. If `null`, no action is selected.
  final TransactionSwipeAction? selectedAction;

  final String title;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return DynamicSelectorModal<
      TransactionSwipeAction?,
      TransactionSwipeAction?
    >(
      items: const [null, ...TransactionSwipeAction.values],
      selectedValue: selectedAction,
      displayNameGetter: (action) =>
          action?.displayName(context) ?? null.displayName(context),
      valueGetter: (action) => action,
      title: title,
      subtitle: t.settings.lang_descr,
    );
  }
}
