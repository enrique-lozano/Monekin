import 'package:monekin/core/models/supported-icon/supported_icon.dart';
import 'package:monekin/core/services/supported_icon/getter/supported_icons.dart';
import 'package:collection/collection.dart';

class SupportedIconService {
  SupportedIconService._();
  static final SupportedIconService instance = SupportedIconService._();

  List<SupportedIcon>? _icons;

  /// Get a list of all the supported icons in the app. This list does not take into account app functionality icons, just the icons that are selectable to identificate some accounts, categories...
  List<SupportedIcon> getAllIcons() {
    if (_icons != null) return _icons!;

    _icons = supportedIcons.map((e) => SupportedIcon.fromJson(e)).toList();

    return _icons!;
  }

  List<SupportedIcon> getIconsOfScope(String scope) {
    return getAllIcons().where((element) => element.scope == scope).toList();
  }

  Map<String, List<SupportedIcon>> getIconsByScope() {
    Map<String, List<SupportedIcon>> map = {};

    getAllIcons().forEach((element) {
      if (map.containsKey(element.scope)) {
        map[element.scope]!.add(element);
      } else {
        map[element.scope] = [element];
      }
    });

    return map;
  }

  SupportedIcon get defaultSupportedIcon => getAllIcons().firstWhereOrNull(
    (element) => element.id == 'question_mark',
  )!;

  /// Get an icon by its ID. Return a default icon if the icon is not found by the specified ID or a null ID is passed.
  SupportedIcon getIconByID(String? id) {
    if (id == null) {
      return defaultSupportedIcon;
    }

    return getAllIcons().firstWhereOrNull((element) => element.id == id) ??
        defaultSupportedIcon;
  }
}
