import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:monekin/app/transactions/form/transaction_form.page.dart';
import 'package:monekin/app/transactions/transaction_details.page.dart';
import 'package:monekin/core/database/services/user-setting/enum/transaction-swipe-actions.enum.dart';
import 'package:monekin/core/database/services/user-setting/user_setting_service.dart';
import 'package:monekin/core/extensions/color.extensions.dart';
import 'package:monekin/core/models/date-utils/periodicity.dart';
import 'package:monekin/core/models/supported-icon/icon_displayer.dart';
import 'package:monekin/core/models/transaction/transaction.dart';
import 'package:monekin/core/models/transaction/transaction_status.enum.dart';
import 'package:monekin/core/presentation/animations/animated_expanded.dart';
import 'package:monekin/core/presentation/helpers/snackbar.dart';
import 'package:monekin/core/presentation/theme.dart';
import 'package:monekin/core/presentation/widgets/number_ui_formatters/currency_displayer.dart';
import 'package:monekin/core/presentation/widgets/number_ui_formatters/ui_number_formatter.dart';
import 'package:monekin/core/routes/route_utils.dart';
import 'package:monekin/core/services/view-actions/transaction_view_actions_service.dart';
import 'package:monekin/core/utils/constants.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

import '../../../core/presentation/app_colors.dart';

class TransactionListTile extends StatelessWidget {
  const TransactionListTile({
    super.key,
    required this.transaction,
    this.showDateTime = true,
    this.showAccount = true,
    this.periodicityInfo,
    required this.heroTag,
    this.onLongPress,
    this.onTap,
    this.isSelected = false,
    this.applySwipeActions = false,
    this.preventDefaultOnTap = false,
  });

  final MoneyTransaction transaction;

  final Periodicity? periodicityInfo;

  /// Whether to show the date and time in the subtitle. Defaults to `true`
  final bool showDateTime;

  /// Whether to show the account name in the subtitle. Defaults to `true`
  final bool showAccount;

  final Object? heroTag;

  final bool applySwipeActions;

  /// Action to trigger when the tile is long pressed. If `null`,
  /// the tile will display a modal with some quick actions for
  /// this transaction
  final void Function()? onLongPress;

  /// Action to trigger when the tile is pressed. If `null`,
  /// the tile will redirect to the `transaction-details-page`
  final void Function()? onTap;

  /// If `true`, prevents the default onTap action. Only have an effect if the
  /// onTap parameter is not null. Defaults to `false`
  final bool preventDefaultOnTap;

  final bool isSelected;

  bool get showPeriodicityInfo =>
      periodicityInfo != null && transaction.recurrentInfo.isRecurrent;

