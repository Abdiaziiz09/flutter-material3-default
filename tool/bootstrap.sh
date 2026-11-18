#!/usr/bin/env bash
# Prepares a fresh clone of the repository for development.
#
# What it does:
#   1. Generates the native platform folders (android, ios, web, windows,
#      macos, linux) with `flutter create`. Existing Dart files are kept.
#   2. Fetches dependencies.
#   3. Formats the code with the official Dart formatter.
#   4. Runs static analysis and the test suite.
#
# Usage:
#   ./tool/bootstrap.sh [organization]
#
# The optional organization argument is a reverse-domain name used for the
# Android package and the iOS/macOS bundle identifier, for example `com.acme`.

set -euo pipefail

ORGANIZATION="${1:-com.example}"

cd "$(dirname "$0")/.."

if ! command -v flutter >/dev/null 2>&1; then
  echo "error: Flutter SDK not found on PATH. Install it from https://docs.flutter.dev/get-started/install" >&2
  exit 1
fi

echo "==> Generating platform folders (organization: ${ORGANIZATION})"
flutter create . \
  --org "${ORGANIZATION}" \
  --platforms=android,ios,web,windows,macos,linux

echo "==> Fetching dependencies"
flutter pub get

echo "==> Formatting"
dart format .

echo "==> Analyzing"
flutter analyze

echo "==> Testing"
flutter test

echo "Done. Run the app with: flutter run -d <device>"
