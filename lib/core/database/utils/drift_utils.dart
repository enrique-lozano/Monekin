import 'package:drift/drift.dart';

/// Return a WHERE clause expression that is the equivalent to the conjunction of some expressions. If no expressions are passed, the WHERE clause will have no effect.
Expression<bool> buildDriftExpr(List<Expression<bool>> expressions) {
  if (expressions.isEmpty) return const CustomExpression('(TRUE)');

  Expression<bool> toReturn = expressions.first;

  for (var i = 1; i < expressions.length; i++) {
    final exprToPush = expressions[i];

    toReturn = toReturn & exprToPush;
  }

  return toReturn;
}
