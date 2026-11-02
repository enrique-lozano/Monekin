import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:monekin/core/database/app_db.dart';
import 'package:monekin/core/database/services/category/category_service.dart';
import 'package:monekin/core/database/services/transaction/transaction_service.dart';
import 'package:monekin/core/models/category/category.dart';
import 'package:monekin/core/models/date-utils/periodicity.dart';
import 'package:monekin/core/models/transaction/transaction_status.enum.dart';
import 'package:monekin/core/models/transaction/transaction_type.enum.dart';

void main() {
  late AppDB db;
  late CategoryService service;
  late TransactionService transactionService;

  setUp(() async {
    db = AppDB.forTesting(NativeDatabase.memory());
    service = CategoryService.forTesting(db);
    transactionService = TransactionService.forTesting(db);

    await db
        .into(db.categories)
        .insert(
          const CategoryInDB(
            id: 'parent',
            name: 'Parent',
            iconId: 'wallet',
            color: '#4385be',
            type: CategoryType.B,
            displayOrder: 0,
          ),
        );
    await db
        .into(db.categories)
        .insert(
          const CategoryInDB(
            id: 'income-only',
            name: 'Income only',
            iconId: 'wallet',
            color: '#4385be',
            type: CategoryType.I,
            displayOrder: 1,
          ),
        );
    await db
        .into(db.categories)
        .insert(
          const CategoryInDB(
            id: 'child',
            name: 'Child',
            iconId: 'wallet',
            parentCategoryID: 'parent',
            displayOrder: 0,
          ),
        );
  });

  tearDown(() async {
    await db.close();
  });

  Future<void> insertTransaction(
    String id, {
    required String categoryId,
    required TransactionType type,
    TransactionStatus? status,
    bool isHidden = false,
    Periodicity? intervalPeriod,
  }) async {
    await db
        .into(db.transactions)
        .insert(
          TransactionInDB(
            id: id,
            date: DateTime(2026, 1, 1),
            accountID: 'account',
            categoryID: categoryId,
            value: type == TransactionType.expense ? -10 : 10,
            type: type,
            isHidden: isHidden,
            status: status,
            intervalPeriod: intervalPeriod,
            intervalEach: intervalPeriod == null ? null : 1,
          ),
        );
  }

  Future<bool> updateParentType(CategoryType type) async {
    final current = await (db.select(
      db.categories,
    )..where((tbl) => tbl.id.equals('parent'))).getSingle();

    return service.updateCategory(
      CategoryInDB(
        id: current.id,
        name: current.name,
        iconId: current.iconId,
        color: current.color,
        type: type,
        displayOrder: current.displayOrder,
      ),
    );
  }

  test(
    'allows narrowing a category when all linked transactions are valid',
    () async {
      await insertTransaction(
        'expense',
        categoryId: 'child',
        type: TransactionType.expense,
        status: TransactionStatus.pending,
        isHidden: true,
        intervalPeriod: Periodicity.month,
      );

      expect(await updateParentType(CategoryType.E), isTrue);
      expect(
        (await (db.select(
          db.categories,
        )..where((tbl) => tbl.id.equals('parent'))).getSingle()).type,
        CategoryType.E,
      );
    },
  );

  test(
    'rejects narrowing when a subcategory has a conflicting transaction',
    () async {
      await insertTransaction(
        'parent-income',
        categoryId: 'parent',
        type: TransactionType.income,
      );
      await insertTransaction(
        'child-income',
        categoryId: 'child',
        type: TransactionType.income,
        status: TransactionStatus.pending,
        isHidden: true,
        intervalPeriod: Periodicity.month,
      );

      await expectLater(
        updateParentType(CategoryType.E),
        throwsA(
          isA<CategoryTypeChangeException>()
              .having(
                (error) => error.transactionType,
                'transactionType',
                TransactionType.income,
              )
              .having((error) => error.count, 'count', 2),
        ),
      );

      expect(
        (await (db.select(
          db.categories,
        )..where((tbl) => tbl.id.equals('parent'))).getSingle()).type,
        CategoryType.B,
      );
    },
  );

  test('rejects income-only when direct expenses are assigned', () async {
    await insertTransaction(
      'expense',
      categoryId: 'parent',
      type: TransactionType.expense,
    );

    await expectLater(
      updateParentType(CategoryType.I),
      throwsA(
        isA<CategoryTypeChangeException>()
            .having(
              (error) => error.transactionType,
              'transactionType',
              TransactionType.expense,
            )
            .having((error) => error.count, 'count', 1),
      ),
    );
  });

  test(
    'allows changing to Both regardless of linked transaction types',
    () async {
      await updateParentType(CategoryType.E);
      await insertTransaction(
        'expense',
        categoryId: 'parent',
        type: TransactionType.expense,
      );
      await insertTransaction(
        'income',
        categoryId: 'child',
        type: TransactionType.income,
      );

      expect(await updateParentType(CategoryType.B), isTrue);
    },
  );

  test(
    'reports whether the current category supports a transaction type',
    () async {
      await updateParentType(CategoryType.E);

      expect(
        await service.supportsTransactionType(
          'parent',
          TransactionType.expense,
        ),
        isTrue,
      );
      expect(
        await service.supportsTransactionType('parent', TransactionType.income),
        isFalse,
      );
      expect(
        await service.supportsTransactionType(
          'missing',
          TransactionType.expense,
        ),
        isFalse,
      );
    },
  );

  test(
    'transaction service rejects new transactions with incompatible categories',
    () async {
      await updateParentType(CategoryType.E);

      await expectLater(
        transactionService.insertTransaction(
          TransactionInDB(
            id: 'income',
            date: DateTime(2026, 1, 1),
            accountID: 'account',
            categoryID: 'parent',
            value: 10,
            type: TransactionType.income,
            isHidden: false,
          ),
        ),
        throwsA(isA<TransactionCategoryTypeMismatchException>()),
      );
    },
  );

  test(
    'transaction service rejects changing to an incompatible category',
    () async {
      await insertTransaction(
        'expense',
        categoryId: 'parent',
        type: TransactionType.expense,
      );

      final transaction = await (db.select(
        db.transactions,
      )..where((tbl) => tbl.id.equals('expense'))).getSingle();

      await expectLater(
        transactionService.updateTransaction(
          transaction.copyWith(categoryID: const Value('income-only')),
        ),
        throwsA(isA<TransactionCategoryTypeMismatchException>()),
      );
    },
  );
}
