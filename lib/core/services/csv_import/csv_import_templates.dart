import 'package:material_ui/material_ui.dart';
import 'package:monekin/core/services/csv_import/csv_import_mapping.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

/// Finds columns of a CSV header row ignoring case and surrounding spaces.
class CsvHeaderLookup {
  CsvHeaderLookup(List<String> headers)
    : _headers = headers.map((e) => e.trim().toLowerCase()).toList();

  final List<String> _headers;

  /// Index of the first column matching any of the [names], or null
  int? find(Iterable<String> names) {
    for (final name in names) {
      final index = _headers.indexOf(name.trim().toLowerCase());
      if (index >= 0) return index;
    }

    return null;
  }

  bool hasAll(Iterable<String> names) => names.every((n) => find([n]) != null);
}

/// A known export format from another app (or tool) that pre-fills the
/// [CsvImportMapping], so users don't have to map every column by hand.
///
/// To support a new app, create a new template and add it to
/// [CsvImportTemplates.all]. Nothing else needs to change.
class CsvImportTemplate {
  const CsvImportTemplate({
    required this.id,
    required this.name,
    required this.icon,
    required this.color,
    required this.exportHint,
    required this.buildMapping,
    this.requiredHeaders = const [],
  });

  /// Stable identifier of the template
  final String id;

  /// Name of the app. Brand names are not translated
  final String name;

  final IconData icon;
  final Color color;

  /// Explains the user how to get the CSV file from the source app
  final String Function(Translations t) exportHint;

  /// Headers that must be present in the file to apply this template
  final List<String> requiredHeaders;

  /// Builds the mapping for a file with these headers. Only called if all the
  /// [requiredHeaders] are present.
  final CsvImportMapping Function(CsvHeaderLookup headers) buildMapping;

  /// Whether the [headers] of a file look like an export of this app
  bool matches(List<String> headers) =>
      requiredHeaders.isNotEmpty &&
      CsvHeaderLookup(headers).hasAll(requiredHeaders);

  /// The mapping to start with for a file with these [headers]
  CsvImportMapping mappingFor(List<String> headers) =>
      buildMapping(CsvHeaderLookup(headers));
}

class CsvImportTemplates {
  CsvImportTemplates._();

  static final myExpenses = CsvImportTemplate(
    id: 'my_expenses',
    name: 'MyExpenses',
    icon: Icons.account_balance_wallet_rounded,
    color: const Color(0xFF2E7D32),
    exportHint: (t) => t.backup.import.templates.my_expenses_hint,
    requiredHeaders: const ['Date', 'Income', 'Expense'],
    buildMapping: (h) => CsvImportMapping(
      amountMode: CsvAmountMode.separateColumns,
      incomeColumn: h.find(['Income']),
      expenseColumn: h.find(['Expense']),
      dateColumn: h.find(['Date']),
      timeColumn: h.find(['Time']),
      dateFormat: 'dd/MM/yyyy',
      titleColumn: h.find(['Payee/Payer']),
      categoryColumn: h.find(['Category 1']),
      notesColumn: h.find(['Notes']),
      tagsColumn: h.find(['Tags']),
      tagSeparator: ',',
    ),
  );

  static final cashew = CsvImportTemplate(
    id: 'cashew',
    name: 'Cashew',
    icon: Icons.savings_rounded,
    color: const Color(0xFF3F7D6B),
    exportHint: (t) => t.backup.import.templates.cashew_hint,
    requiredHeaders: const ['account', 'amount', 'date', 'category name'],
    buildMapping: (h) => CsvImportMapping(
      amountColumn: h.find(['amount']),
      accountColumn: h.find(['account']),
      dateColumn: h.find(['date']),
      titleColumn: h.find(['title']),
      notesColumn: h.find(['note']),
      categoryColumn: h.find(['category name']),
      // Both legs of a transfer have a note like "Bank → Cash"
      transferColumn: h.find(['note']),
      transferPattern: r'\S\s→\s\S',
    ),
  );

  static final wallet = CsvImportTemplate(
    id: 'wallet',
    name: 'Wallet by BudgetBakers',
    icon: Icons.wallet_rounded,
    color: const Color(0xFF1E88E5),
    exportHint: (t) => t.backup.import.templates.wallet_hint,
    requiredHeaders: const ['account', 'category', 'amount', 'date'],
    buildMapping: (h) => CsvImportMapping(
      amountColumn: h.find(['amount']),
      accountColumn: h.find(['account']),
      categoryColumn: h.find(['category']),
      dateColumn: h.find(['date']),
      dateFormat: '',
      titleColumn: h.find(['payee']),
      notesColumn: h.find(['note']),
      tagsColumn: h.find(['labels']),
      tagSeparator: ',',
      transferColumn: h.find(['transfer']),
      transferValues: const ['true'],
    ),
  );

  /// Fallback for spreadsheets and any other app. Columns are guessed by
  /// their usual names and the user can review everything.
  static final spreadsheet = CsvImportTemplate(
    id: 'spreadsheet',
    name: 'Excel · Google Sheets · Other',
    icon: Icons.table_chart_rounded,
    color: const Color(0xFF607D8B),
    exportHint: (t) => t.backup.import.templates.spreadsheet_hint,
    buildMapping: (h) {
      final income = h.find(['income', 'credit', 'deposit']);
      final expense = h.find(['expense', 'debit', 'withdrawal']);
      final amount = h.find(['amount', 'value', 'sum', 'total']);

      return CsvImportMapping(
        amountMode: amount == null && income != null && expense != null
            ? CsvAmountMode.separateColumns
            : CsvAmountMode.signed,
        amountColumn: amount,
        incomeColumn: income,
        expenseColumn: expense,
        accountColumn: h.find(['account', 'wallet']),
        destinationAccountColumn: h.find([
          'to account',
          'destination account',
          'destination',
        ]),
        categoryColumn: h.find(['category', 'category name']),
        dateColumn: h.find(['date', 'datetime', 'timestamp']),
        titleColumn: h.find(['title', 'description', 'payee', 'name']),
        notesColumn: h.find(['note', 'notes', 'memo', 'comment']),
        tagsColumn: h.find(['tags', 'labels']),
        transferColumn: h.find(['type']),
        transferValues: const ['transfer'],
      );
    },
  );

  /// Templates in the order they are shown to the user
  static final List<CsvImportTemplate> all = [
    myExpenses,
    cashew,
    wallet,
    spreadsheet,
  ];
}
