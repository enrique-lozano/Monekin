# Integration tests

End-to-end tests that run the real app on an Android emulator or device. Requires `integration_test` (already in `pubspec.yaml`).

```
flutter test integration_test/                      # all tests
flutter test integration_test/tests/<file>.dart     # a single test
```

- `tests/navigation/` — navigation smoke tests.
- `tests/screenshots/` — store screenshot generation (see below).
- `tests/helpers.dart` — shared setup (`setupMonekin`, `startMonekin`, `takeScreenshot`...).

## Generating store screenshots

`tests/screenshots/screenshots_test.dart` seeds the app with demo data, visits a few key screens (dashboard, transactions, stats, budgets, budget details, subscriptions, exchange rate) and takes a screenshot of each. `test_driver/integration_test.dart` saves them to `app-marketplaces/screenshots/captures/<app locale>-<currency>/`.

From the repository root, with an emulator or device running:

```
scripts\generate_screenshots.bat               :: captures for every store image set
scripts\generate_screenshots.bat en-US pt-BR   :: only the captures these sets need
```

- The sets (app language and demo currency of each store listing) live in `app-marketplaces/store-images/config.json`. A single run covers all of them: the test seeds the demo data again for each currency, scaling its amounts so they look plausible (e.g. `INR` uses about 80 times the dollar amounts).

- It uses `flutter drive` (not `flutter test`), as writing files on the host needs the driver/target split.
- The script asks which device to use. A **physical Android phone** is the fastest option, as the test runs in profile mode there; emulators and Windows desktop only support debug mode. Set `DEVICE` (and optionally `PROFILE=1`) to skip the question.
- On Windows desktop the app is resized to a phone-like viewport and the frame is captured from Dart.
- Each step prints how long it took (`[Screenshots] ... ms`), to spot slow ones.
- `tests/screenshots/screenshots_config.dart` holds the typed settings (simulated platform, viewport, image names). The simulated platform decides whether the window bar and scrollbars appear.
- The run uses its own `screenshots.db`, reset on every run, so your real Monekin data is never touched.
- The captures are not committed (see `.gitignore`). Review them before exporting the store images: demo data, device frame and status bar vary by emulator.
- Then use the store images editor to turn the captures into the final store images (see `app-marketplaces/store-images/README.md`).
