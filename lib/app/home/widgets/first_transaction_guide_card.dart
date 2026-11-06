import 'package:material_ui/material_ui.dart';
import 'package:monekin/app/home/widgets/new_transaction_fl_button.dart';
import 'package:monekin/core/database/services/app-data/app_data_service.dart';
import 'package:monekin/core/database/services/transaction/transaction_service.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

/// Dashboard card that invites the user to create a first transaction. Only
/// shown while there are no transactions, and until the user dismisses it.
class FirstTransactionGuideCard extends StatefulWidget {
  const FirstTransactionGuideCard({super.key});

  @override
  State<FirstTransactionGuideCard> createState() =>
      _FirstTransactionGuideCardState();
}

class _FirstTransactionGuideCardState extends State<FirstTransactionGuideCard> {
  late final Stream<int> _countStream = TransactionService.instance
      .countTransactions(convertToPreferredCurrency: false);

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

    return StreamBuilder<int>(
      stream: _countStream,
      builder: (context, snapshot) {
        if (snapshot.data != 0) return const SizedBox.shrink();

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
                  t.home.first_transaction.title,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colors.onPrimaryContainer,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  t.home.first_transaction.descr,
                  style: TextStyle(color: colors.onPrimaryContainer),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    FilledButton.icon(
                      onPressed: () => onNewTransactionButtonPressed(context),
                      icon: const Icon(Icons.add_rounded),
                      label: Text(t.home.first_transaction.action),
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
