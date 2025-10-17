import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:monekin/app/transactions/transaction_details.page.dart';
import 'package:monekin/core/database/services/user-setting/enum/transaction-swipe-actions.enum.dart';
import 'package:monekin/core/database/services/user-setting/user_setting_service.dart';
import 'package:monekin/core/extensions/color.extensions.dart';
import 'package:monekin/core/models/date-utils/periodicity.dart';
import 'package:monekin/core/models/transaction/transaction.dart';
import 'package:monekin/core/models/transaction/transaction_status.enum.dart';
import 'package:monekin/core/presentation/widgets/number_ui_formatters/currency_displayer.dart';
import 'package:monekin/core/presentation/widgets/number_ui_formatters/ui_number_formatter.dart';
import 'package:monekin/core/routes/route_utils.dart';
import 'package:monekin/core/services/view-actions/transaction_view_actions_service.dart';

import '../../../core/presentation/app_colors.dart';

class TransactionListTile extends StatelessWidget {
  const TransactionListTile({
    super.key,
    required this.transaction,
    required this.prevPage,
    this.showDate = true,
    this.showTime = true,
    this.periodicityInfo,
    required this.heroTag,
    this.onLongPress,
    this.onTap,
    this.isSelected = false,
    this.applySwipeActions = false,
  });

  final MoneyTransaction transaction;

  final Widget prevPage;
  final Periodicity? periodicityInfo;
  final bool showDate;
  final bool showTime;

  final Object? heroTag;

  final bool applySwipeActions;

  /// Action to trigger when the tile is long pressed. If `null`,
  /// the tile will display a modal with some quick actions for
  /// this transaction
  final void Function()? onLongPress;

  /// Action to trigger when the tile is pressed. If `null`,
  /// the tile will redirect to the `transaction-details-page`
  final void Function()? onTap;

  final bool isSelected;

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
                          Navigator.pop(context);
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

    final contrastColor = Colors.white;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(color: swipeAction.color(context)),
      child: Row(
        mainAxisAlignment: isRight
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: [
          Text(
            swipeAction.displayName(context),
            style: TextStyle(color: contrastColor),
          ),
          const SizedBox(width: 5),
          Icon(swipeAction.icon, color: contrastColor),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(transaction.id),
      direction: getDismissDirection(),
      background: showSwipeActionBg(
        context,
        SettingKey.transactionSwipeLeftAction,
      ),
      secondaryBackground: showSwipeActionBg(
        context,
        SettingKey.transactionSwipeRightAction,
      ),
      confirmDismiss: (direction) async {
        return false;
      },
      child: ListTile(
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
        subtitle: DefaultTextStyle(
          style: Theme.of(
            context,
          ).textTheme.labelSmall!.copyWith(fontWeight: FontWeight.w300),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Builder(
                        builder: (context) {
                          String secondaryText = '';

                          if (!(transaction.recurrentInfo.isRecurrent &&
                              periodicityInfo != null)) {
                            if (showDate) {
                              secondaryText = DateFormat.yMMMd().format(
                                transaction.date,
                              );
                            } else {
                              secondaryText = transaction.notes ?? '';
                            }
                          }

                          return Text(
                            '${transaction.account.name} ${secondaryText.isNotEmpty ? ('• $secondaryText') : ''}',
                            softWrap: false,
                            overflow: TextOverflow.fade,
                          );
                        },
                      ),
                    ),
                    if (transaction.recurrentInfo.isRecurrent &&
                        periodicityInfo != null) ...[
                      const SizedBox(width: 4),
                      Container(
                        padding: const EdgeInsets.fromLTRB(6, 0, 6, 0),
                        decoration: BoxDecoration(
                          color: transaction.nextPayStatus!
                              .color(context)
                              .withOpacity(0.2),
                          border: Border.all(
                            color: transaction.nextPayStatus!.color(context),
                            width: 0.2,
                          ),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Row(
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
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: transaction.nextPayStatus!.color(
                                  context,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 2),
                    ],
                  ],
                ),
              ),
              if (showTime) Text(DateFormat.Hm().format(transaction.date)),
              if (periodicityInfo != null &&
                  transaction.recurrentInfo.isRecurrent)
                Text.rich(
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
                                  transaction.recurrentInfo.intervalEach! > 1,
                            )
                            .toLowerCase(),
                      ),
                    ],
                  ),
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
            () {
              RouteUtils.pushRoute(
                context,
                TransactionDetailsPage(
                  transaction: transaction,
                  heroTag: heroTag,
                  prevPage: prevPage,
                ),
              );
            },
        onLongPress:
            onLongPress ?? () => showTransactionActions(context, transaction),
      ),
    );
  }
}

DismissDirection getDismissDirection() {
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
