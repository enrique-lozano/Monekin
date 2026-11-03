import 'package:monekin/core/database/app_db.dart';
import 'package:monekin/core/database/services/account/account_service.dart';
import 'package:monekin/core/database/services/category/category_service.dart';
import 'package:monekin/core/database/services/currency/currency_service.dart';
import 'package:monekin/core/database/services/tags/tags_service.dart';
import 'package:monekin/core/database/services/transaction/transaction_service.dart';
import 'package:monekin/core/models/account/account.dart';
import 'package:monekin/core/models/category/category.dart';
import 'package:monekin/core/models/tags/tag.dart';
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

/// Writes the transactions read from a CSV in the database
class CsvImportService {
  CsvImportService._(this.db);
  static final CsvImportService instance = CsvImportService._(AppDB.instance);

  final AppDB db;

  static const _unknownAccountName = 'Account imported';

  /// Name of each account that [transactions] would create in the database
  /// given the [defaults]. Nothing is written.
  Future<Set<String>> getAccountsToCreate(
    Iterable<ParsedCsvTransaction> transactions,
    CsvImportDefaults defaults,
  ) async {
    final existing = await _getExistingAccountNames();

    return {
      for (final name in _accountNamesOf(transactions))
        if (!existing.contains(name.toLowerCase()) && defaults.account == null)
          name,
    };
  }

  Iterable<String> _accountNamesOf(
    Iterable<ParsedCsvTransaction> transactions,
  ) sync* {
    for (final tr in transactions) {
      yield tr.accountName ?? _unknownAccountName;
      if (tr.receivingAccountName != null) yield tr.receivingAccountName!;
    }
  }

  Future<Set<String>> _getExistingAccountNames() async => {
    for (final acc in await db.select(db.accounts).get())
      acc.name.toLowerCase(),
  };

  /// Inserts all the [transactions], creating the accounts that don't exist.
  /// Returns the number of inserted transactions.
  Future<int> importTransactions(
    List<ParsedCsvTransaction> transactions,
    CsvImportDefaults defaults,
  ) async {
    final preferredCurrency = await CurrencyService.instance
        .ensureAndGetPreferredCurrency()
        .first;

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

    Future<AccountInDB> resolveAccount(String name) async {
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
        currencyId: preferredCurrency.code,
      );

      await AccountService.instance.insertAccount(created);
      accountsByName[key] = created;

      return created;
    }

    // Subcategories take priority over parents with the same name
    final categories = await CategoryService.instance.getCategories().first;
    final categoriesByName = <String, Category>{
      for (final cat in categories.where((c) => c.isMainCategory))
        cat.name.toLowerCase().trim(): cat,
      for (final cat in categories.where((c) => c.isChildCategory))
        cat.name.toLowerCase().trim(): cat,
    };

    final tagsByName = {
      for (final tag in await TagService.instance.getTags().first)
        tag.name.toLowerCase().trim(): tag,
    };

    final toInsert = <TransactionInDB>[];
    final tagLinks = <String, List<String>>{};

    for (final tr in transactions) {
      final account = await resolveAccount(
        tr.accountName ?? _unknownAccountName,
      );
      final isTransfer = tr.type.isTransfer;
      final id = generateUUID();

      AccountInDB? receivingAccount;
      if (isTransfer) {
        receivingAccount = await resolveAccount(tr.receivingAccountName!);

        // Possible if the default account replaces both ends of the transfer
        if (receivingAccount.id == account.id) continue;
      }

      final found = tr.categoryName == null
          ? null
          : categoriesByName[tr.categoryName!.toLowerCase().trim()];
      final category =
          found != null && found.type.matchWithTransactionType(tr.type)
          ? found
          : defaults.category;

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

    const batchSize = 10;

    for (var i = 0; i < toInsert.length; i += batchSize) {
      await Future.wait(
        toInsert
            .skip(i)
            .take(batchSize)
            .map(TransactionService.instance.insertTransaction),
      );
    }

    final links = tagLinks.entries.where((e) => e.value.isNotEmpty).toList();

    for (var i = 0; i < links.length; i += batchSize) {
      await Future.wait(
        links
            .skip(i)
            .take(batchSize)
            .map(
              (e) => TagService.instance.linkTagsToTransaction(
                transactionId: e.key,
                tagIds: e.value,
              ),
            ),
      );
    }

    return toInsert.length;
  }
}
