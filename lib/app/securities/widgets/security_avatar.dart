import 'package:flutter/material.dart';
import 'package:monekin/core/database/app_db.dart';

/// A circular badge for a security: the ticker (or, when missing, the first
/// letters of the name) inside a solid dark circle.
class SecurityAvatar extends StatelessWidget {
  const SecurityAvatar({super.key, required this.security, this.size = 40});

  final SecurityInDB security;
  final double size;

  String get _label {
    final ticker = security.ticker?.trim();
    if (ticker != null && ticker.isNotEmpty) {
      return ticker.toUpperCase();
    }

    final name = security.name.trim();
    if (name.isEmpty) return '?';

    return name.substring(0, name.length < 4 ? name.length : 4).toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: Colors.black,
        shape: BoxShape.circle,
      ),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: size * 0.16),
          child: Text(
            _label,
            maxLines: 1,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: size * 0.34,
              letterSpacing: 0.5,
            ),
          ),
        ),
      ),
    );
  }
}
