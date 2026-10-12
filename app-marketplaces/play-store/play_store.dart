// Syncs the Google Play store listings (texts and phone screenshots) with the
// files in this repository (see README.md).
//
// Run from the repository root:
//   dart run app-marketplaces/play-store/play_store.dart pull
//   dart run app-marketplaces/play-store/play_store.dart push [--dry-run] [--no-texts] [--no-images] [listings...]
import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:googleapis/androidpublisher/v3.dart';
import 'package:googleapis_auth/auth_io.dart';

const _packageName = 'com.monekin.app';
const _root = 'app-marketplaces/play-store';
const _listingsDir = '$_root/listings';
const _storeImagesDir = 'app-marketplaces/screenshots/store';
const _setsConfig = 'app-marketplaces/screenshots/generator/config.json';
const _defaultKey = '$_root/service-account.json';

/// Text files of each listing, with the Play Store max length of each one.
const _texts = {
  'title.txt': 30,
  'short_description.txt': 80,
  'full_description.txt': 4000,
};

Future<void> main(List<String> args) async {
  final command = args.firstOrNull;
  final flags = args.where((a) => a.startsWith('--')).toSet();
  final listings = args.skip(1).where((a) => !a.startsWith('--')).toSet();

  if (command != 'pull' && command != 'push') {
    stderr.writeln(
      'Usage: dart run $_root/play_store.dart <pull|push> '
      '[--dry-run] [--no-texts] [--no-images] [listings...]',
    );
    exit(64);
  }

  final keyPath = Platform.environment['PLAY_STORE_KEY'] ?? _defaultKey;
  final keyFile = File(keyPath);
  if (!keyFile.existsSync()) {
    stderr.writeln(
      'Service account key not found at $keyPath. Save it there or set the '
      'PLAY_STORE_KEY env var to its path.',
    );
    exit(1);
  }

  final client = await clientViaServiceAccount(
    ServiceAccountCredentials.fromJson(keyFile.readAsStringSync()),
    [AndroidPublisherApi.androidpublisherScope],
  );
  final edits = AndroidPublisherApi(client).edits;
  final edit = await edits.insert(AppEdit(), _packageName);
  final editId = edit.id!;

  try {
    if (command == 'pull') {
      await _pull(edits, editId, listings);
      await edits.delete(_packageName, editId);
    } else {
      await _push(
        edits,
        editId,
        listings,
        dryRun: flags.contains('--dry-run'),
        texts: !flags.contains('--no-texts'),
        images: !flags.contains('--no-images'),
      );
    }
  } catch (e) {
    await edits.delete(_packageName, editId).catchError((_) {});
    rethrow;
  } finally {
    client.close();
  }
}

/// Saves the texts of the current Play Store listings to [_listingsDir].
Future<void> _pull(EditsResource edits, String editId, Set<String> only) async {
  final remote = (await edits.listings.list(_packageName, editId)).listings!;

  for (final listing in remote) {
    final language = listing.language!;
    if (only.isNotEmpty && !only.contains(language)) continue;

    final dir = Directory('$_listingsDir/$language')
      ..createSync(recursive: true);
    final values = [
      listing.title,
      listing.shortDescription,
      listing.fullDescription,
    ];
    for (final (i, name) in _texts.keys.indexed) {
      File('${dir.path}/$name').writeAsStringSync('${values[i] ?? ''}\n');
    }
    stdout.writeln('Pulled $language');
  }
}

