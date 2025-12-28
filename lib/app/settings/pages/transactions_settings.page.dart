import 'package:flutter/material.dart';
import 'package:monekin/app/layout/page_framework.dart';
import 'package:monekin/app/settings/widgets/settings_list_separator.dart';
import 'package:monekin/app/settings/widgets/transaction_swipe_action_selector.dart';
import 'package:monekin/core/database/services/user-setting/enum/transaction-swipe-actions.enum.dart';
import 'package:monekin/core/database/services/user-setting/user_setting_service.dart';
import 'package:monekin/core/extensions/padding.extension.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

class TransactionsSettingsPage extends StatelessWidget {
  const TransactionsSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return PageFramework(
      title: t.settings.transactions.title,
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 16).withSafeBottom(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            createListSeparator(
              context,
              t.settings.transactions.swipe_actions.title,
            ),

            buildSwipeActionTileSelector(
              context,
              SettingKey.transactionSwipeLeftAction,
            ),
            buildSwipeActionTileSelector(
              context,
              SettingKey.transactionSwipeRightAction,
            ),
          ],
        ),
      ),
    );
  }

  Builder buildSwipeActionTileSelector(
    BuildContext context,
    SettingKey direction,
  ) {
    final t = Translations.of(context);

    if (direction != SettingKey.transactionSwipeLeftAction &&
        direction != SettingKey.transactionSwipeRightAction) {
      throw Exception(
        'The direction provided is not valid. Use either transactionSwipeLeftAction or transactionSwipeRightAction',
      );
    }

    return Builder(
      builder: (context) {
        final selectedAction = TransactionSwipeAction.fromString(
          appStateSettings[direction],
        );

        final tileTitle = direction == SettingKey.transactionSwipeLeftAction
            ? t.settings.transactions.swipe_actions.swipe_left
            : t.settings.transactions.swipe_actions.swipe_right;

        final tileIcon = direction == SettingKey.transactionSwipeLeftAction
            ? Icons.swipe_left
            : Icons.swipe_right;

        return ListTile(
          title: Text(tileTitle),
          subtitle: Text(selectedAction.displayName(context)),
          onTap: () {
            showTransactionSwipeActionSelector(
              context,
              TransactionSwipeActionSelector(
                selectedAction: selectedAction,
                title: tileTitle,
              ),
            ).then((result) {
              if (result == null) return;

              UserSettingService.instance.setItem(
                direction,
                result.result?.name,
                updateGlobalState: true,
              );
            });
          },
          leading: Icon(tileIcon),
        );
      },
    );
  }
}
