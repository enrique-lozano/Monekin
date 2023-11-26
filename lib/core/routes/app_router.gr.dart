// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    AboutRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const AboutPage(),
      );
    },
    AccountDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<AccountDetailsRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: AccountDetailsPage(
          key: args.key,
          account: args.account,
        ),
      );
    },
    AccountFormRoute.name: (routeData) {
      final args = routeData.argsAs<AccountFormRouteArgs>(
          orElse: () => const AccountFormRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: AccountFormPage(
          key: args.key,
          account: args.account,
        ),
      );
    },
    AdvancedSettingsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const AdvancedSettingsPage(),
      );
    },
    AllAccountsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const AllAccountsPage(),
      );
    },
    BackupSettingsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const BackupSettingsPage(),
      );
    },
    BudgetDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<BudgetDetailsRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: BudgetDetailsPage(
          key: args.key,
          budget: args.budget,
        ),
      );
    },
    BudgetFormRoute.name: (routeData) {
      final args = routeData.argsAs<BudgetFormRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: BudgetFormPage(
          key: args.key,
          budgetToEdit: args.budgetToEdit,
          prevPage: args.prevPage,
        ),
      );
    },
    BudgetsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const BudgetsPage(),
      );
    },
    CategoriesListRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CategoriesListPage(),
      );
    },
    CategoryFormRoute.name: (routeData) {
      final args = routeData.argsAs<CategoryFormRouteArgs>(
          orElse: () => const CategoryFormRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CategoryFormPage(
          key: args.key,
          categoryUUID: args.categoryUUID,
        ),
      );
    },
    CurrencyManagerRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const CurrencyManagerPage(),
      );
    },
    DashboardRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const DashboardPage(),
      );
    },
    ExchangeRateDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<ExchangeRateDetailsRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ExchangeRateDetailsPage(
          key: args.key,
          currency: args.currency,
        ),
      );
    },
    ExportDataRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ExportDataPage(),
      );
    },
    HelpUsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const HelpUsPage(),
      );
    },
    ImportCSVRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ImportCSVPage(),
      );
    },
    IntroRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const IntroPage(),
      );
    },
    MainLayoutRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const MainLayoutPage(),
      );
    },
    OnboardingRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const OnboardingPage(),
      );
    },
    RecurrentTransactionRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const RecurrentTransactionPage(),
      );
    },
    SettingsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SettingsPage(),
      );
    },
    StatsRoute.name: (routeData) {
      final args = routeData.argsAs<StatsRouteArgs>(
          orElse: () => const StatsRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: StatsPage(
          key: args.key,
          initialIndex: args.initialIndex,
        ),
      );
    },
    TagFormRoute.name: (routeData) {
      final args = routeData.argsAs<TagFormRouteArgs>(
          orElse: () => const TagFormRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: TagFormPage(
          key: args.key,
          tag: args.tag,
        ),
      );
    },
    TagListRoute.name: (routeData) {
      final args = routeData.argsAs<TagListRouteArgs>(
          orElse: () => const TagListRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: TagListPage(
          key: args.key,
          isModal: args.isModal,
          selected: args.selected,
        ),
      );
    },
    TransactionDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<TransactionDetailsRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: TransactionDetailsPage(
          key: args.key,
          transaction: args.transaction,
          prevPage: args.prevPage,
        ),
      );
    },
    TransactionFormRoute.name: (routeData) {
      final args = routeData.argsAs<TransactionFormRouteArgs>(
          orElse: () => const TransactionFormRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: TransactionFormPage(
          key: args.key,
          transactionToEdit: args.transactionToEdit,
          mode: args.mode,
          fromAccount: args.fromAccount,
          toAccount: args.toAccount,
        ),
      );
    },
    TransactionsRoute.name: (routeData) {
      final args = routeData.argsAs<TransactionsRouteArgs>(
          orElse: () => const TransactionsRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: TransactionsPage(
          key: args.key,
          filters: args.filters,
        ),
      );
    },
  };
}

