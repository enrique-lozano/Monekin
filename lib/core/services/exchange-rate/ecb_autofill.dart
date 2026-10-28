/// Tracks field ownership separately from numeric equality with an ECB quote.
class EcbAutofill {
  double? rate;
  String? _autofilledText;
  ({String? currency, String? preferred, int day})? _selection;

  String select({
    required String? currency,
    required String? preferred,
    required DateTime date,
    required String text,
  }) {
    final selection = (
      currency: currency,
      preferred: preferred,
      day: date.year * 10000 + date.month * 100 + date.day,
    );
    if (selection == _selection) return text;
    _selection = selection;
    final cleared = text == _autofilledText ? '' : text;
    rate = null;
    _autofilledText = null;
    return cleared;
  }

  String receive(double? quote, String text) {
    rate = quote;
    if (quote == null || text.trim().isNotEmpty) return text;
    _autofilledText = quote.toString();
    return _autofilledText!;
  }

  void userEdited() => _autofilledText = null;

  String restore() {
    _autofilledText = rate!.toString();
    return _autofilledText!;
  }
}
