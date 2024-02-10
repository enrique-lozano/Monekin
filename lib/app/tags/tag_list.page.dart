import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:monekin/app/accounts/all_accounts_page.dart';
import 'package:monekin/core/database/services/tags/tags_service.dart';
import 'package:monekin/core/models/tags/tag.dart';
import 'package:monekin/core/presentation/app_colors.dart';
import 'package:monekin/core/presentation/widgets/bottomSheetFooter.dart';
import 'package:monekin/core/presentation/widgets/empty_indicator.dart';
import 'package:monekin/core/presentation/widgets/modal_container.dart';
import 'package:monekin/core/presentation/widgets/monekin_reorderable_list.dart';
import 'package:monekin/core/presentation/widgets/scrollable_with_bottom_gradient.dart';
import 'package:monekin/core/presentation/widgets/tappable.dart';
import 'package:monekin/core/routes/app_router.dart';
import 'package:monekin/i18n/translations.g.dart';

Future<List<Tag>?> showTagListModal(
  BuildContext context, {
  List<Tag> selectedTags = const <Tag>[],
}) {
  return showModalBottomSheet<List<Tag>>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (context) {
      return DraggableScrollableSheet(
          expand: false,
          maxChildSize: 0.85,
          minChildSize: 0.65,
          initialChildSize: 0.65,
          builder: (context, scrollController) {
            return TagListPage(
              isModal: true,
              scrollController: scrollController,
              selected: selectedTags,
            );
          });
    },
  );
}

@RoutePage()
class TagListPage extends StatefulWidget {
  const TagListPage({
    super.key,
    this.isModal = false,
    this.selected = const <Tag>[],
    this.scrollController,
  });

  final bool isModal;
  final List<Tag> selected;

  final ScrollController? scrollController;

  @override
  State<TagListPage> createState() => _TagListPageState();
}

class _TagListPageState extends State<TagListPage> {
  late List<Tag> selectedTags;

  @override
  void initState() {
    super.initState();

    selectedTags = [...widget.selected];
  }

  Widget buildList() {
    return StreamBuilder(
      stream: TagService.instance.getTags(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const LinearProgressIndicator();
        }

        if (snapshot.data!.isEmpty) {
          return EmptyIndicator(
            title: t.general.empty_warn,
            description: t.tags.empty_list,
          );
        }

        final tags = snapshot.data!;

        if (!widget.isModal) {
          return MonekinReorderableList(
            totalItemCount: tags.length,
            itemBuilder: (context, index) {
              final tag = tags.elementAt(index);

              return Tappable(
                onTap: () => context.pushRoute(TagFormRoute(tag: tag)),
                bgColor: AppColors.of(context).light,
                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                borderRadius: 12,
                child: ListTile(
                  trailing: tags.length > 1
                      ? ReorderableDragIcon(index: index)
                      : null,
                  leading: tag.displayIcon(),
                  title: Text(tag.name),
                  subtitle:
                      tag.description != null && tag.description!.isNotEmpty
                          ? Text(tag.description!)
                          : null,
                ),
              );
            },
            onReorder: (from, to) async {
              if (to > from) to--;

              final item = tags.removeAt(from);
              tags.insert(to, item);

              Future.wait(
                tags.mapIndexed(
                  (index, element) => TagService.instance.updateTag(
                    element.copyWith(displayOrder: index),
                  ),
                ),
              );
            },
          );
        }

        return ListView.separated(
          controller: widget.scrollController,
          itemBuilder: (context, index) {
            final tag = snapshot.data!.elementAt(index);

            return CheckboxListTile.adaptive(
              value: selectedTags.any((element) => element.id == tag.id),
              secondary: tag.displayIcon(),
              title: Text(tag.name),
              subtitle: tag.description != null && tag.description!.isNotEmpty
                  ? Text(tag.description!)
                  : null,
              onChanged: (newValue) {
                if (newValue == null) return;

                if (!newValue) {
                  selectedTags.removeWhere((element) => element.id == tag.id);
                } else {
                  selectedTags.add(tag);
                }

                setState(() {});
              },
            );
          },
          separatorBuilder: (context, index) => const Divider(),
          itemCount: snapshot.data!.length,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    if (widget.isModal) {
      return ModalContainer(
        title: t.tags.select,
        footer: BottomSheetFooter(
          onSaved: () => Navigator.of(context).pop(selectedTags),
        ),
        body: Stack(
          children: [
            buildList(),
            ScrollableWithBottomGradient.buildPositionedGradient(
                Theme.of(context).dialogBackgroundColor)
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(t.tags.display(n: 10))),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.add_rounded),
        label: Text(t.tags.add),
        onPressed: () => context.pushRoute(TagFormRoute()),
      ),
      body: buildList(),
    );
  }
}
