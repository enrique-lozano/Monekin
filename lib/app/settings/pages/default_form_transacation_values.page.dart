import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:monekin/app/categories/selectors/category_picker.dart';
import 'package:monekin/app/layout/page_framework.dart';
import 'package:monekin/app/settings/widgets/monekin_tile_switch.dart';
import 'package:monekin/app/settings/widgets/settings_list_separator.dart';
import 'package:monekin/app/tags/tags_selector.modal.dart';
import 'package:monekin/core/database/services/category/category_service.dart';
import 'package:monekin/core/database/services/tags/tags_service.dart';
import 'package:monekin/core/database/services/user-setting/default_transaction_values.service.dart';
import 'package:monekin/core/extensions/padding.extension.dart';
import 'package:monekin/core/models/category/category.dart';
import 'package:monekin/core/models/supported-icon/icon_displayer.dart';
import 'package:monekin/core/models/tags/tag.dart';
import 'package:monekin/core/models/transaction/transaction_form_field.enum.dart';
import 'package:monekin/core/models/transaction/transaction_status.enum.dart';
import 'package:monekin/core/presentation/animations/animated_expanded.dart';
import 'package:monekin/core/presentation/animations/scaled_animated_switcher.dart';
import 'package:monekin/core/presentation/widgets/dynamic_selector_modal.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

