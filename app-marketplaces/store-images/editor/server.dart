// Local server for the store images editor (see ../README.md).
//
// Serves the repository, as browsers block `fetch` and image exports on
// `file://` pages, saves the images exported from the editor to
// `app-marketplaces/screenshots/<lang>/StoreImages/` and opens that folder in
// the file explorer when the editor asks for it.
//
// Run from the repository root: dart app-marketplaces/store-images/editor/server.dart
import 'dart:io';

const _port = 8080;
const _editorPath = '/app-marketplaces/store-images/editor/';
final _exportPath = RegExp(r'^/export/([\w-]+)/([\w-]+\.png)$');
final _openPath = RegExp(r'^/open/([\w-]+)$');

const _mimeTypes = {
  'html': 'text/html',
  'css': 'text/css',
  'js': 'text/javascript',
  'json': 'application/json',
  'png': 'image/png',
  'ttf': 'font/ttf',
  'svg': 'image/svg+xml',
};

Future<void> main() async {
  final root = Directory.current;
  if (!File('${root.path}/pubspec.yaml').existsSync()) {
    stderr.writeln('Run this from the repository root.');
    exit(1);
  }

  final server = await HttpServer.bind(InternetAddress.loopbackIPv4, _port);
  stdout
    ..writeln()
    ..writeln('  Store images editor running at:')
    ..writeln('  http://localhost:$_port$_editorPath')
    ..writeln()
    ..writeln('  Exported images are listed below. Press Ctrl+C to stop.')
    ..writeln();

  await for (final request in server) {
    final path = Uri.decodeComponent(request.uri.path);
    final export = _exportPath.firstMatch(path);
    final open = _openPath.firstMatch(path);

    if (request.method == 'POST' && export != null) {
      final file = File('${_imagesDir(root, export[1]!).path}/${export[2]}');
      await file.parent.create(recursive: true);
      await request.cast<List<int>>().pipe(file.openWrite());
      // A file URI is Ctrl+clickable in most terminals, even with spaces in the path.
      stdout.writeln('  ✓ ${export[1]}/${export[2]}  ${file.uri}');
      request.response.statusCode = HttpStatus.noContent;
    } else if (request.method == 'POST' && open != null) {
      await _openInFileExplorer(_imagesDir(root, open[1]!));
      request.response.statusCode = HttpStatus.noContent;
    } else if (path.contains('..')) {
      request.response.statusCode = HttpStatus.forbidden;
    } else {
      final file = File(
        '${root.path}${path.endsWith('/') ? '${path}index.html' : path}',
      );
      if (file.existsSync()) {
        request.response.headers
          ..contentType = ContentType.parse(
            _mimeTypes[file.path.split('.').last] ?? 'application/octet-stream',
          )
          ..set(HttpHeaders.cacheControlHeader, 'no-store');
        await request.response.addStream(file.openRead());
      } else {
        request.response.statusCode = HttpStatus.notFound;
      }
    }

    await request.response.close();
  }
}

Directory _imagesDir(Directory root, String lang) =>
    Directory('${root.path}/app-marketplaces/screenshots/$lang/StoreImages');

Future<void> _openInFileExplorer(Directory dir) async {
  final command = Platform.isWindows
      ? 'explorer'
      : Platform.isMacOS
      ? 'open'
      : 'xdg-open';
  // `explorer` needs backslashes and returns exit code 1 even on success.
  await Process.run(command, [
    Platform.isWindows ? dir.path.replaceAll('/', '\\') : dir.path,
  ]);
}
