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
:: Set the DEVICE env var to pick a device id (see `flutter devices`).

cd /d "%~dp0.."

:: ─── Pick locales ─────────────────────────────────────────────────────────────
set "LOCALES=%*"

if "%LOCALES%"=="" (
    echo Available locales:
    for %%F in (lib\i18n\json\*.json) do echo   - %%~nF
    echo.
    set /p "LOCALES=Locales to generate, separated by spaces (Enter = all): "
    if "!LOCALES!"=="" set "LOCALES=all"
)

if /i "!LOCALES!"=="all" (
    set "LOCALES="
    for %%F in (lib\i18n\json\*.json) do set "LOCALES=!LOCALES! %%~nF"
)

for %%L in (!LOCALES!) do (
    if not exist "lib\i18n\json\%%L.json" (
        echo Unknown locale: %%L
        exit /b 1
    )
)

:: ─── Generate ─────────────────────────────────────────────────────────────────
set "DEVICE_ARG="
if defined DEVICE set "DEVICE_ARG=-d %DEVICE%"

for %%L in (!LOCALES!) do (
    echo.
    echo [Screenshots] Generating for locale: %%L
    rem A dedicated DB name keeps the run away from the real app database.
    call flutter drive !DEVICE_ARG! ^
        --driver=test_driver/integration_test.dart ^
        --target=integration_test/tests/screenshots/screenshots_test.dart ^
        --dart-define=SCREENSHOT_LOCALE=%%L ^
        --dart-define=MONEKIN_DB_NAME=screenshots.db
    if errorlevel 1 (
        echo Failed generating screenshots for locale %%L
        exit /b 1
    )
)

echo.
echo Done. Review the updated images under app-marketplaces\screenshots\ before committing.

endlocal
