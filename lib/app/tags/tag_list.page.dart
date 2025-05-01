import 'dart:async';

import 'package:collection/collection.dart';
import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:monekin/app/tags/tag_form_page.dart';
import 'package:monekin/core/database/services/tags/tags_service.dart';
import 'package:monekin/core/extensions/string.extension.dart';
import 'package:monekin/core/presentation/widgets/monekin_reorderable_list.dart';
import 'package:monekin/core/presentation/widgets/no_results.dart';
import 'package:monekin/core/routes/route_utils.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

import '../../core/presentation/widgets/reorderable_drag_icon.dart';

class TagListPage extends StatefulWidget {
  const TagListPage({
    super.key,
    this.scrollController,
  });

  final ScrollController? scrollController;

  @override
  State<TagListPage> createState() => _TagListPageState();
}

class _TagListPageState extends State<TagListPage> {
  Timer? _debounce;

  String searchQuery = '';

  _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 225), () {
      setState(() {
        searchQuery = query;
      });
    });
  }

  @override
  void initState() {
    super.initState();
  }

  Widget buildList() {
    return StreamBuilder(
      stream: TagService.instance.getTags(
        filter: (p0) => p0.name.contains(searchQuery),
      ),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const LinearProgressIndicator();
        }

        if (snapshot.data!.isEmpty) {
          return NoResults(
            title: t.general.empty_warn,
            description: t.tags.empty_list,
          );
        }

        final tags = snapshot.data!;

        final isOrderEnabled = tags.length > 1 && searchQuery.isNullOrEmpty;

        return MonekinReorderableList(
          totalItemCount: tags.length,
          padding: const EdgeInsets.fromLTRB(16, 6, 16, 16),
          isOrderEnabled: isOrderEnabled,
          spaceBetween: 8,
          itemBuilder: (context, index, isOrdering) {
            final tag = tags.elementAt(index);

            return Material(
              child: ListTile(
                tileColor: Theme.of(context).colorScheme.surfaceContainer,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                onTap: () =>
                    RouteUtils.pushRoute(context, TagFormPage(tag: tag)),
                trailing: tags.length > 1
                    ? ReorderableDragIcon(
                        index: index,
                        enabled: isOrderEnabled,
                      )
                    : null,
                leading: tag.displayIcon(),
                title: Text(tag.name),
                subtitle: tag.description != null && tag.description!.isNotEmpty
                    ? Text(tag.description!)
                    : null,
              ),
            );
          },
          onReorder: (from, to) async {
            if (to > from) to--;

            final item = tags.removeAt(from);
            tags.insert(to, item);

            await Future.wait(
              tags.mapIndexed(
                (index, element) => TagService.instance.updateTag(
                  element.copyWith(displayOrder: index),
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(t.tags.display(n: 10))),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.add_rounded),
        label: Text(t.tags.add),
        onPressed: () => RouteUtils.pushRoute(context, const TagFormPage()),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: TextField(
              decoration: InputDecoration(
                hintText: t.general.tap_to_search,
                prefixIcon: const Icon(Icons.search_rounded),
              ),
              onChanged: (q) => _onSearchChanged(q),
            ),
          ),
          Expanded(child: buildList()),
        ],
      ),
    );
  }
}
