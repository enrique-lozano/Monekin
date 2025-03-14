import 'package:flutter/material.dart';

/// Useful class if you want to differentiate the dismissal of the modal from a return of a result with a null value
class ModalResult<T> {
  final T? result;

  const ModalResult(this.result);
}

class ModalContainer extends StatelessWidget {
  const ModalContainer({
    super.key,
    required this.title,
    this.titleBuilder,
    this.subtitle,
    this.endWidget,
    required this.body,
    this.bodyPadding = const EdgeInsets.all(0),
    this.footer,
    this.responseToKeyboard = true,
    this.bodyFit = FlexFit.loose,
  });

  final String title;

  /// In case you want something more complex that a simple text as a title, or in case
  /// you want specific styles for the title
  final Widget Function(String title)? titleBuilder;

  final String? subtitle;

  final Widget? endWidget;

  final Widget? footer;
  final Widget body;

  final EdgeInsets bodyPadding;
  final FlexFit bodyFit;

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
          // ----- HEADER CONTENT ------
          //
          // Title, subtitle and end widget will be drawn
          // here with ther respective paddings and styles
          // ---------------

          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 22),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DefaultTextStyle(
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall!
                            .copyWith(fontWeight: FontWeight.w800),
                        child: titleBuilder != null
                            ? titleBuilder!(title)
                            : Text(title),
                      ),
                      if (subtitle != null) ...[
                        const SizedBox(height: 2),
                        Text(subtitle!)
                      ],
                    ],
                  ),
                ),
                if (endWidget != null) endWidget!
              ],
            ),
          ),

          // --- Header end ---

          Flexible(
            fit: bodyFit,
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
