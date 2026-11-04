import 'package:csv/csv.dart';
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
      expect(parseCsvAmount('1e3'), 1000);
      expect(parseCsvAmount('1.5E-7'), 1.5e-7);
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

  group('Cashew template', () {
    const file = '''
account,amount,amount unpaid,currency,title,note,date,income,type,category name,subcategory name,color,icon,emoji,budget,objective,extra
Banco,500,,USD,Salary,,2026-11-03 18:58:42.000,true,default,Ingreso,,0XFF9575CD,coin,,,,repeat every 1 month
Banco,-85,,USD,jyhr,,2026-11-03 18:58:27.000,false,default,Compras,,0XFFE91E63,shopping,,,,repeat every 1 month
fdlkl,24,,USD,fdlkl Transferir a,"Saldo transferido
Banco → fdlkl",2026-09-10 19:00:31.000,true,default,Corrección de Balance,,0XFF607D8B,charts,,,,
Banco,-25,,USD,Banco Transferir de,"Saldo transferido
Banco → fdlkl",2026-09-10 19:00:30.000,false,default,Corrección de Balance,,0XFF607D8B,charts,,,,
fdlkl,33,,USD,,"Saldo total actualizado
fdlkl: 33 \$",2026-05-15 17:51:31.000,true,default,Corrección de Balance,,0XFF607D8B,charts,,,,
''';

    final data = Csv()
        .decode(file)
        .map((r) => r.map((e) => e.toString()).toList())
        .toList();
    final headers = data.first;

    test('is detected from the headers', () {
      expect(CsvImportTemplates.cashew.matches(headers), isTrue);
      expect(CsvImportTemplates.wallet.matches(headers), isFalse);
    });

    test('rebuilds the two rows of a transfer as one transaction', () {
      final mapping = CsvImportTemplates.cashew.mappingFor(headers);
      final result = CsvTransactionParser(mapping).parse(data.sublist(1));

      expect(result.skippedRows, isEmpty);
      expect(result.unpairedTransfers, 0);
      expect(result.transactions, hasLength(4));

      final transfer = result.transactions.singleWhere(
        (e) => e.type.isTransfer,
      );
      expect(transfer.accountName, 'Banco');
      expect(transfer.receivingAccountName, 'fdlkl');
      expect(transfer.amount, 25);
      expect(transfer.valueInDestiny, 24);
      expect(transfer.categoryName, isNull);

      expect(result.countOf(TransactionType.income), 2);
      expect(result.countOf(TransactionType.expense), 1);
    });
  });

  group('Wallet and Spendee templates', () {
    final walletHeaders = [
      'account',
      'category',
      'currency',
      'amount',
      'ref_currency_amount',
      'type',
      'payment_type',
      'note',
      'date',
      'payee',
      'labels',
    ];

    List<String> row(
      String account,
      String category,
      String amount,
      String type,
      String date,
    ) => [account, category, 'USD', amount, amount, type, '', '', date, '', ''];

    test(
      'read the direction from the type, whatever the sign of the amount',
      () {
        final mapping = CsvImportTemplates.wallet.mappingFor(walletHeaders);
        final result = CsvTransactionParser(mapping).parse([
          row('Bank', 'Food', '12.5', 'Expense', '2025-01-01T10:00:00.000Z'),
          row('Bank', 'Salary', '100', 'Income', '2025-01-02T10:00:00.000Z'),
          row('Bank', 'Food', '-3', 'Expenses', '2025-01-03T10:00:00.000Z'),
        ]);

        expect(result.transactions.map((e) => e.type), [
          TransactionType.expense,
          TransactionType.income,
          TransactionType.expense,
        ]);
        expect(result.transactions.map((e) => e.amount), [12.5, 100, 3]);
      },
    );

    test('join the transfer legs, even when the marker is translated', () {
      final mapping = CsvImportTemplates.wallet.mappingFor(walletHeaders);
      final result = CsvTransactionParser(mapping).parse([
        row(
          'Bank',
          'Transferir, retirar',
          '50',
          'Gasto',
          '2025-01-01T10:00:00',
        ),
        row(
          'Cash',
          'Transferir, retirar',
          '50',
          'Ingreso',
          '2025-01-01T10:00:00',
        ),
      ]);

      final transfer = result.transactions.single;
      expect(transfer.type, TransactionType.transfer);
      expect(transfer.accountName, 'Bank');
      expect(transfer.receivingAccountName, 'Cash');
    });

    test('are only detected with their own headers', () {
      expect(
        CsvImportTemplates.wallet.matches([
          'account',
          'category',
          'amount',
          'date',
          'destination account',
        ]),
        isFalse,
      );
      expect(
        CsvImportTemplates.spendee.matches([
          'Date',
          'Wallet',
          'Type',
          'Category name',
          'Amount',
          'Currency',
          'Note',
        ]),
        isTrue,
      );
    });
  });

  group('Transfer rows', () {
    test('without account are reported as unpaired instead of failing', () {
      final result =
          CsvTransactionParser(
            const CsvImportMapping(
              amountColumn: 0,
              accountColumn: 1,
              dateColumn: 2,
              transferColumn: 3,
              transferValues: ['yes'],
            ),
          ).parse([
            ['-10', 'Bank', '2025-01-01T10:00:00', 'yes'],
            ['10', '', '2025-01-01T10:00:00', 'yes'],
          ]);

      expect(result.unpairedTransfers, 2);
      expect(result.transactions.map((e) => e.receivingAccountName), [
        null,
        null,
      ]);
    });

    test('with a destination do not need their type to be listed', () {
      final result =
          CsvTransactionParser(
            const CsvImportMapping(
              amountMode: CsvAmountMode.typeColumn,
              amountColumn: 0,
              typeColumn: 1,
              accountColumn: 2,
              destinationAccountColumn: 3,
              incomeTypeValues: ['Income'],
              expenseTypeValues: ['Expense'],
            ),
          ).parse([
            ['40', 'Transfer', 'Bank', 'Cash'],
            ['5', 'Income', 'Bank', ''],
          ]);

      expect(result.skippedRows, isEmpty);
      expect(result.transactions.first.type, TransactionType.transfer);
      expect(result.transactions.first.receivingAccountName, 'Cash');
    });

    test('with a blank origin account are not paired', () {
      final result =
          CsvTransactionParser(
            const CsvImportMapping(
              amountColumn: 0,
              accountColumn: 1,
              dateColumn: 2,
              transferColumn: 3,
              transferValues: ['yes'],
            ),
          ).parse([
            ['-10', '', '2025-01-01T10:00:00', 'yes'],
            ['10', 'Cash', '2025-01-01T10:00:00', 'yes'],
          ]);

      expect(result.unpairedTransfers, 2);
    });

    test('with the same note are joined together, whatever their amount', () {
      final result =
          CsvTransactionParser(
            const CsvImportMapping(
              amountColumn: 0,
              accountColumn: 1,
              dateColumn: 2,
              notesColumn: 3,
              transferColumn: 3,
              transferPattern: '→',
            ),
          ).parse([
            ['-100', 'A', '2025-01-01T10:00:00', 'A → B'],
            ['110', 'B', '2025-01-01T10:00:00', 'A → B'],
            ['-110', 'C', '2025-01-01T10:00:00', 'C → D'],
            ['100', 'D', '2025-01-01T10:00:00', 'C → D'],
          ]);

      expect(
        result.transactions.map(
          (e) => '${e.accountName}>${e.receivingAccountName}',
        ),
        ['A>B', 'C>D'],
      );
    });

    test('keep their amount when the type column marks them', () {
      final result =
          CsvTransactionParser(
            const CsvImportMapping(
              amountMode: CsvAmountMode.typeColumn,
              amountColumn: 0,
              typeColumn: 1,
              accountColumn: 2,
              destinationAccountColumn: 3,
              transferColumn: 1,
              transferValues: ['Transfer'],
            ),
          ).parse([
            ['40', 'Transfer', 'Bank', 'Cash'],
          ]);

      expect(result.transactions.single.type, TransactionType.transfer);
      expect(result.transactions.single.amount, 40);
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