  void showTransactionActions(
    BuildContext context,
    MoneyTransaction transaction,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: TransactionViewActionService()
              .transactionDetailsActions(context, transaction: transaction)
              .map(
                (e) => ListTile(
                  leading: Icon(e.icon),
                  title: Text(e.label),
                  onTap: e.onClick == null
                      ? null
                      : () {
                          RouteUtils.popRoute();
                          e.onClick!();
                        },
                ),
              )
              .toList(),
        );
      },
    );
  }

  Widget showSwipeActionBg(BuildContext context, SettingKey settingKey) {
    final isLeft = settingKey == SettingKey.transactionSwipeLeftAction;
    final isRight = settingKey == SettingKey.transactionSwipeRightAction;

    if (!isLeft && !isRight) {
      throw Exception('Invalid SettingKey for swipe action background');
    }

    final swipeAction = TransactionSwipeAction.fromString(
      appStateSettings[settingKey],
    );

    if (swipeAction == null) {
      return Container();
    }

    final shouldRemoveStatus =
        swipeAction != TransactionSwipeAction.delete &&
        swipeAction != TransactionSwipeAction.edit &&
        transaction.status == swipeAction.toTransactionStatus();

    final bgColor = shouldRemoveStatus
        ? nullTransactionStatus.color
        : swipeAction.color(context);
    final contrastColor = swipeAction.contrastColor(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
      decoration: BoxDecoration(color: bgColor),
      child: Column(
        crossAxisAlignment: isRight
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 2,
        children: [
          Icon(
            shouldRemoveStatus ? nullTransactionStatus.icon : swipeAction.icon,
            color: contrastColor,
            size: 28,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final showTime =
        appStateSettings[SettingKey.transactionTileShowTime] == '1';

    final tileContent = ListTile(
      title: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                Flexible(
                  child: Text(
                    transaction.displayName(context),
                    softWrap: false,
                    overflow: TextOverflow.fade,
                  ),
                ),
                if ((transaction.status != null ||
                        transaction.recurrentInfo.isRecurrent) &&
                    periodicityInfo == null) ...[
                  const SizedBox(width: 4),
                  Icon(
                    transaction.status?.icon ?? Icons.repeat,
                    color:
                        transaction.status?.color.darken(0.1) ??
                        Theme.of(context).colorScheme.primary,
                    size: 12,
                  ),
                ],
                if (transaction.isReversed) ...[
                  const SizedBox(width: 6),
                  Icon(
                    MoneyTransaction.reversedIcon,
                    size: 12,
                    color: AppColors.of(context).brand,
                  ),
                ],
              ],
            ),
          ),
          CurrencyDisplayer(
            amountToConvert: periodicityInfo != null
                ? transaction.getUnifiedMoneyForAPeriod(
                    periodicity: periodicityInfo!,
                  )
                : transaction.value,
            currency: transaction.account.currency,
            integerStyle: TextStyle(
              color: transaction.status == TransactionStatus.voided
                  ? Colors.grey.shade400
                  : transaction.isIncomeOrExpense
                  ? transaction.type.color(context)
                  : null,
              decoration: transaction.status == TransactionStatus.voided
                  ? TextDecoration.lineThrough
                  : null,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      isThreeLine: true,
      subtitle: DefaultTextStyle(
        style: Theme.of(context).textTheme.labelMedium!,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 2,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                spacing: 2,
                children: [
                  Row(
                    spacing: 4,
                    children: [
                      if (showAccount) ...[
                        IconDisplayer(
                          supportedIcon: transaction.account.icon,
                          size: 14,
                          mainColor: transaction.account
                              .getComputedColor(context)
                              .lightenPastel(
                                amount: isAppInDarkBrightness(context)
                                    ? 0.12
                                    : 0,
                              ),
                          secondaryColor: Colors.transparent,
                          padding: 0,
                        ),
                        Text(transaction.account.name),
                      ],

                      if (showDateTime && !showPeriodicityInfo) ...[
                        if (showAccount) const Text('•'),
                        Builder(
                          builder: (context) {
                            DateFormat dateFormat = DateFormat.yMMMd();

                            if (currentYear == transaction.date.year) {
                              dateFormat = DateFormat.MMMd();
                            }

                            if (showTime) {
                              dateFormat = dateFormat.add_Hm();
                            }

                            return Text(dateFormat.format(transaction.date));
                          },
                        ),
                      ],
                    ],
                  ),
                  if (transaction.notes != null &&
                      transaction.notes!.isNotEmpty)
                    Text(
                      transaction.notes!,
                      style: TextStyle(fontStyle: FontStyle.italic),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),

                  if (transaction.tags.isNotEmpty &&
                      appStateSettings[SettingKey.transactionTileShowTags] ==
                          '1') ...[
                    const SizedBox(height: 2),
                    Wrap(
                      spacing: 4,
                      runSpacing: -8,
                      children: transaction.tags
                          .map(
                            (tag) => TransactionTagChip(
                              tag: tag,
                              visualDensity: VisualDensity.compact,
                            ),
                          )
                          .toList(),
                    ),
                  ],
                ],
              ),
            ),

            // ----------------- RIGHT SIDE -----------------
            if (!showDateTime && !showPeriodicityInfo && showTime)
              Text(DateFormat.Hm().format(transaction.date)),
            if (showPeriodicityInfo)
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                spacing: 4,
                children: [
                  AnimatedExpanded(
                    expand: periodicityInfo! != transaction.intervalPeriod,
                    child: Text.rich(
                      TextSpan(
                        children: [
                          ...UINumberFormatter.currency(
                            amountToConvert: transaction.value,
                            currency: transaction.account.currency,
                          ).getTextSpanList(context),
                          if (transaction.recurrentInfo.intervalEach! != 1)
                            TextSpan(
                              text:
                                  ' / ${transaction.recurrentInfo.intervalEach!.toStringAsFixed(0)}',
                            ),
                          if (transaction.recurrentInfo.intervalEach! == 1)
                            const TextSpan(text: ' / '),
                          TextSpan(
                            text: transaction.recurrentInfo.intervalPeriod!
                                .periodText(
                                  context,
                                  isPlural:
                                      transaction.recurrentInfo.intervalEach! >
                                      1,
                                )
                                .toLowerCase(),
                          ),
                        ],
                      ),
                    ),
                  ),

                  buildNextPayStatusChip(context),
                ],
              ),
          ],
        ),
      ),
      leading: Hero(
        tag: heroTag ?? UniqueKey(),
        child: isSelected
            ? Stack(
                alignment: Alignment.center,
                children: [
                  const Icon(Icons.circle, size: 28 + 12),
                  Icon(
                    Icons.check,
                    size: 24,
                    color: Theme.of(context).colorScheme.surface,
                  ),
                ],
              )
            : transaction.getDisplayIcon(context, size: 28, padding: 6),
      ),
      selected: isSelected,
      selectedTileColor: Theme.of(
        context,
      ).colorScheme.primary.withOpacity(0.15),
      onTap:
          onTap ??
          (preventDefaultOnTap
              ? null
              : () {
                  RouteUtils.pushRoute(
                    TransactionDetailsPage(
                      transaction: transaction,
                      heroTag: heroTag,
                    ),
                  );
                }),
      onLongPress:
          onLongPress ?? () => showTransactionActions(context, transaction),
    );

    final leftAction = TransactionSwipeAction.fromString(
      appStateSettings[SettingKey.transactionSwipeLeftAction],
    );
    final rightAction = TransactionSwipeAction.fromString(
      appStateSettings[SettingKey.transactionSwipeRightAction],
    );

    if (!applySwipeActions || (leftAction == null && rightAction == null)) {
      return tileContent;
    }

    return Dismissible(
      key: Key(transaction.id),
      direction: _getDismissDirection(),
      dragStartBehavior: DragStartBehavior.down,
      background: showSwipeActionBg(
        context,
        SettingKey.transactionSwipeRightAction,
      ),
      secondaryBackground: showSwipeActionBg(
        context,
        SettingKey.transactionSwipeLeftAction,
      ),
      confirmDismiss: (direction) async {
        final action = direction == DismissDirection.startToEnd
            ? rightAction
            : direction == DismissDirection.endToStart
            ? leftAction
            : null;

        if (action == null) {
          return false;
        }

        Future.delayed(const Duration(milliseconds: 200)).then((_) async {
          await executeTransactionSwipeAction(context, transaction, action);
        });

        return false;
      },
      child: tileContent,
    );
  }

  Widget buildNextPayStatusChip(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      margin: const EdgeInsets.only(left: 2),
      decoration: BoxDecoration(
        color: transaction.nextPayStatus!.color(context).withOpacity(0.15),
        border: Border.all(
          color: transaction.nextPayStatus!.color(context),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: 4,
        children: [
          Icon(
            transaction.nextPayStatus!.icon,
            size: 14,
            color: transaction.nextPayStatus!.color(context),
          ),
          Text(
            transaction.nextPayStatus!.displayDaysToPay(
              context,
              transaction.daysToPay(),
            ),
            style: Theme.of(context).textTheme.labelSmall!.copyWith(
              color: transaction.nextPayStatus!.color(context),
            ),
          ),
        ],
      ),
    );
  }
}

