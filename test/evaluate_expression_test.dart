import 'package:flutter_test/flutter_test.dart';
import 'package:monekin/app/transactions/form/dialogs/evaluate_expression.dart';

void main() {
  group('evaluateExpression tests', () {
    test('Single number', () {
      expect(evaluateExpression('34'), equals(34.0));
    });

    test('Single negative number', () {
      expect(evaluateExpression('-34'), equals(-34.0));
    });

    test('Simple addition', () {
      expect(evaluateExpression('34 + 3'), equals(37.0));
    });

    test('Simple addition without spaces', () {
      expect(evaluateExpression('34+3'), equals(37.0));
    });

    test('Multiple operations with spaces', () {
      expect(evaluateExpression('24 + 4 - 2'), equals(26.0));
    });

    test('Simple division', () {
      expect(evaluateExpression('22/2'), equals(11.0));
    });

    test('Expression with leading negative number', () {
      expect(evaluateExpression('-3 + 4'), equals(1.0));
    });

    test('Trailing operator is ignored', () {
      expect(evaluateExpression('34+'), equals(34.0));
    });

    test('Trailing operator with multiple operations', () {
      expect(evaluateExpression('22/2*'), equals(11.0));
    });

    test('Complex expression with negative and positive numbers', () {
      expect(evaluateExpression('-3 + 4 - 5'), equals(-4.0));
    });

    test('Multiple operations without spaces', () {
      expect(evaluateExpression('2*3+4/2'), equals(8.0));
    });

    test('Expression with floating point numbers', () {
      expect(evaluateExpression('10.5 + 2.5'), equals(13.0));
    });

    test('Expression with multiple operators in sequence', () {
      expect(evaluateExpression('3 * 2 / 3'), equals(2.0));
    });

    test('Invalid expression with only operators', () {
      expect(() => evaluateExpression('+'), throwsArgumentError);
    });
  });
}
