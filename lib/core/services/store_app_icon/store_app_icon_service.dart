import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:monekin/core/utils/logger.dart';
import 'package:path_provider/path_provider.dart';

/// Finds the icon of an Android app from its public Google Play listing.
///
/// The URL found is stored on disk so the listing is requested only once per
/// app. The image itself is cached by the widget that displays it.
class StoreAppIconService {
  StoreAppIconService._();
  static final StoreAppIconService instance = StoreAppIconService._();

  final _lookups = <String, Future<String?>>{};

  /// The URL of the icon of the app with this [packageName], or null if it
  /// can not be obtained (offline, unsupported platform, app not found...)
  Future<String?> getIconUrl(String packageName) async {
    final url = await (_lookups[packageName] ??= _resolve(packageName));

    // Do not remember failures, so they are retried later
    if (url == null) _lookups.remove(packageName);

    return url;
  }

  Future<String?> _resolve(String packageName) async {
    // The browser blocks the request and there is no folder to cache it
    if (kIsWeb) return null;

    try {
      final stored = await _stored;
      if (stored.containsKey(packageName)) return stored[packageName];

      final response = await http
          .get(
            Uri.https('play.google.com', '/store/apps/details', {
              'id': packageName,
              'hl': 'en',
            }),
            headers: {'User-Agent': 'Mozilla/5.0'},
          )
          .timeout(const Duration(seconds: 10));

      if (response.statusCode != 200) return null;

      final image = RegExp(r'<meta property="og:image" content="([^"]+)"')
          .firstMatch(response.body)
          ?.group(1);

      if (image == null) return null;

      // Ask for a small square icon instead of the original size
      final url = image.replaceFirst(RegExp(r'=[^=/]*$'), '=s128');

      stored[packageName] = url;
      await _writeStored(stored);

      return url;
    } catch (e) {
      Logger.printDebug('Could not get the icon of $packageName: $e');
      return null;
    }
  }

  Future<File> _storeFile() async {
    final dir = await getApplicationSupportDirectory();
    return File('${dir.path}/store_app_icons.json');
  }

  /// Loaded once, so concurrent lookups share the same map
  late final Future<Map<String, String>> _stored = _loadStored();

  Future<Map<String, String>> _loadStored() async {
    try {
      final file = await _storeFile();

      return file.existsSync()
          ? Map<String, String>.from(jsonDecode(await file.readAsString()))
          : {};
    } catch (_) {
      return {};
    }
  }

  /// Writes one after another, so an older copy never overwrites a newer one
  Future<void> _lastWrite = Future.value();

  Future<void> _writeStored(Map<String, String> value) {
    final json = jsonEncode(value);

    return _lastWrite = _lastWrite.then(
      (_) async => (await _storeFile()).writeAsString(json),
    );
  }
}
