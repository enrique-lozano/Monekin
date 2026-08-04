import 'dart:math' as math;

import 'package:flutter_test/flutter_test.dart';
import 'package:monekin/app/stats/widgets/portfolio/portfolio_treemap_layout.dart';

void main() {
  group('squarifyTreemap', () {
    test('uses the complete available area proportionally', () {
      final rects = squarifyTreemap(
        items: [6, 3, 1],
        weightOf: (item) => item.toDouble(),
        width: 300,
        height: 200,
      );

      final areaByItem = {
        for (final rect in rects) rect.item: rect.width * rect.height,
      };

      expect(rects, hasLength(3));
      expect(areaByItem[6]! / areaByItem[3]!, closeTo(2, 0.0001));
      expect(areaByItem[3]! / areaByItem[1]!, closeTo(3, 0.0001));
      expect(
        areaByItem.values.fold<double>(0, (sum, area) => sum + area),
        closeTo(60000, 0.01),
      );
    });

    test('keeps small tiles compact next to a dominant one', () {
      final rects = squarifyTreemap(
        items: [90, 2, 2, 2, 2, 2],
        weightOf: (item) => item.toDouble(),
        width: 860,
        height: 410,
      );

      final smallTiles = rects.where((rect) => rect.item == 2);

      expect(smallTiles, hasLength(5));
      for (final tile in smallTiles) {
        final aspectRatio = tile.width / tile.height;
        expect(math.max(aspectRatio, 1 / aspectRatio), lessThan(3));
      }
    });

    test('ignores non-positive weights', () {
      final rects = squarifyTreemap(
        items: [5, 0, -1],
        weightOf: (item) => item.toDouble(),
        width: 100,
        height: 100,
      );

      expect(rects.map((rect) => rect.item), [5]);
      expect(rects.single.width, closeTo(100, 0.0001));
      expect(rects.single.height, closeTo(100, 0.0001));
    });

    test('returns no rectangles when the canvas is empty', () {
      expect(
        squarifyTreemap(
          items: [1],
          weightOf: (item) => item.toDouble(),
          width: 0,
          height: 100,
        ),
        isEmpty,
      );
    });
  });
}
