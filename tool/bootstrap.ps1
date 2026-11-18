# Prepares a fresh clone of the repository for development (Windows).
#
# What it does:
#   1. Generates the native platform folders (android, ios, web, windows,
#      macos, linux) with `flutter create`. Existing Dart files are kept.
#   2. Fetches dependencies.
#   3. Formats the code with the official Dart formatter.
#   4. Runs static analysis and the test suite.
#
# Usage:
#   .\tool\bootstrap.ps1 [-Organization com.acme]

param(
  [string]$Organization = "com.example"
)

$ErrorActionPreference = "Stop"

Set-Location (Join-Path $PSScriptRoot "..")

if (-not (Get-Command flutter -ErrorAction SilentlyContinue)) {
  Write-Error "Flutter SDK not found on PATH. Install it from https://docs.flutter.dev/get-started/install"
  exit 1
}

Write-Host "==> Generating platform folders (organization: $Organization)"
flutter create . --org $Organization --platforms=android,ios,web,windows,macos,linux

Write-Host "==> Fetching dependencies"
flutter pub get

Write-Host "==> Formatting"
dart format .

Write-Host "==> Analyzing"
flutter analyze

Write-Host "==> Testing"
flutter test

Write-Host "Done. Run the app with: flutter run -d <device>"
