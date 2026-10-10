// Driver used to run the integration tests with `flutter drive` and save
// any screenshot taken with `binding.takeScreenshot(name)` to disk.
//
// Used by `scripts/generate_screenshots.bat` to regenerate the store
// screenshots in `app-marketplaces/screenshots/captures/<locale>-<currency>/`.
//
// Note: `--dart-define` flags passed to `flutter drive` only reach the app
// build running on the device (the test target), not this driver script,
// which runs separately on the host machine. So the screenshot test encodes
// the destination folder directly in the screenshot name (e.g.
// `captures/en-USD/01_dashboard`) instead of this file reading an env var.
//
// See: https://docs.flutter.dev/cookbook/testing/integration/screenshots
import 'dart:io';

import 'package:integration_test/integration_test_driver_extended.dart';
import 'package:path/path.dart' as p;

const _screenshotsBaseDir = 'app-marketplaces/screenshots';

Future<void> main() async {
  // On Android the images only reach the driver once the whole test is done,
  // so the time from the first to the last one is the transfer time.
  final watch = Stopwatch();
  var saved = 0;

  await integrationDriver(
    onScreenshot: (String screenshotName, List<int> screenshotBytes, [
      Map<String, Object?>? args,
    ]) async {
      if (!watch.isRunning) watch.start();

      final file = File(p.join(_screenshotsBaseDir, '$screenshotName.png'));
      await file.parent.create(recursive: true);
      await file.writeAsBytes(screenshotBytes, flush: true);
      saved++;

      return true;
    },
  );

  // ignore: avoid_print
  print('[Screenshots] Saved $saved images in ${watch.elapsed.inSeconds} s');
}
