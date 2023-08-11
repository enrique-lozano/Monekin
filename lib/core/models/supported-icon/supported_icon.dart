import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:json_annotation/json_annotation.dart';

part 'supported_icon.g.dart';

@JsonSerializable()
class SupportedIcon {
  final String id;

  final String scope;

  String get urlToAssets =>
      'assets/icons/supported_selectable_icons/$scope/$id.svg';

  SupportedIcon({required this.id, required this.scope});

  factory SupportedIcon.fromJson(Map<String, dynamic> json) =>
      _$SupportedIconFromJson(json);

  Map<String, dynamic> toJson() => _$SupportedIconToJson(this);

  bool get isBrandLogo =>
      scope.split('/').isNotEmpty && scope.split('/').first == 'logos';

  /// Display the icon in any widget
  Widget display({double size = 22, Color? color}) {
    return SizedBox(
      height: size,
      width: size,
      child: SvgPicture.asset(
        urlToAssets,
        height: size,
        width: size,
        colorFilter:
            color != null ? ColorFilter.mode(color, BlendMode.srcIn) : null,
      ),
    );
  }

  /// Display the icon surrounded by a filled container in any widget
  Widget displayFilled({required Color color, double size = 22}) {
    return Container(
        padding: EdgeInsets.all(size / (22 / 6)),
        decoration: BoxDecoration(
            color: color.withOpacity(0.12),
            borderRadius: BorderRadius.circular(size / (22 / 6))),
        child: display(size: size, color: color));
  }
}
