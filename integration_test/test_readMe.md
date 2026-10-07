# MONEKIN INTEGRATION TEST

## ENVIRONMENT SETUP:

- Flutter SDK: 3.x.x and above
- Android emulator
- Add the integration_test dependency **[by Flutter Docs](https://docs.flutter.dev/testing/integration-tests)**


## HOW TO RUN THE TESTS:

- Run all tests:
    % flutter test integration_test/

- Run a specific test file:
    % flutter test integration_test/Path_to_test_file.dart


## CURRENT FOCUS:

- Navigation test
- Store screenshot generation (see below)


## FUTURE EXPANSION:

- Account management test
- Transaction management test
- Budget management test
- Statistics test
- Other feature tests


## GENERATING STORE SCREENSHOTS:

`integration_test/tests/screenshots/screenshots_test.dart` seeds the app with
demo data and navigates through a handful of key screens (dashboard,
transactions, stats, budgets), taking a screenshot of each. It's driven by
`test_driver/integration_test.dart`, which saves every screenshot under
`app-marketplaces/screenshots/<locale>/Screenshots/`.

With an Android emulator (or device) running, from the repository root:

    > scripts\generate_screenshots.bat          :: every locale
    > scripts\generate_screenshots.bat en es    :: only these locales

This uses `flutter drive`, not `flutter test`, since taking and saving
screenshots to disk needs the driver/target split (`flutter test` alone
can't write files on the host). Always review the generated images before
committing — demo data, device frame and status bar can vary by emulator.
