import 'package:flutter/material.dart';

class ModalContainer extends StatelessWidget {
  const ModalContainer({
    super.key,
    required this.title,
    this.subtitle,
    this.endWidget,
    required this.body,
    this.bodyPadding = const EdgeInsets.all(0),
    this.footer,
    this.responseToKeyboard = true,
  });

  final String title;
  final String? subtitle;

  final Widget? endWidget;

  final Widget? footer;
  final Widget body;

  final EdgeInsets bodyPadding;

  /// If `true` (the default value), the modal will not be behind the keyboard when opened
  final bool responseToKeyboard;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          bottom: responseToKeyboard
              ? MediaQuery.of(context).viewInsets.bottom
              : 0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 22),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(fontWeight: FontWeight.w800),
                    ),
                    if (subtitle != null) ...[
                      const SizedBox(height: 2),
                      Text(subtitle!)
                    ],
                  ],
                ),
                if (endWidget != null) endWidget!
              ],
            ),
          ),
          Flexible(
            child: Padding(
              padding: bodyPadding,
              child: body,
            ),
          ),
          if (footer != null) footer!,
          const SizedBox(height: 6)
        ],
      ),
    );
  }
}
