import 'package:flutter/material.dart';
import 'package:monekin/i18n/translations.g.dart';

class TagsFilterContainer extends StatelessWidget {
  const TagsFilterContainer({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('${t.tags.display(n: 19)}:'),
        const SizedBox(height: 4),
        ConstrainedBox(
            constraints: const BoxConstraints(
              maxHeight: 100,
              maxWidth: double.infinity,
              minWidth: double.infinity,
            ),
            child: Card(
              margin: const EdgeInsets.all(0),
              child: SingleChildScrollView(
                  padding: const EdgeInsets.all(8.0), child: child),
            ))
      ],
    );
  }
}