/// generated route for
/// [AboutPage]
class AboutRoute extends PageRouteInfo<void> {
  const AboutRoute({List<PageRouteInfo>? children})
      : super(
          AboutRoute.name,
          initialChildren: children,
        );

  static const String name = 'AboutRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [AccountDetailsPage]
class AccountDetailsRoute extends PageRouteInfo<AccountDetailsRouteArgs> {
  AccountDetailsRoute({
    Key? key,
    required Account account,
    List<PageRouteInfo>? children,
  }) : super(
          AccountDetailsRoute.name,
          args: AccountDetailsRouteArgs(
            key: key,
            account: account,
          ),
          initialChildren: children,
        );

  static const String name = 'AccountDetailsRoute';

  static const PageInfo<AccountDetailsRouteArgs> page =
      PageInfo<AccountDetailsRouteArgs>(name);
}

class AccountDetailsRouteArgs {
  const AccountDetailsRouteArgs({
    this.key,
    required this.account,
  });

  final Key? key;

  final Account account;

  @override
  String toString() {
    return 'AccountDetailsRouteArgs{key: $key, account: $account}';
  }
}

/// generated route for
/// [AccountFormPage]
class AccountFormRoute extends PageRouteInfo<AccountFormRouteArgs> {
  AccountFormRoute({
    Key? key,
    Account? account,
    List<PageRouteInfo>? children,
  }) : super(
          AccountFormRoute.name,
          args: AccountFormRouteArgs(
            key: key,
            account: account,
          ),
          initialChildren: children,
        );

  static const String name = 'AccountFormRoute';

  static const PageInfo<AccountFormRouteArgs> page =
      PageInfo<AccountFormRouteArgs>(name);
}

class AccountFormRouteArgs {
  const AccountFormRouteArgs({
    this.key,
    this.account,
  });

  final Key? key;

  final Account? account;

  @override
  String toString() {
    return 'AccountFormRouteArgs{key: $key, account: $account}';
  }
}

/// generated route for
/// [AdvancedSettingsPage]
class AdvancedSettingsRoute extends PageRouteInfo<void> {
  const AdvancedSettingsRoute({List<PageRouteInfo>? children})
      : super(
          AdvancedSettingsRoute.name,
          initialChildren: children,
        );

  static const String name = 'AdvancedSettingsRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [AllAccountsPage]
class AllAccountsRoute extends PageRouteInfo<void> {
  const AllAccountsRoute({List<PageRouteInfo>? children})
      : super(
          AllAccountsRoute.name,
          initialChildren: children,
        );

  static const String name = 'AllAccountsRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [BackupSettingsPage]
class BackupSettingsRoute extends PageRouteInfo<void> {
  const BackupSettingsRoute({List<PageRouteInfo>? children})
      : super(
          BackupSettingsRoute.name,
          initialChildren: children,
        );

  static const String name = 'BackupSettingsRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [BudgetDetailsPage]
class BudgetDetailsRoute extends PageRouteInfo<BudgetDetailsRouteArgs> {
  BudgetDetailsRoute({
    Key? key,
    required Budget budget,
    List<PageRouteInfo>? children,
  }) : super(
          BudgetDetailsRoute.name,
          args: BudgetDetailsRouteArgs(
            key: key,
            budget: budget,
          ),
          initialChildren: children,
        );

  static const String name = 'BudgetDetailsRoute';

  static const PageInfo<BudgetDetailsRouteArgs> page =
      PageInfo<BudgetDetailsRouteArgs>(name);
}

class BudgetDetailsRouteArgs {
  const BudgetDetailsRouteArgs({
    this.key,
    required this.budget,
  });

  final Key? key;

  final Budget budget;

  @override
  String toString() {
    return 'BudgetDetailsRouteArgs{key: $key, budget: $budget}';
  }
}

/// generated route for
/// [BudgetFormPage]
class BudgetFormRoute extends PageRouteInfo<BudgetFormRouteArgs> {
  BudgetFormRoute({
    Key? key,
    Budget? budgetToEdit,
    required Widget prevPage,
    List<PageRouteInfo>? children,
  }) : super(
          BudgetFormRoute.name,
          args: BudgetFormRouteArgs(
            key: key,
            budgetToEdit: budgetToEdit,
            prevPage: prevPage,
          ),
          initialChildren: children,
        );

