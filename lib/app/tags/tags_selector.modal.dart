import 'package:collection/collection.dart';
import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:monekin/app/categories/selectors/draggableScrollableKeyboardAware.mixin.dart';
import 'package:monekin/core/database/services/tags/tags_service.dart';
import 'package:monekin/core/extensions/string.extension.dart';
import 'package:monekin/core/models/tags/tag.dart';
import 'package:monekin/core/presentation/app_colors.dart';
import 'package:monekin/core/presentation/widgets/bottomSheetFooter.dart';
import 'package:monekin/core/presentation/widgets/count_indicator.dart';
import 'package:monekin/core/presentation/widgets/modal_container.dart';
import 'package:monekin/core/presentation/widgets/scrollable_with_bottom_gradient.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

Future<List<Tag?>?> showTagListModal(
  BuildContext context, {
  required TagSelector modal,
}) {
  return showModalBottomSheet<List<Tag?>>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (context) {
      return modal;
    },
  );
}

class TagSelector extends StatefulWidget {
  const TagSelector({
    super.key,
    this.selectedTags = const [],
    required this.allowEmptySubmit,
    required this.includeNullTag,
  });

  final List<Tag?> selectedTags;

  final bool allowEmptySubmit;

  final bool includeNullTag;

  @override
  State<TagSelector> createState() => _TagSelectorState();
}

class _TagSelectorState extends State<TagSelector>
    with DraggableScrollableKeyboardAware {
  late List<Tag?> selectedTags;

  String searchValue = '';
  @override
  void initState() {
    super.initState();

    selectedTags = [...widget.selectedTags];
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return buildDraggableSheet(
        minChildSize: 0.64,
        defaultSize: 0.65,
        builder: (context, scrollController) {
          return ModalContainer(
            title: t.tags.select.title,
            titleBuilder: selectedTags.isEmpty
                ? null
                : (title) {
                    return Row(
                      children: [
                        Text(title),
                        const SizedBox(width: 12),
                        CountIndicator(selectedTags.length),
                      ],
                    );
                  },
            body: StreamBuilder(
                stream: TagService.instance.getTags(
                  filter: (p0) => p0.name.contains(searchValue),
                ),
                builder: (context, snapshot) {
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
                      buildSelectAllButton(snapshot),
                      buildTagList(snapshot, scrollController),
                    ],
                  );
                }),
            footer: BottomSheetFooter(
              onSaved: selectedTags.isNotEmpty || widget.allowEmptySubmit
                  ? () => Navigator.of(context).pop(selectedTags)
                  : null,
            ),
          );
        });
  }

  Widget buildTagList(
    AsyncSnapshot<List<Tag>> snapshot,
    ScrollController scrollController,
  ) {
    if (!snapshot.hasData) {
      return const LinearProgressIndicator();
    }

    final allTags =
        widget.includeNullTag ? [null, ...snapshot.data!] : snapshot.data!;

    if (allTags.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(16),
        child: Text(
          t.account.no_accounts,
          textAlign: TextAlign.center,
        ),
      );
    }

    return Expanded(
      child: Stack(
        children: [
          // TODO : Shrink list??
          ListView.separated(
            controller: scrollController,
            itemCount: snapshot.data!.length + (widget.includeNullTag ? 1 : 0),
            itemBuilder: (context, index) {
              final tag = allTags.elementAt(index);

              if (tag == null) {
                return CheckboxListTile.adaptive(
                  value: selectedTags.any((element) => element == null),
                  secondary: Icon(
                    Icons.label_off_rounded,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  title: Text(t.tags.without_tags),
                  onChanged: (newValue) {
                    if (newValue == null) return;

                    if (!newValue) {
                      selectedTags
                          .removeWhere((element) => element?.id == null);
                    } else {
                      selectedTags.add(null);
                    }

                    rebuild();
                  },
                );
              }

              // TAG NOT NULL --> Rest of the tags:

              return CheckboxListTile.adaptive(
                value: selectedTags.any((element) =>
                    element != null && element.id == tag.id || element == tag),
                secondary: tag.displayIcon(),
                title: Text(tag.name),
                subtitle: !tag.description.isNullOrEmpty
                    ? Text(tag.description!)
                    : null,
                onChanged: (newValue) {
                  if (newValue == null) return;

                  if (!newValue) {
                    selectedTags
                        .removeWhere((element) => element?.id == tag.id);
                  } else {
                    selectedTags.add(tag);
                  }

                  rebuild();
                },
              );
            },
            separatorBuilder: (context, index) => const Divider(),
          ),
          ScrollableWithBottomGradient.buildPositionedGradient(
              Theme.of(context).colorSchemeExtended.modalBackground),
        ],
      ),
    );
  }

  Widget buildSelectAllButton(AsyncSnapshot<List<Tag>> snapshot) {
    final filteredTags = [
      if (widget.includeNullTag) null,
      if (snapshot.hasData) ...snapshot.data!
    ];

    final filteredSelectedTags = selectedTags
        .where((selAcc) =>
            selAcc == null ||
            filteredTags.nonNulls.map((e) => e.id).contains(selAcc.id))
        .toList();

    return CheckboxListTile(
      value: filteredSelectedTags.isEmpty
          ? false
          : filteredSelectedTags.length == filteredTags.length
              ? true
              : null,
      tristate: true,
      title: Text(
        t.ui_actions.select_all,
        style: const TextStyle(fontWeight: FontWeight.w700),
      ),
      enabled: snapshot.hasData && snapshot.data!.isNotEmpty,
      onChanged: (value) {
        if (value == true) {
          selectedTags.addAll(filteredTags.whereNot(
              (e) => selectedTags.map((selAcc) => selAcc?.id).contains(e?.id)));
        } else {
          selectedTags.removeWhere(
              (selAcc) => filteredTags.map((e) => e?.id).contains(selAcc?.id));
        }

        rebuild();
      },
    );
  }
}
