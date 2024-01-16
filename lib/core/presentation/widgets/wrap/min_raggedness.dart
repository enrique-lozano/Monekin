import 'dart:collection';
import 'dart:math';

// ignore: avoid_classes_with_only_static_members
class MinimumRaggedness {
  /// Given some [boxWidths], break it into the smallest possible number
  /// of lines such as each line has width not larger than [maxWidth].
  /// It also minimizes the difference between width of each line,
  /// achieving a "balanced" result.
  /// Optionally accepts a [spacing] between boxes.
  ///
  static List<List<int>> divide(List<num> boxWidths, num maxWidth,
      {num spacing = 0.0}) {
    int count = boxWidths.length;
    List<num> offsets = [0];

    for (num boxWidth in boxWidths) {
      offsets.add(offsets.last + min(boxWidth, maxWidth));
    }

    List<num> minimum = [0, ...List<num>.filled(count, 9007199254740991)];
    List<int> breaks = List<int>.filled(count + 1, 0);

    num cost(int i, int j) {
      num width = offsets[j] - offsets[i] + spacing * (j - i - 1);
      if (width > maxWidth)
        return 9007199254740991;
      else
        return minimum[i] + pow(maxWidth - width, 2);
    }

    void search(int i0, int j0, int i1, int j1) {
      Queue<List<int>> stack = Queue()..add([i0, j0, i1, j1]);

      while (stack.isNotEmpty) {
        List<int> info = stack.removeLast();
        i0 = info[0];
        j0 = info[1];
        i1 = info[2];
        j1 = info[3];

        if (j0 < j1) {
          int j = (j0 + j1) ~/ 2;

          for (int i = i0; i < i1; i++) {
            num c = cost(i, j);
            if (c <= minimum[j]) {
              minimum[j] = c;
              breaks[j] = i;
            }
          }

          stack.add([breaks[j], j + 1, i1, j1]);
          stack.add([i0, j0, breaks[j] + 1, j]);
        }
      }
    }

    int n = count + 1;
    int i = 0;
    int offset = 0;

    while (true) {
      int r = min(n, pow(2, i + 1) as int);
      int edge = pow(2, i) + offset as int;
      search(0 + offset, edge, edge, r + offset);
      num x = minimum[r - 1 + offset];

      bool flag = true;
      for (int j = pow(2, i) as int; j < r - 1; j++) {
        num y = cost(j + offset, r - 1 + offset);
        if (y <= x) {
          n -= j;
          i = 0;
          offset += j;
          flag = false;
          break;
        }
      }

      if (flag) {
        if (r == n) break;
        i = i + 1;
      }
    }

    int j = count;

    List<List<int>> indexes = [];

    while (j > 0) {
      int i = breaks[j];
      indexes.add(List<int>.generate(j - i, (index) => index + i));
      j = i;
    }

    return indexes.reversed.toList();
  }

  /// Given some [text], breaks it into the smallest possible number of lines
  /// such as each line has width not larger than [maxWidthInChars] chars.
  /// It also minimizes the difference between width of each line,
  /// achieving a "balanced" result.
  ///
  static List<String> divideWords(String text, int maxWidthInChars) {
    List<String> words = text.split(" ");
    List<int> boxes = words.map((word) => word.length).toList();

    List<List<num>> divided = divide(boxes, maxWidthInChars, spacing: 1.0);

    List<String> result = [];

    for (List<num> partList in divided) {
      String text = partList.map((part) => words[part as int]).join(" ");
      result.add(text);
    }

    return result;
  }
}
