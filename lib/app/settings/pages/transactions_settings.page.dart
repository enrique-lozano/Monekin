import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:monekin/app/layout/page_framework.dart';
import 'package:monekin/app/settings/pages/default_form_transacation_values.page.dart';
import 'package:monekin/app/settings/pages/general_settings.page.dart';
import 'package:monekin/app/settings/widgets/monekin_tile_switch.dart';
import 'package:monekin/app/settings/widgets/settings_list_utils.dart';
import 'package:monekin/app/settings/widgets/transaction_swipe_action_selector.dart';
import 'package:monekin/app/transactions/widgets/transaction_list_tile.dart';
import 'package:monekin/core/database/services/account/account_service.dart';
import 'package:monekin/core/database/services/category/category_service.dart';
import 'package:monekin/core/database/services/user-setting/enum/transaction-swipe-actions.enum.dart';
import 'package:monekin/core/database/services/user-setting/user_setting_service.dart';
import 'package:monekin/core/extensions/padding.extension.dart';
import 'package:monekin/core/models/tags/tag.dart';
import 'package:monekin/core/models/transaction/transaction.dart';
import 'package:monekin/core/models/transaction/transaction_type.enum.dart';
import 'package:monekin/core/presentation/widgets/dynamic_selector_modal.dart';
import 'package:monekin/core/presentation/widgets/modal_container.dart';
import 'package:monekin/core/routes/route_utils.dart';
import 'package:monekin/i18n/generated/translations.g.dart';
import 'package:rxdart/rxdart.dart';

class TransactionsSettingsPage extends StatelessWidget {
  const TransactionsSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return PageFramework(
      title: t.settings.transactions.title,
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 16).withSafeBottom(context),
        child: ListTileTheme(
          data: getSettingListTileStyle(context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                title: Text(t.settings.transactions.style.title),
                subtitle: Text(t.settings.transactions.style.subtitle),

                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    showDragHandle: true,
                    builder: (context) {
                      return ModalContainer(
                        title: t.settings.transactions.style.title,
                        subtitle: t.settings.transactions.style.subtitle,
                        body: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.outline,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: StreamBuilder(
                                  stream: Rx.combineLatest2(
                                    AccountService.instance.getAccounts(
                                      limit: 1,
                                    ),
                                    CategoryService.instance.getCategories(
                                      limit: 1,
                                    ),
                                    (account, category) => (account, category),
                                  ),
                                  builder: (context, asyncSnapshot) {
                                    final account =
                                        asyncSnapshot.data?.$1.firstOrNull;

                                    if (account == null) {
                                      return Center(
                                        child: Text(
                                          "Create an account first to see the transaction tile preview here",
                                        ),
                                      );
                                    }

                                    final category =
                                        asyncSnapshot.data?.$2.firstOrNull;

                                    return TransactionListTile(
                                      preventDefaultOnTap: true,
                                      transaction: MoneyTransaction(
                                        id: "t1",
                                        title: "McDonald's",
                                        notes: "Burger and fries",
                                        category: category,
                                        date: DateTime.now(),
                                        value: -100,
                                        isHidden: false,
                                        type: TransactionType.expense,
                                        currentValueInPreferredCurrency: -100,
                                        tags: [
                                          Tag(
                                            id: 'tag1',
                                            name: 'Holidays',
                                            color: 'FF5722',
                                          ),
                                        ],
                                        account: account,
                                        accountCurrency: account.currency,
                                      ),
                                      heroTag: null,
                                      applySwipeActions: false,
                                    );
                                  },
                                ),
                              ),

                              const SizedBox(height: 16),
                              MonekinTileSwitch(
                                title: t.settings.transactions.style.show_tags,
                                initialValue:
                                    appStateSettings[SettingKey
                                        .transactionTileShowTags] ==
                                    '1',
                                icon: Icon(Tag.icon),
                                onSwitchDebounceMs: 200,
                                onSwitch: (value) {
                                  UserSettingService.instance.setItem(
                                    SettingKey.transactionTileShowTags,
                                    value ? '1' : '0',
                                    updateGlobalState: true,
                                  );
                                },
                              ),
                              MonekinTileSwitch(
                                //TODO: i18n
                                title: t.settings.transactions.style.show_time,
                                initialValue:
                                    appStateSettings[SettingKey
                                        .transactionTileShowTime] ==
                                    '1',
                                icon: Icon(Icons.access_time),
                                onSwitchDebounceMs: 200,
                                onSwitch: (value) {
                                  UserSettingService.instance.setItem(
                                    SettingKey.transactionTileShowTime,
                                    value ? '1' : '0',
                                    updateGlobalState: true,
                                  );
                                },
                              ),
                              ShowAllDecimalPlacesSwitch(),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
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

              createListSeparator(context, t.transaction.create),

              StreamBuilder<String?>(
                stream: UserSettingService.instance.getSettingFromDB(
                  SettingKey.defaultTransactionType,
                ),
                builder: (context, snapshot) {
                  final typeStr = snapshot.data;
                  final type = typeStr != null
                      ? TransactionType.values.firstWhereOrNull(
                          (e) => e.name == typeStr,
                        )
                      : TransactionType.expense;

                  final displayType = type ?? TransactionType.expense;

                  return ListTile(
                    title: Text(t.settings.transactions.default_type.title),
                    subtitle: Text(displayType.displayName(context)),
                    leading: Icon(
                      displayType.icon,
                      color: displayType.color(context),
                    ),
                    onTap: () {
                      showDynamicSelectorBottomSheet<
                            TransactionType,
                            TransactionType
                          >(
                            context,
                            selectorWidget: DynamicSelectorModal(
                              title: t
                                  .settings
                                  .transactions
                                  .default_type
                                  .modal_title,
                              items: TransactionType.values,
                              selectedValue: displayType,
                              displayNameGetter: (t) => t.displayName(context),
                              valueGetter: (t) => t,
                              trailingIconGetter: (t) => t.icon,
                            ),
                          )
                          .then((selected) {
                            if (selected != null && selected.result != null) {
                              UserSettingService.instance.setItem(
                                SettingKey.defaultTransactionType,
                                selected.result!.name,
                              );
                            }
                          });
                    },
                  );
                },
              ),
              ListTile(
                title: Text(t.settings.transactions.default_values.title),
                trailing: const Icon(Icons.arrow_forward_ios_rounded),
                onTap: () => RouteUtils.pushRoute(
                  const DefaultFormTransactionValuesPage(),
                ),
              ),
            ],
          ),
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
