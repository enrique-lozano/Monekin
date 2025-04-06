import 'package:flutter/material.dart';

class OnboardingItem {
  final String header;
  final String description;
  final String? description2;
  final String imageAsset;
  final Widget? extraWidget;

  const OnboardingItem({
    required this.header,
    required this.description,
    required this.imageAsset,
    this.description2,
    this.extraWidget,
  });
}
