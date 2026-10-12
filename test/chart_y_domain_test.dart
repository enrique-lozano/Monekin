import 'package:flutter_test/flutter_test.dart';
import 'package:monekin/core/presentation/widgets/evolution_charts/monetary_evolution_chart_shared.dart';

void main() {
  group('computeMonetaryChartYDomain', () {
    test('returns a safe domain for empty data', () {
      final domain = computeMonetaryChartYDomain(const []);

      expect(domain.minY, -1);
      expect(domain.maxY, 1);
      expect(domain.areaFillCutoffY, domain.minY);
    });

    test('gives a flat series visible space around its value', () {
      final domain = computeMonetaryChartYDomain(const [500, 500]);

      expect(domain.minY, lessThan(500));
      expect(domain.maxY, greaterThan(500));
      expect(domain.maxY - domain.minY, greaterThanOrEqualTo(10));
    });

    test('enforces relative span for large near-flat values', () {
      final domain = computeMonetaryChartYDomain(const [100000, 100050]);

      expect(domain.maxY - domain.minY, greaterThanOrEqualTo(2001));
    });

    test('adds proportional padding to a normal range', () {
      final domain = computeMonetaryChartYDomain(const [100, 200]);

      expect(domain.minY, 88);
      expect(domain.maxY, 212);
    });

    test('uses the viewport floor as cutoff for negative values', () {
      final domain = computeMonetaryChartYDomain(const [-1000, -950]);

      expect(domain.maxY, lessThan(0));
      expect(domain.areaFillCutoffY, domain.minY);
    });

    test('supports mixed-sign values without forcing zero cutoff', () {
      final domain = computeMonetaryChartYDomain(const [-50, 200]);

      expect(domain.minY, lessThan(-50));
      expect(domain.maxY, greaterThan(200));
      expect(domain.areaFillCutoffY, domain.minY);
    });

    test('zero anchor includes zero and fills to it', () {
      final domain = computeMonetaryChartYDomain(const [
        500,
        800,
      ], anchorZero: true);

      expect(domain.minY, 0);
      expect(domain.maxY, greaterThan(800));
      expect(domain.areaFillCutoffY, 0);
    });

    test('includes extra reference values in the domain', () {
      final domain = computeMonetaryChartYDomain(
        const [100, 200],
        extraValues: const [1000],
        anchorZero: true,
      );

      expect(domain.minY, 0);
      expect(domain.maxY, greaterThan(1000));
    });

    test('ignores non-finite values', () {
      final domain = computeMonetaryChartYDomain(const [
        double.nan,
        double.infinity,
        10,
      ]);

      expect(domain.minY.isFinite, isTrue);
      expect(domain.maxY.isFinite, isTrue);
    });
  });
}
