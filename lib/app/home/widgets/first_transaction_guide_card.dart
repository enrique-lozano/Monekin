import 'package:material_ui/material_ui.dart';
import 'package:monekin/app/accounts/account_form.dart';
import 'package:monekin/app/home/widgets/new_transaction_fl_button.dart';
import 'package:monekin/core/database/services/app-data/app_data_service.dart';
import 'package:monekin/core/database/services/transaction/transaction_service.dart';
import 'package:monekin/core/routes/route_utils.dart';
import 'package:monekin/i18n/generated/translations.g.dart';
import 'package:rxdart/rxdart.dart';

/// Dashboard card that invites the user to create a first transaction (or the
/// account needed for it). Only shown while there are no transactions, and
/// until the user dismisses it.
class FirstTransactionGuideCard extends StatefulWidget {
  const FirstTransactionGuideCard({super.key});

  @override
  State<FirstTransactionGuideCard> createState() =>
      _FirstTransactionGuideCardState();
}

class _FirstTransactionGuideCardState extends State<FirstTransactionGuideCard> {
  /// Number of transactions and whether there is an account to create them in
  late final Stream<(int, bool)> _stateStream = Rx.combineLatest2(
    TransactionService.instance.countTransactions(
      convertToPreferredCurrency: false,
    ),
    TransactionService.instance.checkIfCreateTransactionIsPossible(),
    (int count, bool hasAccount) => (count, hasAccount),
  );

  bool get _dismissed =>
      appStateData[AppDataKey.firstTransactionGuideDismissed] == '1';

  Future<void> _dismiss() async {
    await AppDataService.instance.setItem(
      AppDataKey.firstTransactionGuideDismissed,
      '1',
      updateGlobalState: true,
    );

    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (_dismissed) return const SizedBox.shrink();

    return StreamBuilder<(int, bool)>(
      stream: _stateStream,
      builder: (context, snapshot) {
        final state = snapshot.data;

        if (state == null || state.$1 != 0) return const SizedBox.shrink();

        final hasAccount = state.$2;

        final colors = Theme.of(context).colorScheme;

        return Card(
          color: colors.primaryContainer,
          elevation: 0,
          margin: const EdgeInsets.only(bottom: 16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  hasAccount
                      ? t.home.first_transaction.title
                      : t.home.first_transaction.account_title,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colors.onPrimaryContainer,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  hasAccount
                      ? t.home.first_transaction.descr
                      : t.home.first_transaction.account_descr,
                  style: TextStyle(color: colors.onPrimaryContainer),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    FilledButton.icon(
                      onPressed: hasAccount
                          ? () => onNewTransactionButtonPressed(context)
                          : () => RouteUtils.showResponsiveForm(
                              const AccountFormPage(),
                            ),
                      icon: const Icon(Icons.add_rounded),
                      label: Text(
                        hasAccount
                            ? t.home.first_transaction.action
                            : t.home.first_transaction.account_action,
                      ),
                    ),
                    TextButton(
                      onPressed: _dismiss,
                      child: Text(t.home.first_transaction.dismiss),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
