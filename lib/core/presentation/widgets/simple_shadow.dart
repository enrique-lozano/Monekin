import 'dart:ui';

import 'package:flutter/material.dart';

// Credits to https://github.com/marcelopmont/simple_shadow/tree/main for this amazing component

class SimpleShadow extends StatelessWidget {
  final Widget child;
  final double opacity;
  final double sigma;
  final Color color;
  final Offset offset;

  const SimpleShadow({
    required this.child,
    this.opacity = 0.5,
    this.sigma = 2,
    this.color = Colors.black,
    this.offset = const Offset(2, 2),
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        if (color.alpha != 0)
          Transform.translate(
            offset: offset,
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(
                  sigmaY: sigma, sigmaX: sigma, tileMode: TileMode.decal),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.transparent,
                    width: 0,
                  ),
                ),
                child: ColorFiltered(
                  colorFilter: ColorFilter.mode(
                    color.withOpacity(opacity),
                    BlendMode.srcATop,
                  ),
                  child: child,
                ),
              ),
            ),
          ),
        child,
      ],
    );
  }
}
