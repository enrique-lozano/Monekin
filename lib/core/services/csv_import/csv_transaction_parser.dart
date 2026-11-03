import 'package:collection/collection.dart';
import 'package:intl/intl.dart';
import 'package:monekin/core/models/transaction/transaction_type.enum.dart';
import 'package:monekin/core/services/csv_import/csv_import_mapping.dart';

/// Max time between the outgoing and incoming rows of the same transfer
const _legsTimeTolerance = Duration(minutes: 1);

/// A transaction read from a CSV row, before being matched with the accounts,
/// categories and tags of the database.
class ParsedCsvTransaction {
  const ParsedCsvTransaction({
    required this.type,
    required this.date,
    required this.amount,
    this.accountName,
    this.receivingAccountName,
    this.valueInDestiny,
    this.categoryName,
    this.tags = const [],
    this.notes,
    this.title,
  });

  final TransactionType type;
  final DateTime date;

  /// Always positive. The sign is given by the [type].
  final double amount;

  final String? accountName;

  /// Only for transfers
  final String? receivingAccountName;

  /// Only for transfers whose file tells the amount received (that can differ
  /// from [amount] if the accounts have different currencies)
  final double? valueInDestiny;

  final String? categoryName;
  final List<String> tags;
  final String? notes;
  final String? title;
}

enum CsvRowIssue { invalidAmount, invalidDate, unknownType }

class CsvParseResult {
  const CsvParseResult({
    required this.transactions,
    required this.skippedRows,
    required this.unpairedTransfers,
  });

  final List<ParsedCsvTransaction> transactions;

  /// 1-based number of each data row (header excluded) that was discarded
  final Map<int, CsvRowIssue> skippedRows;

  /// Rows flagged as transfers for which the other leg could not be found.
  /// They are imported as regular incomes or expenses.
  final int unpairedTransfers;

  int countOf(TransactionType type) =>
      transactions.where((e) => e.type == type).length;

  Set<String> get accountNames => {
    for (final tr in transactions) ...[
      if (tr.accountName != null) tr.accountName!,
      if (tr.receivingAccountName != null) tr.receivingAccountName!,
    ],
  };
}

/// Parses the amount of a CSV cell, supporting both `1,234.56` and `1.234,56`
/// notations as well as currency symbols and spaces. Returns null if the text
/// does not look like a number.
double? parseCsvAmount(String raw) {
  var text = raw.replaceAll(RegExp(r'[^\d.,\-+()]'), '');

  if (text.isEmpty) return null;

  final isNegative =
      text.startsWith('-') || (text.startsWith('(') && text.endsWith(')'));
  text = text.replaceAll(RegExp(r'[\-+()]'), '');

  final lastDot = text.lastIndexOf('.');
  final lastComma = text.lastIndexOf(',');

  if (lastDot >= 0 && lastComma >= 0) {
    final decimalSeparator = lastDot > lastComma ? '.' : ',';
    final thousandsSeparator = decimalSeparator == '.' ? ',' : '.';

    text = text
        .replaceAll(thousandsSeparator, '')
        .replaceFirst(decimalSeparator, '.');
  } else if (lastComma >= 0) {
    // "1,234" or "1,234,567" are thousands. Anything else is a decimal comma
    final isThousands = RegExp(r'^\d{1,3}(,\d{3})+$').hasMatch(text);
    text = isThousands ? text.replaceAll(',', '') : text.replaceFirst(',', '.');
  }

  final value = double.tryParse(text);

  if (value == null) return null;

  return isNegative ? -value : value;
}

/// Converts the rows of a CSV into [ParsedCsvTransaction]s following a
/// [CsvImportMapping]. It is a pure function (no DB access) so it can be
/// safely used to preview and to test imports.
class CsvTransactionParser {
  CsvTransactionParser(this.mapping, {DateTime Function()? now})
    : _now = now ?? DateTime.now;

  final CsvImportMapping mapping;
  final DateTime Function() _now;

  // Created once, they are used by every row
  late final RegExp? _transferRegex = mapping.transferPattern.isEmpty
      ? null
      : RegExp(mapping.transferPattern, multiLine: true);

  final _dateFormats = <String, DateFormat>{};

