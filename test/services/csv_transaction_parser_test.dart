import 'package:flutter_test/flutter_test.dart';
import 'package:monekin/core/models/transaction/transaction_type.enum.dart';
import 'package:monekin/core/services/csv_import/csv_import_mapping.dart';
import 'package:monekin/core/services/csv_import/csv_import_templates.dart';
import 'package:monekin/core/services/csv_import/csv_transaction_parser.dart';

void main() {
  group('parseCsvAmount', () {
    test('supports the usual number notations', () {
      expect(parseCsvAmount('100.00'), 100);
      expect(parseCsvAmount('-12,5'), -12.5);
      expect(parseCsvAmount('1,234.56'), 1234.56);
      expect(parseCsvAmount('1.234,56'), 1234.56);
      expect(parseCsvAmount('1,234'), 1234);
      expect(parseCsvAmount(r'$ 1 250.5'), 1250.5);
      expect(parseCsvAmount('(40)'), -40);
    });

    test('returns null for non numeric text', () {
      expect(parseCsvAmount(''), isNull);
      expect(parseCsvAmount('abc'), isNull);
    });
  });

  group('MyExpenses template (issue #287)', () {
    final headers = [
      'Split transaction',
      'Date',
      'Time',
      'Payee/Payer',
      'Income',
      'Expense',
      'Category 1',
      'Category 2',
      'Notes',
      'Payment method',
      'Status',
      'Reference Number',
      'Picture',
      'Tags',
    ];

    final rows = [
      ['', '02/01/2025', '00:40', 'Shop Keeper', '0', '100.00', 'Leisures'],
      ['', '02/01/2025', '00:40', 'Bike Shopper', '150.00', '0', 'Car'],
      ['', '02/01/2025', '00:41', 'Cashed Out', '0', '50.00', 'Cash'],
    ].map((r) => [...r, ...List.filled(14 - r.length, '')]).toList();

    test('is detected from the headers', () {
      expect(CsvImportTemplates.myExpenses.matches(headers), isTrue);
      expect(CsvImportTemplates.cashew.matches(headers), isFalse);
    });

    test('reads incomes and expenses from separate columns', () {
      final mapping = CsvImportTemplates.myExpenses.mappingFor(headers);
      final result = CsvTransactionParser(mapping).parse(rows);

      expect(result.skippedRows, isEmpty);
      expect(result.transactions.map((e) => e.type), [
        TransactionType.expense,
        TransactionType.income,
        TransactionType.expense,
      ]);
      expect(result.transactions.map((e) => e.amount), [100, 150, 50]);
      expect(result.transactions.first.title, 'Shop Keeper');
      expect(result.transactions.first.categoryName, 'Leisures');
      expect(result.transactions.first.date, DateTime(2025, 1, 2, 0, 40));
    });
  });

  group('Transfers', () {
    test('a single row with a destination account is one transfer', () {
      final result =
          CsvTransactionParser(
            const CsvImportMapping(
              amountColumn: 0,
              accountColumn: 1,
              destinationAccountColumn: 2,
            ),
          ).parse([
            ['-50', 'Bank', 'Cash'],
            ['20', 'Bank', ''],
          ]);

      expect(result.transactions, hasLength(2));

      final transfer = result.transactions.first;
      expect(transfer.type, TransactionType.transfer);
      expect(transfer.amount, 50);
      expect(transfer.accountName, 'Bank');
      expect(transfer.receivingAccountName, 'Cash');
      expect(result.transactions.last.type, TransactionType.income);
    });

    final walletMapping = CsvImportMapping(
      amountColumn: 0,
      accountColumn: 1,
      dateColumn: 2,
      transferColumn: 3,
      transferValues: const ['true'],
    );

    test('pairs the two legs of a transfer in one transaction', () {
      final result = CsvTransactionParser(walletMapping).parse([
        ['-100', 'Bank', '2025-01-01T10:00:00', 'true'],
        ['-5', 'Bank', '2025-01-01T11:00:00', 'false'],
        ['100', 'Cash', '2025-01-01T10:00:00', 'true'],
      ]);

      expect(result.unpairedTransfers, 0);
      expect(result.transactions, hasLength(2));
      expect(result.countOf(TransactionType.transfer), 1);

      final transfer = result.transactions.firstWhere((e) => e.type.isTransfer);
      expect(transfer.accountName, 'Bank');
      expect(transfer.receivingAccountName, 'Cash');
      expect(transfer.amount, 100);
      expect(transfer.valueInDestiny, isNull);
    });

    test('keeps the received amount when the legs differ', () {
      final result = CsvTransactionParser(walletMapping).parse([
        ['-100', 'EUR account', '2025-01-01T10:00:00', 'true'],
        ['110', 'USD account', '2025-01-01T10:00:00', 'true'],
      ]);

      expect(result.transactions.single.amount, 100);
      expect(result.transactions.single.valueInDestiny, 110);
    });

    test('imports as regular transactions the legs without counterpart', () {
      final result = CsvTransactionParser(walletMapping).parse([
        ['-100', 'Bank', '2025-01-01T10:00:00', 'true'],
      ]);

      expect(result.unpairedTransfers, 1);
      expect(result.transactions.single.type, TransactionType.expense);
    });
  });

  group('Type column', () {
    const mapping = CsvImportMapping(
      amountMode: CsvAmountMode.typeColumn,
      amountColumn: 0,
      typeColumn: 1,
      incomeTypeValues: ['Income'],
      expenseTypeValues: ['Expense', 'Spending'],
    );

    test('uses the type column instead of the amount sign', () {
      final result = CsvTransactionParser(mapping).parse([
        ['30', 'income'],
        ['30', 'Spending'],
        ['30', 'Mystery'],
      ]);

      expect(result.transactions.map((e) => e.type), [
        TransactionType.income,
        TransactionType.expense,
      ]);
      expect(result.skippedRows, {3: CsvRowIssue.unknownType});
    });
  });

  test('skips the rows that can not be read', () {
    final result =
        CsvTransactionParser(
          const CsvImportMapping(
            amountColumn: 0,
            dateColumn: 1,
            dateFormat: 'dd/MM/yyyy',
          ),
        ).parse([
          ['10', '31/01/2025'],
          ['abc', '31/01/2025'],
          ['10', 'yesterday'],
        ]);

    expect(result.transactions, hasLength(1));
    expect(result.skippedRows, {
      2: CsvRowIssue.invalidAmount,
      3: CsvRowIssue.invalidDate,
    });
  });
}
