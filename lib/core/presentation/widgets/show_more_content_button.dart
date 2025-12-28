import 'package:flutter/material.dart';
import 'package:monekin/core/presentation/animations/animated_expanded.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

class ShowMoreContentButton extends StatefulWidget {
  const ShowMoreContentButton({
    super.key,
    required this.child,
    this.sidePadding = 0,
    this.title,
  });

  final Widget child;
  final double sidePadding;

  /// Label of the button (if null, "Show more fields" will be used)
  final String? title;

  @override
  State<ShowMoreContentButton> createState() => _ShowMoreContentButtonState();
}

class _ShowMoreContentButtonState extends State<ShowMoreContentButton> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    final header = Padding(
      padding: EdgeInsets.symmetric(
        vertical: 0,
        horizontal: widget.sidePadding,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 12,
        children: [
          const Expanded(child: Divider()),
          FilledButton.tonalIcon(
            onPressed: () {
              setState(() {
                expanded = !expanded;
              });
            },
            icon: AnimatedRotation(
              duration: const Duration(milliseconds: 250),
              turns: expanded ? 0.5 : 0,
              child: const Icon(Icons.arrow_drop_down),
            ),
            label: Text(widget.title ?? t.general.show_more_fields),
          ),
          const Expanded(child: Divider()),
        ],
      ),
    );

    return AnimatedSizeSwitcher(child: expanded ? widget.child : header);
  }
}
