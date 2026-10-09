@echo off
setlocal enabledelayedexpansion

:: Renders the final store images from the HTML templates in
:: app-marketplaces\screenshots\store-images\, using the captures of
:: scripts\generate_screenshots.bat. Output: app-marketplaces\screenshots\<locale>\StoreImages\NN.png
::
:: Usage:
::   scripts\render_store_images.bat            (every locale with a copy\<locale>.js file)
::   scripts\render_store_images.bat en es      (only these locales)
::
:: Set the BROWSER env var to use another Chromium browser (default: Microsoft Edge).

cd /d "%~dp0..\app-marketplaces\screenshots\store-images"

if not defined BROWSER set "BROWSER=%ProgramFiles(x86)%\Microsoft\Edge\Application\msedge.exe"
if not exist "%BROWSER%" (
    echo Browser not found: !BROWSER!
    exit /b 1
)

set "LOCALES=%*"
if "!LOCALES!"=="" (
    for %%F in (copy\*.js) do set "LOCALES=!LOCALES! %%~nF"
)

for /f %%N in ('findstr /r /c:"^  // [0-9]" slides.js ^| find /c /v ""') do set "SLIDES=%%N"

set "PAGE=file:///%CD:\=/%/slides.html"

for %%L in (!LOCALES!) do (
    if not exist "copy\%%L.js" (
        echo Unknown locale: %%L
        exit /b 1
    )
    set "OUT=%CD%\..\%%L\StoreImages"
    if not exist "!OUT!" mkdir "!OUT!"
    for /l %%I in (1,1,!SLIDES!) do (
        set "NUM=0%%I"
        set "NUM=!NUM:~-2!"
        "%BROWSER%" --headless=new --hide-scrollbars --allow-file-access-from-files ^
            --window-size=1080,1920 --virtual-time-budget=5000 ^
            --screenshot="!OUT!\!NUM!.png" "!PAGE!?lang=%%L&slide=%%I" 2>nul
        echo %%L\StoreImages\!NUM!.png
    )
)

echo.
echo Done. Open store-images\slides.html in a browser to preview every locale at once.

endlocal
