import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:monekin/app/categories/selectors/category_picker.dart';
import 'package:monekin/core/database/services/transaction/transaction_service.dart';
import 'package:monekin/core/models/transaction/transaction.dart';
import 'package:monekin/core/presentation/widgets/dates/outlinedButtonStacked.dart';
import 'package:monekin/core/presentation/widgets/modal_container.dart';
import 'package:monekin/core/utils/date_time_picker.dart';
import 'package:monekin/i18n/translations.g.dart';

class BulkEditTransactionModal extends StatelessWidget {
  const BulkEditTransactionModal({
    super.key,
    required this.transactionsToEdit,
    required this.onSuccess,
  });

  final List<MoneyTransaction> transactionsToEdit;

  final void Function() onSuccess;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return ModalContainer(
      title: t.transaction.edit_multiple,
      subtitle: t.transaction.list.selected_long(n: transactionsToEdit.length),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            OutlinedButtonStacked(
              text: t.transaction.list.bulk_edit.dates,
              onTap: () {
                openDateTimePicker(context, showTimePickerAfterDate: true).then(
                  (date) {
                    if (date == null) {
                      return;
                    }

                    performUpdates(
                      context,
                      futures: transactionsToEdit.map(
                        (e) => TransactionService.instance
                            .insertOrUpdateTransaction(e.copyWith(date: date)),
                      ),
                    );
                  },
                );
              },
              alignLeft: true,
              alignBeside: true,
              fontSize: 18,
              padding: const EdgeInsets.all(16),
              iconData: Icons.calendar_month,
            ),
            const SizedBox(height: 8),
            OutlinedButtonStacked(
              text: t.transaction.list.bulk_edit.categories,
              onTap: () {
                showCategoryPickerModal(context,
                        modal: const CategoryPicker(selectedCategory: null))
                    .then(
                  (modalRes) {
                    if (modalRes == null) {
                      return;
                    }

                    performUpdates(
                      context,
                      futures: transactionsToEdit.map(
                        (e) => TransactionService.instance
                            .insertOrUpdateTransaction(
                                e.copyWith(categoryID: Value(modalRes.id))),
                      ),
                    );
                  },
                );
              },
              alignLeft: true,
              alignBeside: true,
              fontSize: 18,
              padding: const EdgeInsets.all(16),
              iconData: Icons.category_rounded,
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  void performUpdates(
    BuildContext context, {
    required Iterable<Future<int>> futures,
  }) {
    Navigator.pop(context);

    Future.wait(futures).then((value) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(transactionsToEdit.length <= 1
            ? t.transaction.edit_success
            : t.transaction
                .edit_multiple_success(x: transactionsToEdit.length)),
      ));

      onSuccess();
    }).catchError((err) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(err.toString()),
      ));
    });
  }
}