Future<bool> executeTransactionSwipeAction(
  BuildContext context,
  MoneyTransaction transaction,
  TransactionSwipeAction swipeAction,
) async {
  final t = Translations.of(context);
  ScaffoldMessenger.of(context).removeCurrentSnackBar();

  switch (swipeAction) {
    case TransactionSwipeAction.delete:
      TransactionViewActionService().deleteTransactionWithAlertAndSnackBar(
        context,
        transactionId: transaction.id,
        navigateBack: false,
      );
      break;
    case TransactionSwipeAction.edit:
      await RouteUtils.pushRoute(
        TransactionFormPage(transactionToEdit: transaction),
      );

      break;
    case TransactionSwipeAction.voided:
    case TransactionSwipeAction.pending:
    case TransactionSwipeAction.reconciled:
    case TransactionSwipeAction.unreconciled:
      final trStatus = transaction.status;
      final newTrStatus = trStatus == swipeAction.toTransactionStatus()
          ? null
          : swipeAction.toTransactionStatus();

      await TransactionViewActionService().updateTransactionStatus(
        transaction.id,
        newTrStatus,
      );

      MonekinSnackbar.success(SnackbarParams(t.transaction.edit_success));
      break;
  }

  return false;
}

DismissDirection _getDismissDirection() {
  final leftSwipeStatusCode = TransactionSwipeAction.fromString(
    appStateSettings[SettingKey.transactionSwipeLeftAction],
  );

  final rightSwipeStatusCode = TransactionSwipeAction.fromString(
    appStateSettings[SettingKey.transactionSwipeRightAction],
  );

  if (leftSwipeStatusCode == null && rightSwipeStatusCode == null) {
    return DismissDirection.none;
  } else if (leftSwipeStatusCode == null) {
    return DismissDirection.startToEnd;
  } else if (rightSwipeStatusCode == null) {
    return DismissDirection.endToStart;
  }
  return DismissDirection.horizontal;
}