/// Uploads the local texts and store images to a new edit and commits it
/// without sending it for review, so it can be checked in the Play Console
/// first.
Future<void> _push(
  EditsResource edits,
  String editId,
  Set<String> only, {
  required bool dryRun,
  required bool texts,
  required bool images,
}) async {
  final remote = {
    for (final l in (await edits.listings.list(_packageName, editId)).listings!)
      l.language!: l,
  };
  final local = Directory(_listingsDir).existsSync()
      ? Directory(_listingsDir)
            .listSync()
            .whereType<Directory>()
            .map((d) => d.uri.pathSegments.lastWhere((s) => s.isNotEmpty))
            .toSet()
      : <String>{};

  final languages = {...remote.keys, ...local}.toList()..sort();
  final setIds = _setIds();
  var changes = 0;

  for (final language in languages) {
    if (only.isNotEmpty && !only.contains(language)) continue;

    if (texts && local.contains(language)) {
      final listing = _readListing(language);
      final current = remote[language];
      if (current == null ||
          current.title != listing.title ||
          current.shortDescription != listing.shortDescription ||
          current.fullDescription != listing.fullDescription) {
        stdout.writeln(
          '$language: ${current == null ? 'new listing' : 'update texts'}',
        );
        changes++;
        if (!dryRun) {
          await edits.listings.update(listing, _packageName, editId, language);
        }
      }
    }

    // New listings must have their texts uploaded before any image.
    final isNew = !remote.containsKey(language);
    if (images && (!isNew || (texts && local.contains(language)))) {
      final setId = _setFor(language, setIds);
      if (setId == null) continue;
      final pushed = await _pushImages(
        edits,
        editId,
        language,
        setId,
        isNew: isNew,
        dryRun: dryRun,
      );
      if (pushed) changes++;
    }
  }

  if (changes == 0) {
    stdout.writeln('Everything is up to date.');
    await edits.delete(_packageName, editId);
    return;
  }

  if (dryRun) {
    stdout.writeln('\nDry run: $changes change(s), nothing uploaded.');
    await edits.delete(_packageName, editId);
    return;
  }

  await edits.validate(_packageName, editId);
  await edits.commit(_packageName, editId);
  stdout.writeln(
    '\nUploaded $changes change(s). They are sent for review automatically.',
  );
}

/// Replaces the phone screenshots of [language] with the images of the store
/// image set [setId], unless they are already the same. Returns whether they
/// changed.
Future<bool> _pushImages(
  EditsResource edits,
  String editId,
  String language,
  String setId, {
  required bool isNew,
  required bool dryRun,
}) async {
  const type = 'phoneScreenshots';
  final dir = Directory('$_storeImagesDir/$setId');
  final files = dir.existsSync()
      ? (dir
            .listSync()
            .whereType<File>()
            .where((f) => f.path.endsWith('.png'))
            .toList()
          ..sort((a, b) => a.path.compareTo(b.path)))
      : <File>[];
  if (files.isEmpty) {
    stdout.writeln('$language: no images in ${dir.path}, skipped');
    return false;
  }

  final hashes = [
    for (final f in files) sha256.convert(f.readAsBytesSync()).toString(),
  ];
  if (!isNew) {
    final current = (await edits.images.list(
      _packageName,
      editId,
      language,
      type,
    )).images;
    if ((current ?? []).map((i) => i.sha256).join() == hashes.join()) {
      return false;
    }
  }

  stdout.writeln('$language: upload ${files.length} screenshots from $setId');
  if (dryRun) return true;

  await edits.images.deleteall(_packageName, editId, language, type);
  for (final file in files) {
    await edits.images.upload(
      _packageName,
      editId,
      language,
      type,
      uploadMedia: Media(
        file.openRead(),
        file.lengthSync(),
        contentType: 'image/png',
      ),
    );
  }
  return true;
}

Listing _readListing(String language) {
  final values = <String>[];
  for (final MapEntry(key: name, value: maxLength) in _texts.entries) {
    final file = File('$_listingsDir/$language/$name');
    if (!file.existsSync()) {
      stderr.writeln('Missing ${file.path}');
      exit(1);
    }
    final text = file.readAsStringSync().trim();
    if (text.isEmpty || text.length > maxLength) {
      stderr.writeln(
        '${file.path} must have 1-$maxLength characters (has ${text.length})',
      );
      exit(1);
    }
    values.add(text);
  }
  return Listing(
    language: language,
    title: values[0],
    shortDescription: values[1],
    fullDescription: values[2],
  );
}

List<String> _setIds() {
  final config =
      jsonDecode(File(_setsConfig).readAsStringSync()) as Map<String, dynamic>;
  return [for (final s in config['sets'] as List) s['id'] as String];
}

/// Store image set used by a listing: the one with its same id or, otherwise,
/// the first one of its language (e.g. `de-DE` for `de-AT`). Listings without
/// any keep their current images (Play shows the default listing ones).
String? _setFor(String language, List<String> setIds) {
  if (setIds.contains(language)) return language;
  final prefix = language.split('-').first;
  return setIds.where((id) => id.split('-').first == prefix).firstOrNull;
}