  static const String name = 'BudgetFormRoute';

  static const PageInfo<BudgetFormRouteArgs> page =
      PageInfo<BudgetFormRouteArgs>(name);
}

class BudgetFormRouteArgs {
  const BudgetFormRouteArgs({
    this.key,
    this.budgetToEdit,
    required this.prevPage,
  });

  final Key? key;

  final Budget? budgetToEdit;

  final Widget prevPage;

  @override
  String toString() {
    return 'BudgetFormRouteArgs{key: $key, budgetToEdit: $budgetToEdit, prevPage: $prevPage}';
  }
}

/// generated route for
/// [BudgetsPage]
class BudgetsRoute extends PageRouteInfo<void> {
  const BudgetsRoute({List<PageRouteInfo>? children})
      : super(
          BudgetsRoute.name,
          initialChildren: children,
        );

  static const String name = 'BudgetsRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [CategoriesListPage]
class CategoriesListRoute extends PageRouteInfo<void> {
  const CategoriesListRoute({List<PageRouteInfo>? children})
      : super(
          CategoriesListRoute.name,
          initialChildren: children,
        );

  static const String name = 'CategoriesListRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [CategoryFormPage]
class CategoryFormRoute extends PageRouteInfo<CategoryFormRouteArgs> {
  CategoryFormRoute({
    Key? key,
    String? categoryUUID,
    List<PageRouteInfo>? children,
  }) : super(
          CategoryFormRoute.name,
          args: CategoryFormRouteArgs(
            key: key,
            categoryUUID: categoryUUID,
          ),
          initialChildren: children,
        );

  static const String name = 'CategoryFormRoute';

  static const PageInfo<CategoryFormRouteArgs> page =
      PageInfo<CategoryFormRouteArgs>(name);
}

class CategoryFormRouteArgs {
  const CategoryFormRouteArgs({
    this.key,
    this.categoryUUID,
  });

  final Key? key;

  final String? categoryUUID;

  @override
  String toString() {
    return 'CategoryFormRouteArgs{key: $key, categoryUUID: $categoryUUID}';
  }
}

/// generated route for
/// [CurrencyManagerPage]
class CurrencyManagerRoute extends PageRouteInfo<void> {
  const CurrencyManagerRoute({List<PageRouteInfo>? children})
      : super(
          CurrencyManagerRoute.name,
          initialChildren: children,
        );

  static const String name = 'CurrencyManagerRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [DashboardPage]
class DashboardRoute extends PageRouteInfo<void> {
  const DashboardRoute({List<PageRouteInfo>? children})
      : super(
          DashboardRoute.name,
          initialChildren: children,
        );

  static const String name = 'DashboardRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ExchangeRateDetailsPage]
class ExchangeRateDetailsRoute
    extends PageRouteInfo<ExchangeRateDetailsRouteArgs> {
  ExchangeRateDetailsRoute({
    Key? key,
    required Currency currency,
    List<PageRouteInfo>? children,
  }) : super(
          ExchangeRateDetailsRoute.name,
          args: ExchangeRateDetailsRouteArgs(
            key: key,
            currency: currency,
          ),
          initialChildren: children,
        );

  static const String name = 'ExchangeRateDetailsRoute';

  static const PageInfo<ExchangeRateDetailsRouteArgs> page =
      PageInfo<ExchangeRateDetailsRouteArgs>(name);
}

class ExchangeRateDetailsRouteArgs {
  const ExchangeRateDetailsRouteArgs({
    this.key,
    required this.currency,
  });

  final Key? key;

  final Currency currency;

  @override
  String toString() {
    return 'ExchangeRateDetailsRouteArgs{key: $key, currency: $currency}';
  }
}

/// generated route for
/// [ExportDataPage]
class ExportDataRoute extends PageRouteInfo<void> {
  const ExportDataRoute({List<PageRouteInfo>? children})
      : super(
          ExportDataRoute.name,
          initialChildren: children,
        );

