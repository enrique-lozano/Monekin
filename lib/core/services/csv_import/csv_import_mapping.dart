import 'package:copy_with_extension/copy_with_extension.dart';

part 'csv_import_mapping.g.dart';

/// How the amount (and the type) of each transaction is read from the CSV.
enum CsvAmountMode {
  /// A single column, where negative values are expenses and positive ones
  /// are incomes.
  signed,

  /// One column for incomes and another one for expenses.
  separateColumns,

  /// A single column with the (unsigned) amount, plus another column telling
  /// whether the row is an income or an expense.
  typeColumn,
}

/// Describes which CSV column feeds each transaction attribute.
///
/// Columns are stored as indexes of the CSV header row, and a `null` column
/// means "not present in the file".
@CopyWith()
class CsvImportMapping {
  const CsvImportMapping({
    this.amountMode = CsvAmountMode.signed,
    this.amountColumn,
    this.incomeColumn,
    this.expenseColumn,
    this.typeColumn,
    this.incomeTypeValues = const [],
    this.expenseTypeValues = const [],
    this.transferColumn,
    this.transferValues = const [],
    this.transferPattern = '',
    this.accountColumn,
    this.destinationAccountColumn,
    this.categoryColumn,
    this.tagsColumn,
    this.dateColumn,
    this.timeColumn,
    this.notesColumn,
    this.titleColumn,
    this.dateFormat = '',
    this.tagSeparator = '|',
  });

  final CsvAmountMode amountMode;

  /// Used by [CsvAmountMode.signed] and [CsvAmountMode.typeColumn].
  final int? amountColumn;

  /// Used by [CsvAmountMode.separateColumns].
  final int? incomeColumn;
  final int? expenseColumn;

  /// Used by [CsvAmountMode.typeColumn]. The values (case-insensitive) that
  /// identify an income or an expense in that column.
  final int? typeColumn;
  final List<String> incomeTypeValues;
  final List<String> expenseTypeValues;

  /// Column that flags a row as a transfer when its value is one of the
  /// [transferValues] (case-insensitive). It can be any column, even the same
  /// as the category or the type one.
  final int? transferColumn;
  final List<String> transferValues;

  /// Regular expression that also flags a row as a transfer when it matches
  /// the [transferColumn] text. Useful when the only language-independent
  /// hint is inside a free text, like a note.
  final String transferPattern;

  final int? accountColumn;

  /// For files that already describe a transfer in a single row. When null,
  /// transfers are rebuilt by pairing their outgoing and incoming rows.
  final int? destinationAccountColumn;

  final int? categoryColumn;
  final int? tagsColumn;
  final int? dateColumn;
  final int? timeColumn;
  final int? notesColumn;
  final int? titleColumn;

  /// `intl` pattern of the date column. When empty, ISO 8601 is expected.
  final String dateFormat;

  final String tagSeparator;

  bool get hasValidAmount => switch (amountMode) {
    CsvAmountMode.signed => amountColumn != null,
    CsvAmountMode.separateColumns =>
      incomeColumn != null || expenseColumn != null,
    CsvAmountMode.typeColumn => amountColumn != null && typeColumn != null,
  };
}
