@echo off
setlocal

:: ─── Config ───────────────────────────────────────────────────────────────────
set APP_NAME=Monekin
set REPO_ROOT=%~dp0..
set RELEASES=%REPO_ROOT%\..\.releases\%APP_NAME%

:: ─── Output folder ────────────────────────────────────────────────────────────
if not exist "%RELEASES%" mkdir "%RELEASES%"
cd /d "%REPO_ROOT%"

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
echo All builds complete! Opening releases folder...
explorer "%RELEASES%"