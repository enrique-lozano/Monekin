import 'package:flutter/material.dart';

class HTMLText extends StatelessWidget {
  /// The original text to parse
  final String text;

  /// Tags to parse and remove from the original text. All the text inside the tags will be in the specified style.
  final Map<String, TextStyle> tags;

  /// Widget to display some text that contains some HTML tags inside it
  ///
  /// * **IMPORTANT**: With the current implementation, a HTML tag could not be inside other tag
  const HTMLText({super.key, required this.text, required this.tags});

  @override
  Widget build(BuildContext context) {
    List<InlineSpan> textSpans = parseHtmlString(text, tags);

    return Text.rich(
      TextSpan(children: textSpans),
    );
  }

  List<InlineSpan> parseHtmlString(
      String htmlString, Map<String, TextStyle> tags) {
    final List<InlineSpan> result = [];

    for (final tag in tags.entries) {
      final RegExp tagRegExp = RegExp(r'<(\/)?(' + tag.key + ')>');

      final parts = htmlString.split(tagRegExp);

      final startTag = '<${tag.key}>';
      final endTag = '</${tag.key}>';

      for (int i = 0; i < parts.length; i++) {
        final part = parts[i];

        if (htmlString.contains('$startTag$part$endTag')) {
          result.add(TextSpan(text: parts[i], style: tag.value));
        } else {
          result.add(TextSpan(text: part));
        }
      }
    }

    return result;
  }
}
