// Local server for the store images editor (see README.md next to this file).
//
// Serves the repository, as browsers block `fetch` and image exports on
// `file://` pages, and saves the images exported from the editor to
// `app-marketplaces/screenshots/<lang>/StoreImages/`.
//
// Run from the repository root: dart app-marketplaces/screenshots/store-images/server.dart
import 'dart:io';

const _port = 8080;
const _editorPath = '/app-marketplaces/screenshots/store-images/';
final _exportPath = RegExp(r'^/export/([\w-]+)/([\w-]+\.png)$');

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
  stdout.writeln('Store images editor: http://localhost:$_port$_editorPath');

  await for (final request in server) {
    final path = Uri.decodeComponent(request.uri.path);
    final export = _exportPath.firstMatch(path);

    if (request.method == 'POST' && export != null) {
      final file = File(
        '${root.path}/app-marketplaces/screenshots/${export[1]}/StoreImages/${export[2]}',
      );
      await file.parent.create(recursive: true);
      await request.cast<List<int>>().pipe(file.openWrite());
      stdout.writeln('Saved ${file.path}');
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
