import 'package:flutter/material.dart';
import 'package:monekin/core/database/app_db.dart';
import 'package:monekin/core/utils/color_utils.dart';

class Tag extends TagInDB {
  Tag({
    required super.id,
    required super.name,
    required super.color,
    super.description,
  });

  static Tag fromTagInDB(TagInDB e) {
    return Tag(
        id: e.id, name: e.color, color: e.color, description: e.description);
  }

  Color get colorData => ColorHex.get(color);

  static IconData get icon => Icons.sell_rounded;
}
