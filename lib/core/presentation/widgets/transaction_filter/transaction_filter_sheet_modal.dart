import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:monekin/core/database/app_db.dart';
import 'package:monekin/core/database/services/filters/saved_filters_service.dart';
import 'package:monekin/core/presentation/app_colors.dart';
import 'package:monekin/core/presentation/helpers/snackbar.dart';
import 'package:monekin/core/presentation/widgets/bottomSheetFooter.dart';
import 'package:monekin/core/presentation/widgets/modal_container.dart';
import 'package:monekin/core/presentation/widgets/scrollable_with_bottom_gradient.dart';
import 'package:monekin/core/presentation/widgets/transaction_filter/saved_filters_selector.dart';
import 'package:monekin/core/presentation/widgets/transaction_filter/transaction_filter_form.dart';
import 'package:monekin/core/presentation/widgets/transaction_filter/transaction_filter_set.dart';
import 'package:monekin/core/routes/route_utils.dart';
import 'package:monekin/core/utils/list_tile_action_item.dart';
import 'package:monekin/core/utils/uuid.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

Future<TransactionFilterSet?> openFilterSheetModal(
  BuildContext context,
  FilterSheetModal modalData,
) {
  return showModalBottomSheet<TransactionFilterSet>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (context) => modalData,
  );
}

class FilterSheetModal extends StatefulWidget {
  const FilterSheetModal({
    super.key,
    required this.preselectedFilter,
    this.showDateFilter = true,
  });

  final TransactionFilterSet preselectedFilter;

  final bool showDateFilter;

  @override
  State<FilterSheetModal> createState() => _FilterSheetModalState();
}

class _FilterSheetModalState extends State<FilterSheetModal> {
  late TransactionFilterSet filtersToReturn;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    filtersToReturn = widget.preselectedFilter;
  }

  Future<void> _showSaveFilterDialog(BuildContext context) async {
    final t = Translations.of(context);
    final nameController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(t.transaction.filters.saved.save_dialog_title),
        content: Form(
          key: formKey,
          child: TextFormField(
            controller: nameController,
            decoration: InputDecoration(
              labelText: t.transaction.filters.saved.name_label,
              hintText: t.transaction.filters.saved.name_hint,
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return t.general.validations.required;
              }
              return null;
            },
            autofocus: true,
            textCapitalization: TextCapitalization.sentences,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(t.ui_actions.cancel),
          ),
          TextButton(
            onPressed: () async {
              if (!formKey.currentState!.validate()) return;

              final name = nameController.text.trim();
              Navigator.of(context).pop();

              final filterSetId = generateUUID();
              final savedFilterId = generateUUID();

              final filterSetDB = filtersToReturn.toDBModel(id: filterSetId);

              final savedFilterDB = SavedFilterInDB(
                id: savedFilterId,
                name: name,
                displayOrder: 0,
                filterID: filterSetId,
              );

              final db = SavedFiltersService.instance.db;

              try {
                await db.transaction(() async {
                  await db
                      .into(db.transactionFilterSets)
                      .insertOnConflictUpdate(filterSetDB);
                  await db
                      .into(db.savedFilters)
                      .insertOnConflictUpdate(savedFilterDB);
                });

                if (context.mounted) {
                  MonekinSnackbar.success(
                    SnackbarParams(
                      t.transaction.filters.saved.save_success,
                      showAtTop: true,
                    ),
                  );
                }
              } catch (e) {
                if (context.mounted) {
                  MonekinSnackbar.error(SnackbarParams.fromError(e));
                }
              }
            },
            child: Text(t.ui_actions.save),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.85,
      maxChildSize: 0.85,
      minChildSize: 0.65,
      builder: (context, scrollController) {
        final buttonConstraints = BoxConstraints(maxHeight: 36, maxWidth: 36);

        return ModalContainer(
          title: t.general.filters,
          bodyFit: FlexFit.tight,
          endWidget: Row(
            mainAxisSize: MainAxisSize.min,
            spacing: 8,
            children: [
              IconButton.filledTonal(
                onPressed: !filtersToReturn.hasFilter
                    ? null
                    : () => _showSaveFilterDialog(context),
                icon: const Icon(Icons.save_rounded),
                iconSize: 18,
                constraints: buttonConstraints,
                tooltip: t.transaction.filters.saved.save_tooltip,
              ),
              IconButton.filledTonal(
                onPressed: () {
                  showSavedFiltersBottomSheetSelector(context).then((
                    savedFilter,
                  ) {
                    if (savedFilter == null) return;

                    setState(() {
                      filtersToReturn = TransactionFilterSet.fromDB(
                        savedFilter.filterSet,
                      );
                    });
                  });
                },
                constraints: buttonConstraints,
                iconSize: 18,
                icon: const Icon(Icons.upload_rounded),
                tooltip: t.transaction.filters.saved.load_tooltip,
              ),
            ],
          ),
          footer: BottomSheetFooter(
            submitIcon: Icons.filter_alt_outlined,
            submitText: t.ui_actions.apply,
            extraActions: [
              ListTileActionItem(
                label: t.transaction.filters.reset,
                onClick: () {
                  setState(() {
                    filtersToReturn = TransactionFilterSet();
                  });

                  HapticFeedback.mediumImpact();
                },
                icon: Icons.refresh_rounded,
              ),
            ],
            onSaved:
                !(_formKey.currentState?.validate() ?? true) ||
                    filtersToReturn.tagsIDs != null &&
                        filtersToReturn.tagsIDs!.isEmpty ||
                    filtersToReturn.accountsIDs != null &&
                        filtersToReturn.accountsIDs!.isEmpty ||
                    filtersToReturn.categoriesIds != null &&
                        filtersToReturn.categoriesIds!.isEmpty
                ? null
                : () => RouteUtils.popRoute(filtersToReturn),
          ),
          showTitleDivider: true,
          body: ScrollableWithBottomGradient(
            controller: scrollController,
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
            gradientColor: AppColors.of(context).modalBackground,
            child: Form(
              key: _formKey,
              child: TransactionFilterForm(
                filter: filtersToReturn,
                onChanged: (newFilter) {
                  setState(() {
                    filtersToReturn = newFilter;
                  });
                },
                showDateFilter: widget.showDateFilter,
              ),
            ),
          ),
        );
      },
    );
  }
}
