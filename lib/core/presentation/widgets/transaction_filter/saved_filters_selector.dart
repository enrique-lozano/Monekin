import 'package:flutter/material.dart';
import 'package:monekin/app/categories/selectors/draggableScrollableKeyboardAware.mixin.dart';
import 'package:monekin/core/database/services/filters/saved_filters_service.dart';
import 'package:monekin/core/models/filters/saved_filter.dart';
import 'package:monekin/core/presentation/widgets/modal_container.dart';
import 'package:monekin/core/presentation/widgets/no_results.dart';
import 'package:monekin/core/presentation/widgets/transaction_filter/saved_filter_form_page.dart';
import 'package:monekin/core/presentation/widgets/transaction_filter/saved_filters_list_page.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

Future<SavedFilter?> showSavedFiltersBottomSheetSelector(BuildContext context) {
  return showModalBottomSheet<SavedFilter>(
    context: context,
    showDragHandle: true,
    isScrollControlled: true,
    builder: (context) {
      return const SavedFiltersSelector();
    },
  );
}

class SavedFiltersSelector extends StatefulWidget {
  const SavedFiltersSelector({super.key});

  @override
  State<SavedFiltersSelector> createState() => _SavedFiltersSelectorState();
}

class _SavedFiltersSelectorState extends State<SavedFiltersSelector>
    with DraggableScrollableKeyboardAware {
  String searchValue = '';

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return buildDraggableSheet(
      minChildSize: 0.64,
      defaultSize: 0.65,
      maxChildSize: 0.7,
      builder: (context, scrollController) {
        final buttonConstraints = BoxConstraints(maxHeight: 36, maxWidth: 36);

        return ModalContainer(
          title: "Saved filters",
          endWidget: IconButton.filledTonal(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const SavedFiltersListPage(),
                ),
              );
            },
            icon: const Icon(Icons.settings_rounded),
            iconSize: 18,
            constraints: buttonConstraints,
            tooltip: t.settings.title_short,
          ),
          body: StreamBuilder(
            stream: SavedFiltersService.instance.getSavedFilters(),
            builder: (context, snapshot) {
              final filterList = snapshot.data ?? [];

              final filteredFilterList = filterList.where((savedFilter) {
                if (searchValue.isEmpty) return true;
                return savedFilter.name.toLowerCase().contains(
                  searchValue.toLowerCase(),
                );
              }).toList();

              return Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      filled: false,
                      isDense: false,
                      hintText: t.currencies.search,
                      labelText: t.general.tap_to_search,
                      floatingLabelStyle: const TextStyle(height: -0.0005),
                      prefixIcon: const Icon(Icons.search),
                      border: const UnderlineInputBorder(),
                    ),
                    onChanged: (value) {
                      searchValue = value;
                      rebuild();
                    },
                  ),
                  Expanded(
                    child: Builder(
                      builder: (context) {
                        if (filteredFilterList.isEmpty) {
                          return NoResults(
                            title: "No saved filters found",
                            description:
                                "Save filters here to quickly access them later.",
                            showIllustration: false,
                            bottom: FilledButton.icon(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const SavedFilterFormPage(),
                                  ),
                                );
                              },
                              label: Text(t.ui_actions.add),
                              icon: const Icon(Icons.add),
                            ),
                          );
                        }

                        return ListView.builder(
                          controller: scrollController,
                          itemCount: filteredFilterList.length,
                          itemBuilder: (context, index) {
                            final savedFilter = filteredFilterList[index];

                            if (searchValue.isNotEmpty &&
                                !savedFilter.name.toLowerCase().contains(
                                  searchValue.toLowerCase(),
                                )) {
                              return const SizedBox.shrink();
                            }

                            return ListTile(
                              title: Text(savedFilter.name),
                              onTap: () {
                                Navigator.of(context).pop(savedFilter);
                              },
                              trailing: IconButton(
                                icon: const Icon(Icons.edit_rounded),
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => SavedFilterFormPage(
                                        savedFilter: savedFilter,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
