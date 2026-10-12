@echo off
setlocal

:: ─── Config ───────────────────────────────────────────────────────────────────
set APP_NAME=Monekin
set REPO_ROOT=%~dp0..
set RELEASES=%REPO_ROOT%\..\.releases\%APP_NAME%

:: ─── Version (from pubspec.yaml, without the build number) ───────────────────
cd /d "%REPO_ROOT%"
for /f "tokens=2" %%v in ('findstr /b "version:" pubspec.yaml') do set FULL_VERSION=%%v
for /f "delims=+" %%v in ("%FULL_VERSION%") do set VERSION=%%v
set TAG=v%VERSION%
echo Building %APP_NAME% %VERSION%

:: ─── Output folder ────────────────────────────────────────────────────────────
if not exist "%RELEASES%" mkdir "%RELEASES%"
dir /b "%RELEASES%" 2>nul | findstr "^" >nul
if not errorlevel 1 (
    echo.
    echo WARNING: "%RELEASES%" already has content that will be DELETED:
    dir /b "%RELEASES%"
    echo.
    choice /c YN /n /m "Continue and delete it? [Y/N] "
    if errorlevel 2 ( echo Aborted. & exit /b 1 )
    rmdir /s /q "%RELEASES%"
    mkdir "%RELEASES%"
)

:: ─── 1. Android APK ───────────────────────────────────────────────────────────
echo [1/3] Building Android APK...
call flutter build apk --release
if errorlevel 1 ( echo APK build failed & pause & exit /b 1 )
xcopy /y "build\app\outputs\flutter-apk\app-release.apk" "%RELEASES%\"
ren "%RELEASES%\app-release.apk" "%APP_NAME%.apk"

:: ─── 2. Android AAB ───────────────────────────────────────────────────────────
echo [2/3] Building Android AAB...
call flutter build appbundle --release
if errorlevel 1 ( echo AAB build failed & pause & exit /b 1 )
xcopy /y "build\app\outputs\bundle\release\app-release.aab" "%RELEASES%\"
ren "%RELEASES%\app-release.aab" "%APP_NAME%.aab"

:: ─── 3. Windows + Inno Setup installer ───────────────────────────────────────
echo [3/3] Building Windows app and packaging installer...
call flutter build windows --release
if errorlevel 1 ( echo Windows build failed & pause & exit /b 1 )

set INNO="C:\Program Files (x86)\Inno Setup 6\ISCC.exe"
if not exist %INNO% set INNO="C:\Program Files\Inno Setup 6\ISCC.exe"
if not exist %INNO% ( echo Inno Setup not found & pause & exit /b 1 )

%INNO% "%REPO_ROOT%\windows\exe-builder.iss"
if errorlevel 1 ( echo Inno Setup packaging failed & pause & exit /b 1 )

:: ─── Done ─────────────────────────────────────────────────────────────────────
echo.
echo All builds complete!

:: ─── Upload to the draft GitHub release ──────────────────────────────────────
where gh >nul 2>nul
if errorlevel 1 ( echo GitHub CLI ^(gh^) not found, skipping upload. & goto :open )

gh release list --json tagName,isDraft --jq ".[] | select(.isDraft and .tagName==\"%TAG%\") | .tagName" | findstr "%TAG%" >nul
if errorlevel 1 ( echo No draft release found for %TAG%, skipping upload. & goto :open )

choice /c YN /n /m "Upload %APP_NAME%.apk and %APP_NAME%.exe to draft release %TAG%? [Y/N] "
if errorlevel 2 goto :open
call gh release upload %TAG% "%RELEASES%\%APP_NAME%.apk" "%RELEASES%\%APP_NAME%.exe" --clobber
if errorlevel 1 ( echo Upload failed & pause & exit /b 1 )

:open
echo Opening releases folder...
explorer "%RELEASES%"