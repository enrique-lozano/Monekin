import 'package:flutter/material.dart';
import 'package:monekin/app/tags/tag_form_page.dart';
import 'package:monekin/core/database/services/tags/tags_service.dart';
import 'package:monekin/core/models/tags/tag.dart';
import 'package:monekin/core/presentation/widgets/bottomSheetFooter.dart';
import 'package:monekin/core/presentation/widgets/scrollable_with_bottom_gradient.dart';
import 'package:monekin/i18n/translations.g.dart';

Future<List<Tag>?> showTagListModal(BuildContext context, TagList page) {
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

class TagList extends StatefulWidget {
  const TagList({
    super.key,
    this.isModal = false,
    this.selected = const <Tag>[],
  });

  final bool isModal;
  final List<Tag> selected;

  @override
  State<TagList> createState() => _TagListState();
}

class _TagListState extends State<TagList> {
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

          return ListView.separated(
            itemBuilder: (context, index) {
              final tag = snapshot.data!.elementAt(index);

              if (widget.isModal) {
                return CheckboxListTile.adaptive(
                  value: selectedTags.any((element) => element.id == tag.id),
                  secondary: Icon(
                    Icons.sell_rounded,
                    color: tag.colorData,
                  ),
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
                leading: Icon(
                  Icons.sell_rounded,
                  color: tag.colorData,
                ),
                title: Text(tag.name),
                subtitle: tag.description != null && tag.description!.isNotEmpty
                    ? Text(tag.description!)
                    : null,
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TagFormPage(tag: tag),
                    )),
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
        onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const TagFormPage(),
            )),
      ),
      body: buildList(),
    );
  }
}
