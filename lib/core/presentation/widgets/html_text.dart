import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:monekin/core/utils/open_external_url.dart';

class HTMLText extends StatelessWidget {
  /// The original text to parse
  final String htmlString;

  /// The style to apply for the content that is outside a specified tag
  final TextStyle? defaultTextStyle;

  /// Tags to parse and remove from the original text. All the text inside the tags will be in the specified style.
  final Map<String, TextStyle> tags;

  /// Widget to display some text that contains some HTML tags inside it
  ///
  /// * **IMPORTANT**: With the current implementation, a HTML tag could not be inside other tag
  const HTMLText(
      {super.key,
      required this.htmlString,
      required this.tags,
      this.defaultTextStyle});

  @override
  Widget build(BuildContext context) {
    List<InlineSpan> textSpans = parseHtmlString(context);

    return Text.rich(
      TextSpan(children: textSpans),
    );
  }

  List<InlineSpan> parseHtmlString(BuildContext context) {
    final List<InlineSpan> result = [];

    for (final tag in tags.entries) {
      matchAttributes({String attrRegex = '[a-zA-Z]+'}) =>
          '(\\s)+$attrRegex=(\'|")([a-zA-Z0-9_.,\\/\\-:]*)(\'|")';
      const matchSpaces = '(\\s)*';

      String matchKey = '$matchSpaces(${tag.key})$matchSpaces';

      final RegExp tagRegExp =
          RegExp('<(\/)?$matchKey(${matchAttributes()})*$matchSpaces>');

      final parts = htmlString.split(tagRegExp);

      for (int i = 0; i < parts.length; i++) {
        final part = parts[i];

        if (htmlString.contains(RegExp(
            '<$matchKey(${matchAttributes()})*$matchSpaces>$part</$matchKey>'))) {
          // -- Text inside a tag --

          /// The href link present in some `a` tags
          String? link;

          if (tag.key == 'a') {
            final match = RegExp(
                    '<$matchKey(${matchAttributes()})*$matchSpaces>$part</$matchKey>')
                .allMatches(htmlString)
                .first
                .group(0)!;

            link = RegExp(matchAttributes(attrRegex: 'href'))
                .allMatches(match)
                .first
                .group(3);
          }

          result.add(TextSpan(
            text: parts[i],
            style: tag.value,
            recognizer:
                (link == null || link.isEmpty) ? null : TapGestureRecognizer()
                  ?..onTap = () {
                    openExternalURL(context, link!);
                  },
          ));
        } else {
          // -- Text outside a tag --
          result.add(TextSpan(text: part, style: defaultTextStyle));
        }
      }
    }

    return result;
  }
}
