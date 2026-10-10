@echo off
setlocal enabledelayedexpansion

:: Regenerates the store screenshots using the integration test in
:: integration_test\tests\screenshots\screenshots_test.dart.
::
:: Requirements:
::   - A running Android emulator, a connected Android phone or Windows desktop.
::     A physical phone is much faster: the test runs in profile mode there
::     (emulators and desktop only support debug).
::
:: Usage:
::   scripts\generate_screenshots.bat               (captures for every store image set)
::   scripts\generate_screenshots.bat en-US pt-BR   (only the captures these sets need)
::
:: The sets (caption language, app language and demo currency of each store
:: listing) live in app-marketplaces\store-images\config.json. Sets sharing app
:: language and currency share captures, saved to
:: app-marketplaces\screenshots\captures\<app language>-<currency>\.
::
:: Other settings (simulated platform, viewport...) live in
:: integration_test\tests\screenshots\screenshots_config.dart.
:: The script asks which device to use when there are several. Set the DEVICE
:: env var to a device id (see `flutter devices`) to skip the question; it then
:: runs in debug mode, unless PROFILE=1 is set too.
:: Set the STYLES env var to only capture some styles (comma-separated ids from
:: that file, e.g. `set STYLES=dark,dark_purple`). Default: all.

cd /d "%~dp0.."

:: ─── Captures needed by the chosen sets ───────────────────────────────────────
set "CAPTURES="
for /f "delims=" %%C in ('dart app-marketplaces\store-images\editor\captures_for_sets.dart %*') do set "CAPTURES=%%C"
if not defined CAPTURES (
    echo Failed reading the sets from app-marketplaces\store-images\config.json
    exit /b 1
)

:: ─── Device (and build mode) ─────────────────────────────────────────────────
set "DEVICE_ARG="
if defined DEVICE (
    set "DEVICE_ARG=-d %DEVICE%"
    if "%PROFILE%"=="1" set "DEVICE_ARG=-d %DEVICE% --profile"
) else (
    for /f "delims=" %%D in ('dart app-marketplaces\store-images\editor\pick_device.dart') do set "DEVICE_ARG=%%D"
    if not defined DEVICE_ARG exit /b 1
)

:: ─── Generate ─────────────────────────────────────────────────────────────────
set "STYLES_VALUE=all"
if defined STYLES set "STYLES_VALUE=%STYLES%"

echo.
echo [Screenshots] Generating captures: !CAPTURES! (styles: !STYLES_VALUE!, flags: !DEVICE_ARG!)

rem One single run (one pub get / device selection / app launch) covers every
rem capture: the test reseeds the demo data for each currency and switches the
rem language between captures.
rem A dedicated DB name keeps the run away from the real app database.
call flutter drive !DEVICE_ARG! ^
    --driver=test_driver/integration_test.dart ^
    --target=integration_test/tests/screenshots/screenshots_test.dart ^
    --dart-define=SCREENSHOT_CAPTURES=!CAPTURES! ^
    --dart-define=SCREENSHOT_STYLES=!STYLES_VALUE! ^
    --dart-define=MONEKIN_DB_NAME=screenshots.db
if errorlevel 1 (
    echo Failed generating screenshots
    exit /b 1
)

echo.
echo Done. Open the store images editor to review and export them:
echo   dart app-marketplaces/store-images/editor/server.dart

endlocal
