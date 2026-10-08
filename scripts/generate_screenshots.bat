@echo off
setlocal enabledelayedexpansion

:: Regenerates the store screenshots using the integration test in
:: integration_test\tests\screenshots\screenshots_test.dart.
::
:: Requirements:
::   - A running Android emulator (or connected device). Use a device/skin
::     close to what the store listing expects (e.g. a Pixel 6 emulator).
::
:: Usage:
::   scripts\generate_screenshots.bat             (asks which locales to generate)
::   scripts\generate_screenshots.bat en es       (only these locales, no prompt)
::   scripts\generate_screenshots.bat all         (every locale, no prompt)
::
:: Other settings (simulated platform, viewport...) live in
:: integration_test\tests\screenshots\screenshots_config.dart.
:: Set the DEVICE env var to pick a device id (see `flutter devices`).

cd /d "%~dp0.."

:: ─── Pick locales ─────────────────────────────────────────────────────────────
set "LOCALES="
set "HAS_ARGS="
for %%A in (%*) do (
    set "HAS_ARGS=1"
    if defined LOCALES (
        set "LOCALES=!LOCALES! %%A"
    ) else (
        set "LOCALES=%%A"
    )
)

if not defined HAS_ARGS (
    set "LOCALES="
    echo Available locales:
    for %%F in (lib\i18n\json\*.json) do echo   - %%~nF
    echo.
    set /p "LOCALES=Locales to generate, separated by spaces (Enter = all): "
)
if "!LOCALES!"=="" set "LOCALES=all"

if /i "!LOCALES!"=="all" (
    set "LOCALES="
    for %%F in (lib\i18n\json\*.json) do set "LOCALES=!LOCALES! %%~nF"
)

set "LOCALES_CSV="
for %%L in (!LOCALES!) do (
    if not exist "lib\i18n\json\%%L.json" (
        echo Unknown locale: %%L
        exit /b 1
    )
    if defined LOCALES_CSV (set "LOCALES_CSV=!LOCALES_CSV!,%%L") else set "LOCALES_CSV=%%L"
)

:: ─── Generate ─────────────────────────────────────────────────────────────────
set "DEVICE_ARG="
if defined DEVICE set "DEVICE_ARG=-d %DEVICE%"

echo.
echo [Screenshots] Generating for locales: !LOCALES_CSV!

rem One single run (one pub get / device selection / app launch) covers every
rem locale: the test switches the language between captures.
rem A dedicated DB name keeps the run away from the real app database.
call flutter drive !DEVICE_ARG! ^
    --driver=test_driver/integration_test.dart ^
    --target=integration_test/tests/screenshots/screenshots_test.dart ^
    --dart-define=SCREENSHOT_LOCALES=!LOCALES_CSV! ^
    --dart-define=MONEKIN_DB_NAME=screenshots.db
if errorlevel 1 (
    echo Failed generating screenshots
    exit /b 1
)

echo.
echo Done. Review the updated images under app-marketplaces\screenshots\ before committing.

endlocal