  /// [rows] must not include the header row.
  CsvParseResult parse(List<List<String>> rows) {
    final skipped = <int, CsvRowIssue>{};
    final parsed = <_ParsedRow>[];

    for (final (index, row) in rows.indexed) {
      final result = _parseRow(row);

      if (result.issue != null) {
        skipped[index + 1] = result.issue!;
      } else {
        parsed.add(result.row!.withIndex(index));
      }
    }

    final transactions = _resolveTransfers(parsed);

    return CsvParseResult(
      transactions: transactions.transactions,
      skippedRows: skipped,
      unpairedTransfers: transactions.unpaired,
    );
  }

  String _cell(List<String> row, int? column) =>
      column == null || column >= row.length ? '' : row[column].trim();

  bool _matches(String value, List<String> options) =>
      options.any((o) => o.trim().toLowerCase() == value.toLowerCase());

  ({_ParsedRow? row, CsvRowIssue? issue}) _parseRow(List<String> row) {
    final m = mapping;

    // Signed amount: negative = leaving the account
    double? signedAmount;
    bool unknownType = false;

    switch (m.amountMode) {
      case CsvAmountMode.signed:
        signedAmount = parseCsvAmount(_cell(row, m.amountColumn));
      case CsvAmountMode.separateColumns:
        final income = parseCsvAmount(_cell(row, m.incomeColumn)) ?? 0;
        final expense = parseCsvAmount(_cell(row, m.expenseColumn)) ?? 0;

        signedAmount = income.abs() - expense.abs();
        if (income == 0 && expense == 0) signedAmount = null;
      case CsvAmountMode.typeColumn:
        final amount = parseCsvAmount(_cell(row, m.amountColumn))?.abs();
        final type = _cell(row, m.typeColumn);

        if (amount != null) {
          if (_matches(type, m.incomeTypeValues)) {
            signedAmount = amount;
          } else if (_matches(type, m.expenseTypeValues)) {
            signedAmount = -amount;
          } else if (_matches(type, m.transferValues)) {
            signedAmount = 0;
          } else {
            unknownType = true;
          }
        }
    }

    if (unknownType) return (row: null, issue: CsvRowIssue.unknownType);
    if (signedAmount == null) {
      return (row: null, issue: CsvRowIssue.invalidAmount);
    }

    final date = _parseDate(row);
    if (date == null) return (row: null, issue: CsvRowIssue.invalidDate);

    final destination = _cell(row, m.destinationAccountColumn);
    final flagText = _cell(row, m.transferColumn);
    final isFlagged =
        m.transferColumn != null &&
        (_matches(flagText, m.transferValues) ||
            (_transferRegex?.hasMatch(flagText) ?? false));

    final isTransfer = m.destinationAccountColumn != null
        ? destination.isNotEmpty && (m.transferColumn == null || isFlagged)
        : isFlagged;

    final tags = m.tagsColumn == null || m.tagSeparator.isEmpty
        ? <String>[]
        : _cell(row, m.tagsColumn)
              .split(m.tagSeparator)
              .map((e) => e.trim())
              .where((e) => e.isNotEmpty)
              .toList();

    return (
      row: _ParsedRow(
        signedAmount: signedAmount,
        date: date,
        isTransfer: isTransfer,
        accountName: _nullIfEmpty(_cell(row, m.accountColumn)),
        receivingAccountName: isTransfer && destination.isNotEmpty
            ? destination
            : null,
        categoryName: _nullIfEmpty(_cell(row, m.categoryColumn)),
        tags: tags,
        notes: _nullIfEmpty(_cell(row, m.notesColumn)),
        title: _nullIfEmpty(_cell(row, m.titleColumn)),
      ),
      issue: null,
    );
  }

  String? _nullIfEmpty(String value) => value.isEmpty ? null : value;

  DateTime? _parseDate(List<String> row) {
    if (mapping.dateColumn == null) return _now();

    final date = _cell(row, mapping.dateColumn);
    final time = _cell(row, mapping.timeColumn);

    if (date.isEmpty) return null;

    DateTime? parsed;

    if (mapping.dateFormat.trim().isEmpty) {
      parsed = DateTime.tryParse(time.isEmpty ? date : '$date $time');
      parsed ??= DateTime.tryParse(date);
    } else {
      final patterns = [
        if (time.isNotEmpty) ...[
          '${mapping.dateFormat} HH:mm:ss',
          '${mapping.dateFormat} HH:mm',
        ],
        mapping.dateFormat,
      ];

      for (final pattern in patterns) {
        try {
          parsed = _dateFormats
              .putIfAbsent(pattern, () => DateFormat(pattern, 'en_US'))
              .parseStrict(
                pattern == mapping.dateFormat ? date : '$date $time',
              );
          break;
        } on FormatException {
          continue;
        }
      }
    }

    return parsed?.toLocal();
  }

