import 'package:flutter/material.dart';
import 'package:monekin/app/layout/page_framework.dart';
import 'package:monekin/core/database/app_db.dart';
import 'package:monekin/core/database/services/filters/saved_filters_service.dart';
import 'package:monekin/core/models/filters/saved_filter.dart';
import 'package:monekin/core/presentation/widgets/persistent_footer_button.dart';
import 'package:monekin/core/presentation/widgets/transaction_filter/transaction_filter_form.dart';
import 'package:monekin/core/presentation/widgets/transaction_filter/transaction_filters.dart';
import 'package:monekin/core/utils/uuid.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

class SavedFilterFormPage extends StatefulWidget {
  const SavedFilterFormPage({super.key, this.savedFilter, this.initialFilter});

  final SavedFilter? savedFilter;
  final TransactionFilterSet? initialFilter;

  @override
  State<SavedFilterFormPage> createState() => _SavedFilterFormPageState();
}

class _SavedFilterFormPageState extends State<SavedFilterFormPage> {
  late TransactionFilterSet _currentFilter;
  late TextEditingController _nameController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    if (widget.savedFilter != null) {
      _currentFilter = TransactionFilterSet.fromDB(
        widget.savedFilter!.filterSet,
      );
    } else {
      _currentFilter = widget.initialFilter ?? const TransactionFilterSet();
    }

    _nameController = TextEditingController(text: widget.savedFilter?.name);
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    final name = _nameController.text.trim();

    // Ensure we have IDs
    final filterSetId = widget.savedFilter?.filterSet.id ?? generateUUID();
    final savedFilterId = widget.savedFilter?.id ?? generateUUID();

    final filterSetDB = _currentFilter.toDBModel(id: filterSetId);

    final savedFilterDB = SavedFilterInDB(
      id: savedFilterId,
      name: name,
      displayOrder: widget.savedFilter?.displayOrder ?? 0,
      filterID: filterSetId,
    );

    final db = SavedFiltersService.instance.db;

    await db.transaction(() async {
      await db
          .into(db.transactionFilterSets)
          .insertOnConflictUpdate(filterSetDB);
      await db.into(db.savedFilters).insertOnConflictUpdate(savedFilterDB);
    });

    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  Future<void> _delete() async {
    final t = Translations.of(context);
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(t.ui_actions.delete),
        content: Text(t.ui_actions.delete),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(t.ui_actions.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(t.ui_actions.delete),
          ),
        ],
      ),
    );

    if (confirm == true) {
      await SavedFiltersService.instance.deleteSavedFilter(
        widget.savedFilter!.id,
      );
      if (mounted) {
        Navigator.of(context).pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final isEditing = widget.savedFilter != null;

    return PageFramework(
      title: isEditing ? "Edit Filter" : "New Filter",
      appBarActions: [
        if (isEditing)
          IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: _delete,
            tooltip: t.ui_actions.delete,
          ),
      ],
      persistentFooterButtons: [
        PersistentFooterButton(
          child: FilledButton.icon(
            onPressed: _save,
            icon: const Icon(Icons.save),
            label: Text(t.ui_actions.save),
          ),
        ),
      ],
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: "Filter Name", // TODO: Add translation
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return t.general.validations.required;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              Text(
                t.general.filters,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              TransactionFilterForm(
                filter: _currentFilter,
                onChanged: (newFilter) {
                  setState(() {
                    _currentFilter = newFilter;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
