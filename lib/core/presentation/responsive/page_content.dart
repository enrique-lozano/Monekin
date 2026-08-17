import 'package:flutter/material.dart';
import 'package:monekin/core/utils/app_utils.dart';

/// Full-width page content with consistent responsive gutters.
class PageContent extends StatelessWidget {
  const PageContent({
    super.key,
    required this.child,
    this.desktopPadding = const EdgeInsets.symmetric(horizontal: 16),
    this.mobilePadding = EdgeInsets.zero,
  });

  final Widget child;
  final EdgeInsetsGeometry desktopPadding;
  final EdgeInsetsGeometry mobilePadding;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: AppUtils.isMobileLayout(context)
            ? mobilePadding
            : desktopPadding,
        child: child,
      ),
    );
  }
}
