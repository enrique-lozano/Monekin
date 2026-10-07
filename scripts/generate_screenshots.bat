@echo off
setlocal

:: ─── Config ───────────────────────────────────────────────────────────────────
set REPO_ROOT=%~dp0..
cd /d "%REPO_ROOT%"

:: ─── Locales to generate ──────────────────────────────────────────────────────
:: Regenerates the Google Play store screenshots using the integration test in
:: integration_test\tests\screenshots\screenshots_test.dart.
::
:: Requirements:
::   - A running Android emulator (or connected device). Use a device/skin
::     close to what the store listing expects (e.g. a Pixel 6 emulator).
::
:: Usage:
::   scripts\generate_screenshots.bat             (every locale in lib\i18n\json\)
::   scripts\generate_screenshots.bat en es       (only these locales)

if "%~1"=="" (
    for %%F in (lib\i18n\json\*.json) do call :run_locale %%~nF
) else (
    for %%L in (%*) do call :run_locale %%L
)

:: ─── Done ─────────────────────────────────────────────────────────────────────
echo.
echo Done. Review the updated images under app-marketplaces\screenshots\ before committing.

endlocal
goto :eof

:run_locale
echo.
echo [Screenshots] Generating for locale: %~1
call flutter drive ^
    --driver=test_driver/integration_test.dart ^
    --target=integration_test/tests/screenshots/screenshots_test.dart ^
    --dart-define=SCREENSHOT_LOCALE=%~1
if errorlevel 1 ( echo Failed generating screenshots for locale %~1 & exit /b 1 )
goto :eof
