/// Defines the direction of a financial target.
enum FinancialTargetDirection {
  /// For targets where we want to accumulate money (e.g., Savings Goal, Income Goal).
  ///
  /// The transaction balance contributes positively as is (e.g., +100 income counts as +100 progress).
  toIncome,

  /// For targets where we want to track spending (e.g., Budget, Expense Goal).
  ///
  /// The transaction balance is typically negative for expenses, so we invert it to track progress
  /// (e.g., -50 expense counts as +50 used of the budget).
  toExpense;

  bool get isInverted => this == FinancialTargetDirection.toExpense;
}