class DefaultFormTransactionValuesPage extends StatelessWidget {
  const DefaultFormTransactionValuesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return PageFramework(
      title: "New Transaction: Default Form Values",
      body: StreamBuilder(
        stream: DefaultTransactionValuesService.instance.getAllSettings(),
        builder: (context, snapshot) {
          final data = snapshot.data;
          if (data == null) return const SizedBox();

          final values = data.values;
          final lastUsedFields = data.lastUsedFields;

          return SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 16).withSafeBottom(context),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MonekinTileSwitch(
                  title: "Reuse Last Transaction Values",
                  subtitle:
                      "Automatically fill the form with some values from the last created transaction",
                  initialValue: lastUsedFields.isNotEmpty,
                  onSwitch: (value) {
                    if (value) {
                      DefaultTransactionValuesService.instance
                          .updateFieldsToUseLastUsedValue([
                            TransactionFormField.account,
                            TransactionFormField.category,
                            TransactionFormField.status,
                          ]);
                    } else {
                      DefaultTransactionValuesService.instance
                          .updateFieldsToUseLastUsedValue([]);
                    }
                  },
                ),
                AnimatedExpanded(
                  expand: lastUsedFields.isNotEmpty,
                  child: ListTile(
                    title: const Text("Fields to reuse"),
                    subtitle: Text(
                      lastUsedFields
                          .map((e) => e.displayName(context))
                          .join(", "),
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios_rounded),
                    onTap: () => _selectLastUsedFields(context, lastUsedFields),
                  ),
                ),
                createListSeparator(context, "Default Form Values"),
                _buildCategoryTile(context, values),
                _buildStatusTile(context, values),
                _buildTagsTile(context, values),
              ],
            ),
          );
        },
      ),
    );
  }

  void _selectLastUsedFields(
    BuildContext context,
    List<TransactionFormField> currentSelection,
  ) async {
    final selected =
        await showDynamicMultiSelectorBottomSheet<
          TransactionFormField,
          TransactionFormField
        >(
          context,
          selectorWidget: DynamicMultiSelectorModal(
            title: "Reuse Last Values",
            subtitle:
                "Select the fields that should be pre-filled with the values from the last created transaction.",
            items: TransactionFormField.values,
            selectedValues: currentSelection,
            displayNameGetter: (f) => f.displayName(context),
            valueGetter: (f) => f,
            trailingIconGetter: (f) => f.icon,
          ),
        );

    if (selected != null && selected.result != null) {
      DefaultTransactionValuesService.instance.updateFieldsToUseLastUsedValue(
        selected.result!,
      );
    }
  }

  Widget _buildCategoryTile(
    BuildContext context,
    DefaultTransactionValues values,
  ) {
    return StreamBuilder<Category?>(
      stream: CategoryService.instance.getCategoryById(values.categoryId ?? ''),
      builder: (context, snapshot) {
        final category = snapshot.data ?? Category.unkown();

        return ListTile(
          title: const Text("Default Category"),
          subtitle: Text(category.name),
          leading: IconDisplayer.fromCategory(
            context,
            category: category,
            size: 18,
          ),
          trailing: snapshot.data == null
              ? null
              : IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    DefaultTransactionValuesService.instance.updateValues(
                      values.copyWith(forceCategoryNull: true),
                    );
                  },
                ),
          onTap: () => _selectCategory(context, values),
        );
      },
    );
  }

  Future<void> _selectCategory(
    BuildContext context,
    DefaultTransactionValues values,
  ) async {
    final selected = await showCategoryPickerModal(
      context,
      modal: CategoryPicker(
        selectedCategory: null,
        categoryType: const [CategoryType.E, CategoryType.I],
      ),
    );

    if (selected != null) {
      DefaultTransactionValuesService.instance.updateValues(
        values.copyWith(categoryId: selected.id),
      );
    }
  }

  Widget _buildStatusTile(
    BuildContext context,
    DefaultTransactionValues values,
  ) {
    final status = values.status;

    return ListTile(
      title: const Text("Default Status"),
      subtitle: Text(status.displayName(context)),
      leading: Icon(status.icon, size: 24, color: status.color),
      onTap: () => _selectStatus(context, values),
    );
  }

  Future<void> _selectStatus(
    BuildContext context,
    DefaultTransactionValues values,
  ) async {
    final selected =
        await showDynamicSelectorBottomSheet<
          TransactionStatus?,
          TransactionStatus?
        >(
          context,
          selectorWidget: DynamicSelectorModal(
            title: "Default Status",
            items: [null, ...TransactionStatus.values],
            selectedValue: values.status,
            displayNameGetter: (s) => s.displayName(context),
            valueGetter: (s) => s,
            trailingIconGetter: (s) => s.icon,
          ),
        );

    if (selected != null) {
      DefaultTransactionValuesService.instance.updateValues(
        values.copyWith(rawStatus: selected.result?.name),
      );
    }
  }

  Widget _buildTagsTile(BuildContext context, DefaultTransactionValues values) {
    return StreamBuilder<List<Tag>>(
      stream: TagService.instance.getTags(
        filter: (t) {
          if (values.tagIds == null || values.tagIds!.isEmpty) {
            return const drift.CustomExpression<bool>('FALSE');
          }
          return t.id.isIn(values.tagIds!);
        },
      ),
      builder: (context, snapshot) {
        final tags = snapshot.data ?? [];

        return ListTile(
          title: const Text("Default Tags"),
          subtitle: Text(
            tags.isEmpty
                ? "No tags selected"
                : tags.map((e) => e.name).join(", "),
          ),
          leading: ScaledAnimatedSwitcher(
            keyToWatch: tags.isEmpty.toString(),
            child: Icon(
              tags.isEmpty ? Icons.label_outline_rounded : Icons.label_rounded,
            ),
          ),
          trailing: tags.isEmpty
              ? null
              : IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    DefaultTransactionValuesService.instance.updateValues(
                      values.copyWith(forceTagsNull: true),
                    );
                  },
                ),
          onTap: () => _selectTags(context, values, tags),
        );
      },
    );
  }

  Future<void> _selectTags(
    BuildContext context,
    DefaultTransactionValues values,
    List<Tag> currentTags,
  ) async {
    final selected = await showTagListModal(
      context,
      modal: TagSelector(
        selectedTags: currentTags,
        allowEmptySubmit: true,
        includeNullTag: false,
      ),
    );

    if (selected != null) {
      DefaultTransactionValuesService.instance.updateValues(
        values.copyWith(
          tagIds: selected.whereType<Tag>().map((e) => e.id).toList(),
        ),
      );
    }
  }
}
