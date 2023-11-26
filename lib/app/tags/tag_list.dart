import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:monekin/core/database/services/tags/tags_service.dart';
import 'package:monekin/core/models/tags/tag.dart';
import 'package:monekin/core/presentation/widgets/bottomSheetFooter.dart';
import 'package:monekin/core/presentation/widgets/empty_indicator.dart';
import 'package:monekin/core/presentation/widgets/scrollable_with_bottom_gradient.dart';
import 'package:monekin/core/routes/app_router.dart';
import 'package:monekin/i18n/translations.g.dart';

Future<List<Tag>?> showTagListModal(BuildContext context, TagListPage page) {
  return showModalBottomSheet<List<Tag>>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (context) {
      return DraggableScrollableSheet(
          expand: false,
          maxChildSize: 0.85,
          minChildSize: 0.85,
          initialChildSize: 0.85,
          builder: (context, scrollController) {
            return page;
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
  });

  final bool isModal;
  final List<Tag> selected;

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

          return ListView.separated(
            itemBuilder: (context, index) {
              final tag = snapshot.data!.elementAt(index);

              if (widget.isModal) {
                return CheckboxListTile.adaptive(
                  value: selectedTags.any((element) => element.id == tag.id),
                  secondary: tag.displayIcon(),
                  title: Text(tag.name),
                  subtitle:
                      tag.description != null && tag.description!.isNotEmpty
                          ? Text(tag.description!)
                          : null,
                  onChanged: (newValue) {
                    if (newValue == null) return;

                    if (!newValue) {
                      selectedTags
                          .removeWhere((element) => element.id == tag.id);
                    } else {
                      selectedTags.add(tag);
                    }

                    setState(() {});
                  },
                );
              }

              return ListTile(
                leading: tag.displayIcon(),
                title: Text(tag.name),
                subtitle: tag.description != null && tag.description!.isNotEmpty
                    ? Text(tag.description!)
                    : null,
                onTap: () => context.pushRoute(TagFormRoute(tag: tag)),
              );
            },
            separatorBuilder: (context, index) => const Divider(),
            itemCount: snapshot.data!.length,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    if (widget.isModal) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 6),
            child: Text(
              t.tags.select,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                buildList(),
                ScrollableWithBottomGradient.buildPositionedGradient(
                    Theme.of(context).dialogBackgroundColor)
              ],
            ),
          ),
          BottomSheetFooter(
            onSaved: () => Navigator.of(context).pop(selectedTags),
          ),
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(t.tags.display(n: 10))),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add_rounded),
        onPressed: () => context.pushRoute(TagFormRoute()),
      ),
      body: buildList(),
    );
  }
}
