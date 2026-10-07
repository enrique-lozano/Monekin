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

`tests/screenshots/screenshots_test.dart` seeds the app with demo data, visits a few key screens (dashboard, transactions, stats, budgets) and takes a screenshot of each. `test_driver/integration_test.dart` saves them to `app-marketplaces/screenshots/<locale>/Screenshots/`.

From the repository root, with an emulator or device running:

```
scripts\generate_screenshots.bat          :: asks which locales to generate
scripts\generate_screenshots.bat en es    :: only these locales
scripts\generate_screenshots.bat all      :: every locale
```

- It uses `flutter drive` (not `flutter test`), as writing files on the host needs the driver/target split.
- On Windows desktop run `set DEVICE=windows` first: the app is resized to a phone-like viewport and the frame is captured from Dart.
- The run uses its own `screenshots.db`, reset on every run, so your real Monekin data is never touched.
- Review the generated images before committing: demo data, device frame and status bar vary by emulator.