  static const String name = 'ExportDataRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [HelpUsPage]
class HelpUsRoute extends PageRouteInfo<void> {
  const HelpUsRoute({List<PageRouteInfo>? children})
      : super(
          HelpUsRoute.name,
          initialChildren: children,
        );

  static const String name = 'HelpUsRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ImportCSVPage]
class ImportCSVRoute extends PageRouteInfo<void> {
  const ImportCSVRoute({List<PageRouteInfo>? children})
      : super(
          ImportCSVRoute.name,
          initialChildren: children,
        );

  static const String name = 'ImportCSVRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [IntroPage]
class IntroRoute extends PageRouteInfo<void> {
  const IntroRoute({List<PageRouteInfo>? children})
      : super(
          IntroRoute.name,
          initialChildren: children,
        );

  static const String name = 'IntroRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [MainLayoutPage]
class MainLayoutRoute extends PageRouteInfo<void> {
  const MainLayoutRoute({List<PageRouteInfo>? children})
      : super(
          MainLayoutRoute.name,
          initialChildren: children,
        );

  static const String name = 'MainLayoutRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [OnboardingPage]
class OnboardingRoute extends PageRouteInfo<void> {
  const OnboardingRoute({List<PageRouteInfo>? children})
      : super(
          OnboardingRoute.name,
          initialChildren: children,
        );

  static const String name = 'OnboardingRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [RecurrentTransactionPage]
class RecurrentTransactionRoute extends PageRouteInfo<void> {
  const RecurrentTransactionRoute({List<PageRouteInfo>? children})
      : super(
          RecurrentTransactionRoute.name,
          initialChildren: children,
        );

