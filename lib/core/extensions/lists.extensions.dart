import 'dart:math';

extension RandomListItem<T> on List<T> {
  T randomItem() {
    return this[Random().nextInt(length)];
  }
}
