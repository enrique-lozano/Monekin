#!/usr/bin/env bash
#
# Regenerates the Google Play store screenshots for every supported locale,
# using the integration test in
# integration_test/tests/screenshots/screenshots_test.dart.
#
# Requirements:
#   - A running Android emulator (or connected device). Use a device/skin
#     close to what the store listing expects (e.g. a Pixel 6 emulator).
#   - Run from the repository root.
#
# Usage:
#   ./scripts/generate_screenshots.sh [locale ...]
#
#   With no arguments, generates screenshots for every locale in
#   lib/i18n/json/. Pass one or more locale codes to only regenerate those,
#   e.g.:
#
#   ./scripts/generate_screenshots.sh en es

set -euo pipefail

cd "$(dirname "$0")/.."

if [ "$#" -gt 0 ]; then
  LOCALES=("$@")
else
  LOCALES=()
  for file in lib/i18n/json/*.json; do
    LOCALES+=("$(basename "$file" .json)")
  done
fi

for locale in "${LOCALES[@]}"; do
  echo "📸  Generating screenshots for locale: $locale"

  flutter drive \
    --driver=test_driver/integration_test.dart \
    --target=integration_test/tests/screenshots/screenshots_test.dart \
    --dart-define=SCREENSHOT_LOCALE="$locale"
done

echo "✅  Done. Review the updated images under app-marketplaces/screenshots/ before committing."
