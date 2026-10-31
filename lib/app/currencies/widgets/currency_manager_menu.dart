import 'dart:async';

import 'package:flutter/material.dart';
import 'package:monekin/core/presentation/widgets/confirm_dialog.dart';
import 'package:monekin/core/presentation/widgets/monekin_popup_menu_button.dart';
import 'package:monekin/core/utils/list_tile_action_item.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

class CurrencyManagerMenu extends StatelessWidget {
  const CurrencyManagerMenu({
    super.key,
    required this.busy,
    required this.onUpdate,
    required this.onDelete,
  });

  final bool busy;
  final VoidCallback onUpdate;
  final Future<void> Function() onDelete;

  Future<void> _confirmDeletion(BuildContext context) async {
    final t = Translations.of(context);
    final confirmed = await confirmDialog(
      context,
      dialogTitle: t.currencies.exchange_rate_form.remove_all,
      contentParagraphs: [Text(t.currencies.remove_all_rates_warning)],
      showCancelButton: true,
      confirmationText: t.ui_actions.delete,
      icon: Icons.delete_outline_rounded,
    );
    if (confirmed != true || !context.mounted) return;
    await onDelete();
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    return MonekinPopupMenuButton(
      icon: const Icon(Icons.more_vert),
      actionItems: [
        ListTileActionItem(
          label: t.currencies.update_rates,
          icon: Icons.sync_rounded,
          onClick: busy ? null : onUpdate,
        ),
        ListTileActionItem(
          label: t.currencies.exchange_rate_form.remove_all,
          icon: Icons.delete_outline_rounded,
          role: ListTileActionRole.delete,
          onClick: busy ? null : () => unawaited(_confirmDeletion(context)),
        ),
      ],
    );
  }
}
