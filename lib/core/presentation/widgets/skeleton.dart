import 'package:flutter/material.dart';

class Skeleton extends StatelessWidget {
  const Skeleton(
      {super.key,
      required this.width,
      required this.height,
      this.applyMarging = true});

  final double width, height;
  final bool applyMarging;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: height,
          width: width,
          margin: applyMarging
              ? const EdgeInsets.symmetric(vertical: 2, horizontal: 0)
              : null,
          decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.04),
              borderRadius: BorderRadius.circular(4)),
        ),
      ],
    );
  }
}
