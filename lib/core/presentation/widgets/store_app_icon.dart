import 'package:cached_network_image/cached_network_image.dart';
import 'package:material_ui/material_ui.dart';
import 'package:monekin/core/services/store_app_icon/store_app_icon_service.dart';

/// The icon of an Android app, obtained from its Google Play listing. While
/// it is loading, or if it can not be obtained, the [fallback] is displayed.
class StoreAppIcon extends StatelessWidget {
  const StoreAppIcon({
    super.key,
    required this.packageName,
    required this.fallback,
    this.size = 40,
  });

  final String packageName;
  final Widget fallback;
  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: size,
      child: FutureBuilder(
        future: StoreAppIconService.instance.getIconUrl(packageName),
        builder: (context, snapshot) {
          final url = snapshot.data;

          if (url == null) return fallback;

          return ClipRRect(
            borderRadius: BorderRadius.circular(size * 0.25),
            child: CachedNetworkImage(
              imageUrl: url,
              fit: BoxFit.cover,
              fadeInDuration: const Duration(milliseconds: 200),
              placeholder: (_, _) => fallback,
              errorWidget: (_, _, _) => fallback,
            ),
          );
        },
      ),
    );
  }
}
