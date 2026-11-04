import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart' show visibleForTesting;
import 'package:monekin/core/database/app_db.dart';
import 'package:monekin/core/database/services/category/category_service.dart';
import 'package:monekin/core/database/services/currency/currency_service.dart';
import 'package:monekin/core/database/services/tags/tags_service.dart';
import 'package:monekin/core/models/account/account.dart';
import 'package:monekin/core/models/category/category.dart';
import 'package:monekin/core/models/tags/tag.dart';
import 'package:monekin/core/models/transaction/transaction.dart';
import 'package:monekin/core/models/transaction/transaction_type.enum.dart';
import 'package:monekin/core/services/csv_import/csv_transaction_parser.dart';
import 'package:monekin/core/services/supported_icon/supported_icon_service.dart';
import 'package:monekin/core/utils/uuid.dart';

/// What to use when a CSV row does not say it (or says something unknown)
class CsvImportDefaults {
  const CsvImportDefaults({
    required this.category,
    this.account,
    this.tags = const [],
  });

  /// Category for the incomes/expenses whose category is missing or unknown
  final Category category;

  /// When set, it replaces the accounts that don't exist yet instead of
  /// creating new ones with the name found in the file
  final Account? account;

  final List<Tag> tags;
}

/// What an import is going to do, without writing anything
class CsvImportPreview {
  const CsvImportPreview({
    required this.total,
    required this.sample,
    required this.newAccountNames,
    required this.discardedTransfers,
  });

  /// Number of transactions that will be inserted
  final int total;

  /// The first transactions, ready to be displayed like the ones of the app
  final List<MoneyTransaction> sample;

  final List<String> newAccountNames;

  /// Transfers whose origin and destination end up in the same account
  final int discardedTransfers;
}

class _ImportPlan {
  _ImportPlan({
    required this.transactions,
    required this.tagLinks,
    required this.newAccounts,
    required this.discardedTransfers,
    required this.accountsById,
    required this.categoriesById,
    required this.tagsById,
  });

  final List<TransactionInDB> transactions;

  /// IDs of the tags of each transaction (by the ID of the transaction)
  final Map<String, List<String>> tagLinks;

  final List<AccountInDB> newAccounts;
  final int discardedTransfers;

  final Map<String, AccountInDB> accountsById;
  final Map<String, Category> categoriesById;
  final Map<String, Tag> tagsById;
}

/// Writes the transactions read from a CSV in the database
class CsvImportService {
  CsvImportService._(this.db)
    : _categories = CategoryService.instance,
      _tags = TagService.instance,
      _getPreferredCurrencyCode = _preferredCurrencyCode;

  static final CsvImportService instance = CsvImportService._(AppDB.instance);

  @visibleForTesting
  CsvImportService.forTesting(
    this.db, {
    required CategoryService categories,
    required TagService tags,
    required Future<String> Function() preferredCurrencyCode,
  }) : _categories = categories,
       _tags = tags,
       _getPreferredCurrencyCode = preferredCurrencyCode;

  final AppDB db;
  final CategoryService _categories;
  final TagService _tags;
  final Future<String> Function() _getPreferredCurrencyCode;

  static Future<String> _preferredCurrencyCode() async =>
      (await CurrencyService.instance.ensureAndGetPreferredCurrency().first)
          .code;

  static const _unknownAccountName = 'Account imported';

