# Platform Support

One codebase targets Android, iOS, Web, Windows, macOS and Linux. The UI uses
Material 3 on all of them; behaviour adapts where platform conventions matter.

## Rules for shared code

- Do **not** import `dart:io` in shared UI code; it is unavailable on Web. Use
  `AppPlatform` (`defaultTargetPlatform` and `kIsWeb`).
- Put genuinely platform-specific code behind an interface and use conditional
  imports. Keep it out of widgets.
- Never fork the UI into separate "mobile" and "desktop" apps. One responsive
  UI serves all.

## Platform checklist

| Platform | Input | Notes |
| -------- | ----- | ----- |
| Android | Touch, system back | Handle the system back gesture; use edge-to-edge with `SafeArea`. |
| iOS | Touch, swipe back | Keep Material widgets; the default scroll physics and page transitions follow the platform. Respect safe areas and the home indicator. |
| Web | Mouse, keyboard, touch | Support window resizing, browser zoom, text selection where appropriate, URL routes, and keep the initial payload small. |
| Windows / macOS / Linux | Mouse, keyboard, trackpad | Provide hover states, tooltips, focus traversal, keyboard shortcuts and sensible minimum window sizes. |

## Input support

- **Touch**: minimum 48 × 48 dp targets.
- **Mouse**: hover feedback and tooltips for icon-only buttons; mouse-drag
  scrolling is enabled through `AppScrollBehavior`.
- **Keyboard**: every interactive element is reachable with Tab, shows a
  visible focus indicator and activates with Enter or Space. Add `Shortcuts`
  and `Actions` for common desktop commands.
- **Stylus and trackpad**: supported through Flutter's default gesture arena.

## Building and running

```bash
flutter run -d chrome        # Web
flutter run -d windows       # Windows
flutter run -d macos         # macOS
flutter run -d linux         # Linux
flutter run                  # Android / iOS (connected device or emulator)

flutter build apk            # Android
flutter build ios            # iOS (requires macOS and Xcode)
flutter build web            # Web
flutter build windows        # Windows (requires Windows and Visual Studio)
flutter build macos          # macOS (requires macOS and Xcode)
flutter build linux          # Linux (requires Linux build toolchain)
```

## Native platform folders

The `android/`, `ios/`, `web/`, `windows/`, `macos/` and `linux/` folders are
generated with `flutter create` (see `tool/bootstrap.sh`) so they always match
your installed Flutter SDK. After generation, commit them to your own
application repository and customise identifiers, icons and permissions there.
