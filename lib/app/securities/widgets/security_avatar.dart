import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:monekin/core/database/app_db.dart';
import 'package:monekin/core/services/market_data/market_data_service.dart';
import 'package:skeletonizer/skeletonizer.dart';

/// A circular badge for a security: the company logo (by ticker) when
/// available, otherwise the ticker or first name letters on a dark circle.
class SecurityAvatar extends StatelessWidget {
  const SecurityAvatar({
    super.key,
    required SecurityInDB this.security,
    this.size = 40,
  }) : _ticker = null,
       _name = null;

  /// Builds the avatar from raw values (e.g. an online search result).
  const SecurityAvatar.raw({
    super.key,
    String? ticker,
    required String name,
    this.size = 40,
  }) : security = null,
       _ticker = ticker,
       _name = name;

  final SecurityInDB? security;
  final String? _ticker;
  final String? _name;
  final double size;

  String get _label {
    final ticker = (_ticker ?? security?.ticker)?.trim();
    if (ticker != null && ticker.isNotEmpty) {
      return ticker.toUpperCase();
    }

    final name = (_name ?? security?.name ?? '').trim();
    if (name.isEmpty) return '?';

    return name.substring(0, name.length < 4 ? name.length : 4).toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final ticker = (_ticker ?? security?.ticker)?.trim();
    final logoUrl = MarketDataService.instance.logoUrlForTicker(ticker);

    final fallback = _buildLetterAvatar();

    if (logoUrl == null) return fallback;

    return ClipOval(
      child: SizedBox(
        width: size,
        height: size,
        child: CachedNetworkImage(
          imageUrl: logoUrl,
          fadeInDuration: const Duration(milliseconds: 200),
          imageBuilder: (context, imageProvider) => ColoredBox(
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.all(size * 0.1),
              child: Image(image: imageProvider, fit: BoxFit.contain),
            ),
          ),
          placeholder: (_, _) =>
              Skeletonizer.zone(child: Bone.circle(size: size)),
          errorWidget: (_, _, _) {
            MarketDataService.instance.markLogoUnavailable(ticker);
            return fallback;
          },
        ),
      ),
    );
  }

  Widget _buildLetterAvatar() {
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