  /// Matches the [transactions] with the accounts, categories and tags of the
  /// database, deciding which accounts have to be created. It does not write
  /// anything. Everything is loaded once, so it scales to very large files.
  Future<_ImportPlan> _plan(
    List<ParsedCsvTransaction> transactions,
    CsvImportDefaults defaults,
  ) async {
    final preferredCurrencyCode = await _getPreferredCurrencyCode();

    final accountsByName = <String, AccountInDB>{
      for (final acc in await db.select(db.accounts).get())
        acc.name.toLowerCase(): acc,
    };

    // A new account can not be older than its first transaction
    final firstDateOfAccount = <String, DateTime>{};
    for (final tr in transactions) {
      for (final name in [
        tr.accountName ?? _unknownAccountName,
        ?tr.receivingAccountName,
      ]) {
        final key = name.toLowerCase();
        final current = firstDateOfAccount[key];
        if (current == null || tr.date.isBefore(current)) {
          firstDateOfAccount[key] = tr.date;
        }
      }
    }

    final newAccounts = <AccountInDB>[];

    AccountInDB resolveAccount(String name) {
      final key = name.toLowerCase();
      final known = accountsByName[key];

      if (known != null) return known;
      if (defaults.account != null) return defaults.account!;

      final created = AccountInDB(
        id: generateUUID(),
        name: name,
        iniValue: 0,
        displayOrder: 10,
        date: firstDateOfAccount[key] ?? DateTime.now(),
        type: AccountType.money,
        isSaving: false,
        trackingMode: AccountTrackingMode.transactions,
        iconId: SupportedIconService.instance.defaultSupportedIcon.id,
        currencyId: preferredCurrencyCode,
      );

      newAccounts.add(created);
      accountsByName[key] = created;

      return created;
    }

    // Subcategories take priority over parents with the same name
    final categories = await _categories.getCategories().first;
    final categoriesByName = <String, Category>{
      for (final cat in categories.where((c) => c.isMainCategory))
        cat.name.toLowerCase().trim(): cat,
      for (final cat in categories.where((c) => c.isChildCategory))
        cat.name.toLowerCase().trim(): cat,
    };

    final tags = await _tags.getTags().first;
    final tagsByName = {
      for (final tag in tags) tag.name.toLowerCase().trim(): tag,
    };

    var discardedTransfers = 0;
    final toInsert = <TransactionInDB>[];
    final tagLinks = <String, List<String>>{};
    final usedCategories = <String, Category>{
      defaults.category.id: defaults.category,
    };

    for (final tr in transactions) {
      final account = resolveAccount(tr.accountName ?? _unknownAccountName);
      final isTransfer = tr.type.isTransfer;

      AccountInDB? receivingAccount;
      if (isTransfer) {
        receivingAccount = resolveAccount(tr.receivingAccountName!);

        // Possible if the default account replaces both ends of the transfer
        if (receivingAccount.id == account.id) {
          discardedTransfers++;
          continue;
        }
      }

      final found = tr.categoryName == null
          ? null
          : categoriesByName[tr.categoryName!.toLowerCase().trim()];
      final category =
          found != null && found.type.matchWithTransactionType(tr.type)
          ? found
          : defaults.category;

      usedCategories[category.id] = category;

      final id = generateUUID();

      toInsert.add(
        TransactionInDB(
          id: id,
          date: tr.date,
          type: tr.type,
          accountID: account.id,
          value: tr.type == TransactionType.expense ? -tr.amount : tr.amount,
          valueInDestiny: isTransfer ? tr.valueInDestiny : null,
          receivingAccountID: receivingAccount?.id,
          categoryID: isTransfer ? null : category.id,
          isHidden: false,
          notes: tr.notes,
          title: tr.title,
        ),
      );

      final tagIds = tr.tags
          .map((name) => tagsByName[name.toLowerCase()]?.id)
          .nonNulls
          .toList();

      tagLinks[id] = tagIds.isEmpty
          ? defaults.tags.map((e) => e.id).toList()
          : tagIds;
    }

    return _ImportPlan(
      transactions: toInsert,
      tagLinks: tagLinks,
      newAccounts: newAccounts,
      discardedTransfers: discardedTransfers,
      accountsById: {
        for (final acc in [...accountsByName.values, ?defaults.account])
          acc.id: acc,
      },
      categoriesById: usedCategories,
      tagsById: {for (final tag in tags) tag.id: tag},
    );
  }

  /// What would happen if [transactions] were imported. Nothing is written.
  Future<CsvImportPreview> getPreview(
    List<ParsedCsvTransaction> transactions,
    CsvImportDefaults defaults, {
    int sampleSize = 5,
  }) async {
    final plan = await _plan(transactions, defaults);

    final currencies = {
      for (final c
          in await CurrencyService.instance.getAllCurrencies().first ??
              <CurrencyInDB>[])
        c.code: c,
    };

    MoneyTransaction toMoneyTransaction(TransactionInDB tr) {
      final account = plan.accountsById[tr.accountID]!;
      final receiving = plan.accountsById[tr.receivingAccountID];
      final category = plan.categoriesById[tr.categoryID];

      return MoneyTransaction(
        id: tr.id,
        date: tr.date,
        value: tr.value,
        valueInDestiny: tr.valueInDestiny,
        isHidden: false,
        type: tr.type,
        notes: tr.notes,
        title: tr.title,
        account: account,
        accountCurrency: currencies[account.currencyId]!,
        receivingAccount: receiving,
        receivingAccountCurrency: receiving == null
            ? null
            : currencies[receiving.currencyId],
        category: category,
        parentCategory: category?.parentCategory,
        currentValueInPreferredCurrency: tr.value,
        tags: [
          for (final id in plan.tagLinks[tr.id] ?? <String>[])
            ?plan.tagsById[id],
        ],
      );
    }

    return CsvImportPreview(
      total: plan.transactions.length,
      sample: plan.transactions
          .take(sampleSize)
          .map(toMoneyTransaction)
          .toList(),
      newAccountNames: plan.newAccounts.map((e) => e.name).toList(),
      discardedTransfers: plan.discardedTransfers,
    );
  }

  /// Inserts all the [transactions], creating the accounts that don't exist.
  /// Everything is written in a single database transaction, so an error
  /// leaves no half-imported data. Returns the number of inserted
  /// transactions.
  Future<int> importTransactions(
    List<ParsedCsvTransaction> transactions,
    CsvImportDefaults defaults,
  ) async {
    final plan = await _plan(transactions, defaults);

    await db.transaction(() async {
      await db.batch((batch) {
        batch.insertAll(db.accounts, plan.newAccounts);
        batch.insertAll(db.transactions, plan.transactions);
        batch.insertAll(db.transactionTags, [
          for (final entry in plan.tagLinks.entries)
            for (final tagId in entry.value)
              TransactionTag(transactionID: entry.key, tagID: tagId),
        ], mode: InsertMode.insertOrIgnore);
      });
    });

    // To update the getAccountsData() function results
    db.markTablesUpdated([db.accounts]);

    return plan.transactions.length;
  }
}
