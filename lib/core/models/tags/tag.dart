import 'package:flutter/material.dart';
import 'package:monekin/core/database/app_db.dart';
import 'package:monekin/core/extensions/color.extensions.dart';

class Tag extends TagInDB {
  Tag({
    required super.id,
    required super.name,
    required super.color,
    super.displayOrder = 10,
    super.description,
  });

  /// Display an icon in the current tag color by default
  Icon displayIcon({double? size, Color? color}) {
    return Icon(Tag.icon, size: size, color: color ?? colorData);
  }

  static Tag fromTagInDB(TagInDB e) {
    return Tag(
      id: e.id,
      name: e.name,
      color: e.color,
      description: e.description,
    );
  }

  Color get colorData => ColorHex.get(color);

  /// The icon that represent the tag entity
  static IconData get icon => Icons.label_rounded;
}
