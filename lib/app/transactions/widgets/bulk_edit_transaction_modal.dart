import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:monekin/app/categories/selectors/category_picker.dart';
import 'package:monekin/app/transactions/form/dialogs/transaction_status_selector.dart';
import 'package:monekin/core/database/services/transaction/transaction_service.dart';
import 'package:monekin/core/models/category/category.dart';
import 'package:monekin/core/models/transaction/transaction.dart';
import 'package:monekin/core/presentation/helpers/snackbar.dart';
import 'package:monekin/core/presentation/widgets/modal_container.dart';
import 'package:monekin/core/presentation/widgets/outlined_button_stacked.dart';
import 'package:monekin/core/routes/route_utils.dart';
import 'package:monekin/core/utils/date_time_picker.dart';
import 'package:monekin/i18n/generated/translations.g.dart';
import 'package:monekin/core/database/services/tags/tags_service.dart';
import 'package:monekin/core/models/tags/tag.dart';
import 'package:monekin/app/tags/tags_selector.modal.dart';

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
            _buildSelectOption(
              text: t.transaction.list.bulk_edit.dates,
              iconData: Icons.calendar_month,
              onTap: () =>
                  openDateTimePicker(
                    context,
                    showTimePickerAfterDate: true,
                  ).then((date) {
                    if (date == null) return;
                    performUpdates(
                      context,
                      futures: transactionsToEdit.map(
                        (e) => TransactionService.instance.updateTransaction(
                          e.copyWith(date: date),
                        ),
                      ),
                    );
                  }),
            ),
            const SizedBox(height: 8),
            _buildSelectOption(
              text: t.transaction.list.bulk_edit.categories,
              iconData: Icons.category_rounded,
              onTap: () {
                showCategoryPickerModal(
                  context,
                  modal: CategoryPicker(
                    selectedCategory: null,
                    categoryType: CategoryType.values,
                  ),
                ).then((modalRes) {
                  if (modalRes == null) return;
                  performUpdates(
                    context,
                    futures: transactionsToEdit.map(
                      (e) => TransactionService.instance.updateTransaction(
                        e.copyWith(categoryID: Value(modalRes.id)),
                      ),
                    ),
                  );
                });
              },
            ),
            const SizedBox(height: 8),
            _buildSelectOption(
              text: t.transaction.list.bulk_edit.status,
              iconData: Icons.fullscreen_rounded,
              onTap: () {
                showTransactionStatusModal(context, initialStatus: null).then((
                  modalRes,
                ) {
                  if (modalRes == null) return;
                  performUpdates(
                    context,
                    futures: transactionsToEdit.map(
                      (e) => TransactionService.instance.updateTransaction(
                        e.copyWith(status: Value(modalRes.result)),
                      ),
                    ),
                  );
                });
              },
            ),
            const SizedBox(height: 8),
            _buildSelectOption(
              text: t.transaction.list.bulk_edit.tags,
              iconData: Icons.label_rounded,
              onTap: () {
                final allTagSets = transactionsToEdit
                    .map((e) => e.tags)
                    .toList();

                final selectedTags = allTagSets
                    .reduce(
                      (a, b) => a
                          .where((tag) => b.any((t) => t.id == tag.id))
                          .toList(),
                    )
                    .cast<Tag?>();

                final indeterminateTags = allTagSets
                    .expand((tags) => tags)
                    .toSet()
                    .where((tag) => !selectedTags.any((s) => s?.id == tag.id))
                    .cast<Tag?>()
                    .toList();

                showTagListModal(
                  context,
                  modal: TagSelector(
                    allowEmptySubmit: true,
                    includeNullTag: false,
                    selectedTags: selectedTags,
                    indeterminateTags: indeterminateTags,
                  ),
                ).then((modalRes) {
                  if (modalRes == null) return;

                  final tagsToAdd = modalRes.selectedTags
                      .whereType<Tag>()
                      .toList();

                  final tagsToRemove = [
                    ...selectedTags.whereType<Tag>().where(
                      (t) => !modalRes.selectedTags.any((s) => s?.id == t.id),
                    ),
                    ...modalRes.explicitlyRemovedTags.whereType<Tag>(),
                  ];

                  performUpdates(
                    context,
                    futures: transactionsToEdit.map((e) {
                      final finalTagIds = {
                        ...e.tags.map((t) => t.id),
                        ...tagsToAdd.map((t) => t.id),
                      }..removeAll(tagsToRemove.map((t) => t.id));

                      return TagService.instance
                          .unlinkTagsFromTransaction(transactionId: e.id)
                          .then(
                            (_) => TagService.instance.linkTagsToTransaction(
                              transactionId: e.id,
                              tagIds: finalTagIds.toList(),
                            ),
                          );
                    }),
                  );
                });
              },
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

  OutlinedButtonStacked _buildSelectOption({
    required void Function()? onTap,
    required String text,
    required IconData iconData,
  }) {
    return OutlinedButtonStacked(
      text: text,
      onTap: onTap,
      alignLeft: true,
      alignBeside: true,
      fontSize: 18,
      padding: const EdgeInsets.all(16),
      iconData: iconData,
    );
  }

  void performUpdates(
    BuildContext context, {
    required Iterable<Future> futures,
  }) {
    RouteUtils.popRoute();

    Future.wait(futures)
        .then((_) {
          MonekinSnackbar.success(
            transactionsToEdit.length <= 1
                ? SnackbarParams(t.transaction.edit_success)
                : SnackbarParams(
                    t.transaction.edit_multiple_success(
                      x: transactionsToEdit.length,
                    ),
                  ),
          );
          onSuccess();
        })
        .catchError((err) {
          MonekinSnackbar.error(SnackbarParams.fromError(err));
        });
  }
}
