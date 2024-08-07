import 'package:flutter/material.dart';
import 'package:monekin/i18n/translations.g.dart';

class TagsFilterContainer extends StatelessWidget {
  const TagsFilterContainer(
      {super.key,
      required this.child,
      this.headerLabelStyle,
      this.headerSpacing = 4});

  final Widget child;

  final TextStyle? headerLabelStyle;

  /// Space between the header label and the tags chips. Defaults to `4`
  final double headerSpacing;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${t.tags.display(n: 19)}:',
          style: headerLabelStyle,
        ),
        SizedBox(height: headerSpacing),
        ConstrainedBox(
            constraints: const BoxConstraints(
              maxHeight: 100,
              maxWidth: double.infinity,
              minWidth: double.infinity,
            ),
            child: Card(
              elevation: 0,
              margin: const EdgeInsets.all(0),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(0),
                child: child,
              ),
            ))
      ],
    );
  }
}