  ({List<ParsedCsvTransaction> transactions, int unpaired}) _resolveTransfers(
    List<_ParsedRow> rows,
  ) {
    // Rows that are one leg (out or in) of a transfer, without the destination
    final legs = rows.where(
      (r) => r.isTransfer && r.receivingAccountName == null,
    );

    final paired = <int, ParsedCsvTransaction?>{};
    int unpaired = 0;

    if (mapping.dateColumn != null) {
      final incoming = legs.where((l) => l.signedAmount > 0).toList();

      for (final out in legs.where((l) => l.signedAmount < 0)) {
        // Exports often write both legs a few seconds apart
        final candidates = incoming
            .where(
              (c) =>
                  c.accountName != out.accountName &&
                  c.date.difference(out.date).abs() <= _legsTimeTolerance,
            )
            .sortedBy<num>(
              (c) => c.date.difference(out.date).abs().inMilliseconds,
            );

        final match =
            candidates.firstWhereOrNull(
              (c) => (c.signedAmount + out.signedAmount).abs() < 1e-9,
            ) ??
            candidates.firstOrNull;

        if (match == null) continue;

        incoming.remove(match);

        final amount = out.signedAmount.abs();

        paired[out.index!] = out.toTransaction(
          TransactionType.transfer,
          amount: amount,
          receivingAccountName: match.accountName,
          valueInDestiny: (match.signedAmount - amount).abs() < 1e-9
              ? null
              : match.signedAmount,
        );
        paired[match.index!] = null;
      }
    }

    final result = <ParsedCsvTransaction>[];

    for (final row in rows) {
      if (paired.containsKey(row.index)) {
        final tr = paired[row.index];
        if (tr != null) result.add(tr);
        continue;
      }

      if (row.isTransfer && row.receivingAccountName != null) {
        result.add(
          row.toTransaction(
            TransactionType.transfer,
            amount: row.signedAmount.abs(),
            receivingAccountName: row.receivingAccountName,
          ),
        );
        continue;
      }

      if (row.isTransfer) unpaired++;

      if (row.signedAmount == 0) continue;

      result.add(
        row.toTransaction(
          row.signedAmount < 0
              ? TransactionType.expense
              : TransactionType.income,
          amount: row.signedAmount.abs(),
        ),
      );
    }

    return (transactions: result, unpaired: unpaired);
  }
}

class _ParsedRow {
  const _ParsedRow({
    required this.signedAmount,
    required this.date,
    required this.isTransfer,
    this.index,
    this.accountName,
    this.receivingAccountName,
    this.categoryName,
    this.tags = const [],
    this.notes,
    this.title,
  });

  final int? index;
  final double signedAmount;
  final DateTime date;
  final bool isTransfer;
  final String? accountName;
  final String? receivingAccountName;
  final String? categoryName;
  final List<String> tags;
  final String? notes;
  final String? title;

  _ParsedRow withIndex(int index) => _ParsedRow(
    index: index,
    signedAmount: signedAmount,
    date: date,
    isTransfer: isTransfer,
    accountName: accountName,
    receivingAccountName: receivingAccountName,
    categoryName: categoryName,
    tags: tags,
    notes: notes,
    title: title,
  );

  ParsedCsvTransaction toTransaction(
    TransactionType type, {
    required double amount,
    String? receivingAccountName,
    double? valueInDestiny,
  }) {
    final isTransfer = type.isTransfer;

    return ParsedCsvTransaction(
      type: type,
      date: date,
      amount: amount,
      accountName: accountName,
      receivingAccountName: receivingAccountName,
      valueInDestiny: valueInDestiny,
      categoryName: isTransfer ? null : categoryName,
      tags: tags,
      notes: notes,
      title: title,
    );
  }
}
