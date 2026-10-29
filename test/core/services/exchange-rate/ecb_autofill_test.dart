import 'package:flutter_test/flutter_test.dart';
import 'package:monekin/core/services/exchange-rate/ecb_autofill.dart';

void main() {
  late EcbAutofill state;
  final today = DateTime(2026, 10, 29);

  String select(
    String text, {
    String currency = 'EUR',
    String preferred = 'USD',
    DateTime? date,
  }) {
    return state.select(
      currency: currency,
      preferred: preferred,
      date: date ?? today,
      text: text,
    );
  }

  setUp(() => state = EcbAutofill());

  test('unsupported selection clears an untouched quote immediately', () {
    select('');
    final text = state.receive(1.2, '');
    expect(select(text, currency: 'ARS'), '');
    expect(state.rate, isNull);
  });

  test('a failed lookup on a different date cannot retain the old quote', () {
    select('');
    final text = state.receive(1.2, '');
    final cleared = select(text, date: today.subtract(const Duration(days: 1)));
    expect(state.receive(null, cleared), '');
  });

  test('changing the base clears a quote from the previous base', () {
    select('');
    final text = state.receive(1.2, '');
    expect(select(text, preferred: 'GBP'), '');
  });

  test('manual values survive selection changes and failed lookups', () {
    select('');
    state.receive(1.2, '');
    state.userEdited();
    final text = select('1.75', currency: 'ARS');
    expect(state.receive(null, text), '1.75');
  });

  test('an explicit edit matching the old quote remains user-owned', () {
    select('');
    final text = state.receive(1.2, '');
    state.userEdited();
    expect(select(text, currency: 'JPY'), text);
  });

  test('text entered during a lookup is not overwritten', () {
    select('');
    state.userEdited();
    expect(state.receive(1.2, '1.75'), '1.75');
    expect(state.rate, 1.2);
  });

  test('restored ECB values become autofill-owned again', () {
    select('');
    state.receive(1.2, '');
    state.userEdited();
    expect(select(state.restore(), currency: 'JPY'), '');
  });

  test('time changes within the same date preserve the quote', () {
    select('');
    final text = state.receive(1.2, '');
    expect(select(text, date: today.add(const Duration(hours: 12))), text);
    expect(state.rate, 1.2);
  });
}
