import 'dart:math' as math;

/// A rectangle produced by [squarifyTreemap].
class TreemapRect<T> {
  const TreemapRect({
    required this.item,
    required this.left,
    required this.top,
    required this.width,
    required this.height,
  });

  final T item;
  final double left;
  final double top;
  final double width;
  final double height;
}

/// Lays [items] out using the squarified treemap algorithm.
///
/// Items with a non-positive weight are ignored. The returned rectangles cover
/// the available area and retain the input order, which should normally be
/// descending by weight.
List<TreemapRect<T>> squarifyTreemap<T>({
  required List<T> items,
  required double Function(T item) weightOf,
  required double width,
  required double height,
}) {
  if (width <= 0 || height <= 0) return const [];

  final weightedItems = items
      .where((item) => weightOf(item) > 0)
      .map((item) => (item: item, weight: weightOf(item)))
      .toList();
  final totalWeight = weightedItems.fold<double>(
    0,
    (sum, item) => sum + item.weight,
  );
  if (totalWeight == 0) return const [];

  final scale = width * height / totalWeight;
  final normalized = [
    for (final item in weightedItems)
      (item: item.item, area: item.weight * scale),
  ];

  var left = 0.0;
  var top = 0.0;
  var remainingWidth = width;
  var remainingHeight = height;
  var index = 0;
  final rects = <TreemapRect<T>>[];

  while (index < normalized.length &&
      remainingWidth > 0 &&
      remainingHeight > 0) {
    final row = <({T item, double area})>[];
    var rowArea = 0.0;
    final side = math.min(remainingWidth, remainingHeight);

    while (index < normalized.length) {
      final candidate = normalized[index];
      final currentWorst = _worstAspectRatio(row, rowArea, side);
      final candidateWorst = _worstAspectRatio(
        [...row, candidate],
        rowArea + candidate.area,
        side,
      );
      if (row.isNotEmpty && candidateWorst > currentWorst) break;

      row.add(candidate);
      rowArea += candidate.area;
      index++;
    }

    // Each row is laid along the shorter side of the remaining area, which is
    // what keeps the tiles close to squares instead of thin strips.
    if (remainingWidth < remainingHeight) {
      final rowHeight = rowArea / remainingWidth;
      var x = left;
      for (final entry in row) {
        final itemWidth = entry.area / rowHeight;
        rects.add(
          TreemapRect(
            item: entry.item,
            left: x,
            top: top,
            width: itemWidth,
            height: rowHeight,
          ),
        );
        x += itemWidth;
      }
      top += rowHeight;
      remainingHeight -= rowHeight;
    } else {
      final rowWidth = rowArea / remainingHeight;
      var y = top;
      for (final entry in row) {
        final itemHeight = entry.area / rowWidth;
        rects.add(
          TreemapRect(
            item: entry.item,
            left: left,
            top: y,
            width: rowWidth,
            height: itemHeight,
          ),
        );
        y += itemHeight;
      }
      left += rowWidth;
      remainingWidth -= rowWidth;
    }
  }

  return rects;
}

double _worstAspectRatio<T>(
  List<({T item, double area})> row,
  double rowArea,
  double side,
) {
  if (row.isEmpty || rowArea == 0 || side == 0) return double.infinity;

  final smallest = row.map((item) => item.area).reduce(math.min);
  final largest = row.map((item) => item.area).reduce(math.max);
  final sideSquared = side * side;
  final areaSquared = rowArea * rowArea;

  return math.max(
    sideSquared * largest / areaSquared,
    areaSquared / (sideSquared * smallest),
  );
}
