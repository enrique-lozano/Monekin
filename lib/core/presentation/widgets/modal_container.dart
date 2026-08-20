import 'package:flutter/material.dart';
import 'package:monekin/core/extensions/padding.extension.dart';
import 'package:monekin/core/routes/route_utils.dart';

/// Useful class if you want to differentiate the dismissal of the modal from a return of a result with a null value
class ModalResult<T> {
  final T? result;

  const ModalResult(this.result);

  @override
  String toString() {
    return 'ModalResult: $result';
  }
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
    this.showTitleDivider = false,
  });

  final String title;

  final bool showTitleDivider;

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
    // In a popover the title/subtitle/end widget are dropped: the trigger field
    // already provides the context and changes apply live (there is no save
    // button), so the chrome is just noise in the compact panel.
    final isPopover = ModalPresentation.isPopover(context);

    // Side drawer: fill height and pin footer to bottom; bottom sheets hug content.
    final isInSideDrawer = SideDrawerScope.of(context);

    return Padding(
      padding: EdgeInsets.only(
        bottom: responseToKeyboard
            ? MediaQuery.of(context).viewInsets.bottom
            : 0,
      ).withSafeBottom(context),
      child: Column(
        mainAxisSize: isInSideDrawer ? MainAxisSize.max : MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ----- HEADER CONTENT ------
          //
          // Title, subtitle and end widget will be drawn
          // here with ther respective paddings and styles
          // ---------------
          if (isPopover)
            const SizedBox(height: 8)
          else if (isInSideDrawer) ...[
            AppBar(
              primary: false,
              leading: const CloseButton(),
              titleSpacing: 0,
              title: titleBuilder != null ? titleBuilder!(title) : Text(title),
              actions: endWidget != null ? [endWidget!] : null,
            ),
            if (subtitle != null)
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: Text(subtitle!),
              ),
            const SizedBox(height: 16),
          ] else ...[
            Padding(
              padding: EdgeInsets.fromLTRB(
                16,
                8,
                16,
                showTitleDivider ? 0 : 22,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DefaultTextStyle(
                          style: Theme.of(context).textTheme.headlineSmall!
                              .copyWith(fontWeight: FontWeight.bold),
                          child: titleBuilder != null
                              ? titleBuilder!(title)
                              : Text(title),
                        ),
                        if (subtitle != null) ...[
                          const SizedBox(height: 2),
                          Text(subtitle!),
                        ],
                      ],
                    ),
                  ),
                  if (endWidget != null) endWidget!,
                ],
              ),
            ),
            if (showTitleDivider) ...[
              const SizedBox(height: 10),
              const Divider(),
            ],
          ],

          // --- Header end ---
          Flexible(
            // In a full-height side drawer the body grabs the remaining space so
            // the footer is pinned to the bottom edge of the drawer.
            fit: isInSideDrawer ? FlexFit.tight : bodyFit,
            child: Padding(padding: bodyPadding, child: body),
          ),
          if (footer != null) footer!,
          const SizedBox(height: 6),
        ],
      ),
    );
  }
}