  static const String name = 'RecurrentTransactionRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SettingsPage]
class SettingsRoute extends PageRouteInfo<void> {
  const SettingsRoute({List<PageRouteInfo>? children})
      : super(
          SettingsRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingsRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [StatsPage]
class StatsRoute extends PageRouteInfo<StatsRouteArgs> {
  StatsRoute({
    Key? key,
    int initialIndex = 0,
    List<PageRouteInfo>? children,
  }) : super(
          StatsRoute.name,
          args: StatsRouteArgs(
            key: key,
            initialIndex: initialIndex,
          ),
          initialChildren: children,
        );

  static const String name = 'StatsRoute';

  static const PageInfo<StatsRouteArgs> page = PageInfo<StatsRouteArgs>(name);
}

class StatsRouteArgs {
  const StatsRouteArgs({
    this.key,
    this.initialIndex = 0,
  });

  final Key? key;

  final int initialIndex;

  @override
  String toString() {
    return 'StatsRouteArgs{key: $key, initialIndex: $initialIndex}';
  }
}

/// generated route for
/// [TagFormPage]
class TagFormRoute extends PageRouteInfo<TagFormRouteArgs> {
  TagFormRoute({
    Key? key,
    Tag? tag,
    List<PageRouteInfo>? children,
  }) : super(
          TagFormRoute.name,
          args: TagFormRouteArgs(
            key: key,
            tag: tag,
          ),
          initialChildren: children,
        );

  static const String name = 'TagFormRoute';

  static const PageInfo<TagFormRouteArgs> page =
      PageInfo<TagFormRouteArgs>(name);
}

class TagFormRouteArgs {
  const TagFormRouteArgs({
    this.key,
    this.tag,
  });

  final Key? key;

  final Tag? tag;

  @override
  String toString() {
    return 'TagFormRouteArgs{key: $key, tag: $tag}';
  }
}

/// generated route for
/// [TagListPage]
class TagListRoute extends PageRouteInfo<TagListRouteArgs> {
  TagListRoute({
    Key? key,
    bool isModal = false,
    List<Tag> selected = const <Tag>[],
    List<PageRouteInfo>? children,
  }) : super(
          TagListRoute.name,
          args: TagListRouteArgs(
            key: key,
            isModal: isModal,
            selected: selected,
          ),
          initialChildren: children,
        );

  static const String name = 'TagListRoute';

  static const PageInfo<TagListRouteArgs> page =
      PageInfo<TagListRouteArgs>(name);
}

class TagListRouteArgs {
  const TagListRouteArgs({
    this.key,
    this.isModal = false,
    this.selected = const <Tag>[],
  });

  final Key? key;

  final bool isModal;

  final List<Tag> selected;

  @override
  String toString() {
    return 'TagListRouteArgs{key: $key, isModal: $isModal, selected: $selected}';
  }
}

/// generated route for
/// [TransactionDetailsPage]
class TransactionDetailsRoute
    extends PageRouteInfo<TransactionDetailsRouteArgs> {
  TransactionDetailsRoute({
    Key? key,
    required MoneyTransaction transaction,
    required Widget prevPage,
    List<PageRouteInfo>? children,
  }) : super(
          TransactionDetailsRoute.name,
          args: TransactionDetailsRouteArgs(
            key: key,
            transaction: transaction,
            prevPage: prevPage,
          ),
          initialChildren: children,
        );

  static const String name = 'TransactionDetailsRoute';

  static const PageInfo<TransactionDetailsRouteArgs> page =
      PageInfo<TransactionDetailsRouteArgs>(name);
}

class TransactionDetailsRouteArgs {
  const TransactionDetailsRouteArgs({
    this.key,
    required this.transaction,
    required this.prevPage,
  });

  final Key? key;

  final MoneyTransaction transaction;

  final Widget prevPage;

  @override
  String toString() {
    return 'TransactionDetailsRouteArgs{key: $key, transaction: $transaction, prevPage: $prevPage}';
  }
}

/// generated route for
/// [TransactionFormPage]
class TransactionFormRoute extends PageRouteInfo<TransactionFormRouteArgs> {
  TransactionFormRoute({
    Key? key,
    MoneyTransaction? transactionToEdit,
    TransactionFormMode mode = TransactionFormMode.incomeOrExpense,
    Account? fromAccount,
    Account? toAccount,
    List<PageRouteInfo>? children,
  }) : super(
          TransactionFormRoute.name,
          args: TransactionFormRouteArgs(
            key: key,
            transactionToEdit: transactionToEdit,
            mode: mode,
            fromAccount: fromAccount,
            toAccount: toAccount,
          ),
          initialChildren: children,
        );

  static const String name = 'TransactionFormRoute';

  static const PageInfo<TransactionFormRouteArgs> page =
      PageInfo<TransactionFormRouteArgs>(name);
}

class TransactionFormRouteArgs {
  const TransactionFormRouteArgs({
    this.key,
    this.transactionToEdit,
    this.mode = TransactionFormMode.incomeOrExpense,
    this.fromAccount,
    this.toAccount,
  });

  final Key? key;

  final MoneyTransaction? transactionToEdit;

  final TransactionFormMode mode;

  final Account? fromAccount;

  final Account? toAccount;

  @override
  String toString() {
    return 'TransactionFormRouteArgs{key: $key, transactionToEdit: $transactionToEdit, mode: $mode, fromAccount: $fromAccount, toAccount: $toAccount}';
  }
}

/// generated route for
/// [TransactionsPage]
class TransactionsRoute extends PageRouteInfo<TransactionsRouteArgs> {
  TransactionsRoute({
    Key? key,
    TransactionFilters? filters,
    List<PageRouteInfo>? children,
  }) : super(
          TransactionsRoute.name,
          args: TransactionsRouteArgs(
            key: key,
            filters: filters,
          ),
          initialChildren: children,
        );

  static const String name = 'TransactionsRoute';

  static const PageInfo<TransactionsRouteArgs> page =
      PageInfo<TransactionsRouteArgs>(name);
}

class TransactionsRouteArgs {
  const TransactionsRouteArgs({
    this.key,
    this.filters,
  });

  final Key? key;

  final TransactionFilters? filters;

  @override
  String toString() {
    return 'TransactionsRouteArgs{key: $key, filters: $filters}';
  }
}
