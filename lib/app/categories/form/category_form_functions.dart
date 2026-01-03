import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:monekin/app/categories/selectors/category_picker.dart';
import 'package:monekin/app/categories/subcategory_form.dart';
import 'package:monekin/core/database/services/category/category_service.dart';
import 'package:monekin/core/database/services/transaction/transaction_service.dart';
import 'package:monekin/core/extensions/color.extensions.dart';
import 'package:monekin/core/models/category/category.dart';
import 'package:monekin/core/models/supported-icon/supported_icon.dart';
import 'package:monekin/core/presentation/helpers/snackbar.dart';
import 'package:monekin/core/presentation/widgets/confirm_dialog.dart';
import 'package:monekin/core/presentation/widgets/html_text.dart';
import 'package:monekin/core/presentation/widgets/transaction_filter/transaction_filters.dart';
import 'package:monekin/core/routes/route_utils.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

import '../../../core/services/supported_icon/supported_icon_service.dart';

class CategoryFormFunctions {
  static void deleteCategory(BuildContext context, String categoryId) {
    final t = Translations.of(context);

    confirmDialog(
      context,
      dialogTitle: t.categories.delete_warning_header,
      icon: Icons.delete,
      contentParagraphs: [
        StreamBuilder(
          stream: TransactionService.instance
              .getTransactionsFromPredicate(
                predicate:
                    (
                      transaction,
                      account,
                      accountCurrency,
                      receivingAccount,
                      receivingAccountCurrency,
                      c,
                      p6,
                    ) =>
                        c.id.isValue(categoryId) |
                        c.parentCategoryID.isValue(categoryId),
              )
              .map((event) => event.length),
          initialData: 0,
          builder: (context, snapshot) {
            return HTMLText(
              htmlString: t.categories.delete_warning_message(
                x: snapshot.data!,
              ),
              tags: const {'b': TextStyle(fontWeight: FontWeight.bold)},
            );
          },
        ),
      ],
    ).then((isConfirmed) {
      if (isConfirmed != true) return;

      CategoryService.instance
          .deleteCategory(categoryId)
          .then((value) {
            MonekinSnackbar.success(
              SnackbarParams(t.categories.delete_success),
            );

            RouteUtils.popRoute();
          })
          .catchError((error) {
            MonekinSnackbar.error(SnackbarParams.fromError(error));
          });
    });
  }

  static void mergeCategory(BuildContext context, Category category) {
    final t = Translations.of(context);

    showCategoryPickerModal(
      context,
      modal: CategoryPicker(
        categoryType: [category.type, CategoryType.B],
        excludeCategoriesWithId: [category.id],
        selectedCategory: null,
      ),
    ).then((selCategory) {
      if (selCategory == null) {
        return;
      }

      confirmDialog(
        context,
        dialogTitle: t.categories.merge,
        icon: Icons.merge_type_rounded,
        contentParagraphs: [
          StreamBuilder(
            stream: TransactionService.instance
                .getTransactions(
                  filters: TransactionFilterSet(
                    categoriesIds: [category.id],
                    includeParentCategoriesInSearch: true,
                  ),
                )
                .map((event) => event.length),
            initialData: 0,
            builder: (context, snapshot) {
              return HTMLText(
                htmlString: t.categories.merge_warning1(
                  destiny: selCategory.name,
                  from: category.name,
                  x: snapshot.data!,
                ),
                tags: const {'b': TextStyle(fontWeight: FontWeight.bold)},
              );
            },
          ),
          HTMLText(
            htmlString: t.categories.merge_warning2(from: category.name),
            tags: const {'b': TextStyle(fontWeight: FontWeight.bold)},
          ),
        ],
      ).then((isConfirmed) async {
        if (isConfirmed != true) return;

        List<Future<int>> futures = [];

        futures.add(CategoryService.instance.deleteCategory(category.id));

        for (final tr
            in await TransactionService.instance
                .getTransactions(
                  filters: TransactionFilterSet(
                    categoriesIds: [category.id],
                    includeParentCategoriesInSearch: true,
                  ),
                )
                .first) {
          futures.add(
            TransactionService.instance.updateTransaction(
              tr.copyWith(categoryID: drift.Value(selCategory.id)),
            ),
          );
        }

        await Future.wait(futures);

        RouteUtils.popRoute();
        MonekinSnackbar.success(SnackbarParams(t.categories.merge_success));
      });
    });
  }

  static void makeMainCategory(BuildContext context, Category category) {
    if (category.isMainCategory) return;

    CategoryService.instance.updateCategory(
      category.copyWith(parentCategoryID: const drift.Value(null)),
    );

    MonekinSnackbar.success(SnackbarParams(t.categories.create_success));
  }

  static void makeSubcategory(BuildContext context, Category category) {
    if (category.isChildCategory) return;

    showCategoryPickerModal(
      context,
      modal: CategoryPicker(
        categoryType: [category.type, CategoryType.B],
        selectedCategory: null,
        excludeCategoriesWithId: [category.id],
        showSubcategories: false,
      ),
    ).then((selCategory) {
      if (selCategory == null) {
        return;
      }

      confirmDialog(
        context,
        dialogTitle: t.categories.make_child,
        contentParagraphs: [
          HTMLText(
            htmlString: t.categories.make_child_warning1(
              destiny: selCategory.name,
            ),
            tags: const {'b': TextStyle(fontWeight: FontWeight.bold)},
          ),
          StreamBuilder(
            stream: TransactionService.instance
                .getTransactions(
                  filters: TransactionFilterSet(
                    categoriesIds: [category.id],
                    includeParentCategoriesInSearch: true,
                  ),
                )
                .map((event) => event.length),
            initialData: 0,
            builder: (context, snapshot) {
              return HTMLText(
                htmlString: t.categories.make_child_warning2(
                  destiny: selCategory.name,
                  x: snapshot.data!,
                ),
                tags: const {'b': TextStyle(fontWeight: FontWeight.bold)},
              );
            },
          ),
        ],
      ).then((isConfirmed) async {
        if (isConfirmed != true) return;

        List<Future<bool>> futures = [];

        futures.add(
          CategoryService.instance.updateCategory(
            category.copyWith(
              parentCategoryID: drift.Value(selCategory.id),
              color: const drift.Value(null),
              type: const drift.Value(null),
            ),
          ),
        );

        for (final subcategory
            in await CategoryService.instance
                .getChildCategories(parentId: category.id)
                .first) {
          futures.add(
            CategoryService.instance.updateCategory(
              subcategory.copyWith(
                parentCategoryID: drift.Value(selCategory.id),
                color: const drift.Value(null),
                type: const drift.Value(null),
              ),
            ),
          );
        }

        await Future.wait(futures);

        RouteUtils.popRoute();
        MonekinSnackbar.success(
          SnackbarParams(t.categories.make_child_success),
        );
      });
    });
  }

  static void openSubcategoryForm(
    BuildContext context, {
    required void Function(String, SupportedIcon) onSubmit,
    required String color,
    Category? subcategory,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (context) {
        return SubcategoryFormDialog(
          name: subcategory?.name ?? '',
          color: ColorHex.get(color),
          icon:
              subcategory?.icon ??
              SupportedIconService.instance.defaultSupportedIcon,
          onSubmit: onSubmit,
        );
      },
    );
  }
}
