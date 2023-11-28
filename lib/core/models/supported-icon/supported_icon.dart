import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:monekin/core/utils/color_utils.dart';

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
  ///
  /// The [color] attribute is the only attribute required here
  ///
  /// By default, a padding and a border radius of the 27% aprox. of the icon size will be applied.
  /// The bgColor will be by default a lighter version of the icon color
  Widget displayFilled(
      {required Color color,
      double size = 22,
      double? padding,
      double? borderRadius,
      Color? bgColor}) {
    final padAndRadius = size / (22 / 6);

    return Container(
        padding: EdgeInsets.all(padding ?? padAndRadius),
        decoration: BoxDecoration(
            color: bgColor ?? color.lighten(0.82),
            borderRadius: BorderRadius.circular(borderRadius ?? padAndRadius)),
        child: display(size: size, color: color));
  }
}
