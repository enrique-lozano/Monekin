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
    this.playStorePackage,
    this.guideUrl,
    this.requiredHeaders = const [],
  });

  /// Stable identifier of the template
  final String id;

  /// Name of the app. Brand names are not translated
  final String name;

  final IconData icon;
  final Color color;

  /// Android package of the app, used to display its icon from Google Play
  final String? playStorePackage;

  /// Public article of the app explaining how to export the data
  final String? guideUrl;

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
    playStorePackage: 'org.totschnig.myexpenses',
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
    playStorePackage: 'com.budget.tracker_app',
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
    playStorePackage: 'com.droid4you.application.wallet',
    guideUrl: 'https://support.budgetbakers.com/hc/en-us/articles/7151606064018-How-to-export-transactions-from-Wallet',
    exportHint: (t) => t.backup.import.templates.wallet_hint,
    requiredHeaders: const [
      'account',
      'category',
      'amount',
      'ref_currency_amount',
      'type',
      'date',
    ],
    buildMapping: (h) => CsvImportMapping(
      amountMode: CsvAmountMode.typeColumn,
      amountColumn: h.find(['amount']),
      typeColumn: h.find(['type']),
      // The values are written in the language of the app
      incomeTypeValues: const ['Income', 'Ingreso'],
      expenseTypeValues: const ['Expense', 'Expenses', 'Gasto', 'Gastos'],
      accountColumn: h.find(['account']),
      categoryColumn: h.find(['category']),
      // Both legs of a transfer have this pseudo-category
      transferColumn: h.find(['category']),
      transferValues: const ['Transfer, withdraw', 'Transferir, retirar'],
      dateColumn: h.find(['date']),
      titleColumn: h.find(['payee']),
      notesColumn: h.find(['note']),
      tagsColumn: h.find(['labels']),
      tagSeparator: ',',
    ),
  );

  static final spendee = CsvImportTemplate(
    id: 'spendee',
    name: 'Spendee',
    icon: Icons.account_balance_wallet_outlined,
    color: const Color(0xFF00A98F),
    playStorePackage: 'com.cleevio.spendee',
    guideUrl: 'https://help.spendee.com/article/137-export-transactions',
    exportHint: (t) => t.backup.import.templates.spendee_hint,
    requiredHeaders: const [
      'date',
      'wallet',
      'type',
      'category name',
      'amount',
      'currency',
    ],
    buildMapping: (h) => CsvImportMapping(
      amountMode: CsvAmountMode.typeColumn,
      amountColumn: h.find(['amount']),
      typeColumn: h.find(['type']),
      incomeTypeValues: const ['Income'],
      expenseTypeValues: const ['Expense'],
      accountColumn: h.find(['wallet']),
      categoryColumn: h.find(['category name']),
      dateColumn: h.find(['date']),
      notesColumn: h.find(['note']),
      tagsColumn: h.find(['labels']),
      tagSeparator: ',',
    ),
  );

  /// Used when the file does not come from a known app. Columns are guessed
  /// by their usual names and the user can review everything.
  static final generic = CsvImportTemplate(
    id: 'generic',
    name: 'CSV',
    icon: Icons.table_chart_rounded,
    color: const Color(0xFF607D8B),
    exportHint: (t) => t.backup.import.templates.generic_hint,
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
        transferColumn:
            h.find(['to account', 'destination account', 'destination']) == null
            ? h.find(['type'])
            : null,
        transferValues: const ['transfer'],
      );
    },
  );

  /// Known apps, in the order they are shown to the user
  static final List<CsvImportTemplate> apps = [
    myExpenses,
    cashew,
    wallet,
    spendee,
  ];
}
