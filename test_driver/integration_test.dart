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
  await integrationDriver(
    onScreenshot: (String screenshotName, List<int> screenshotBytes, [
      Map<String, Object?>? args,
    ]) async {
      final file = File(p.join(_screenshotsBaseDir, '$screenshotName.png'));
      await file.parent.create(recursive: true);
      await file.writeAsBytes(screenshotBytes, flush: true);

      return true;
    },
  );
}
