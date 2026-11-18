import 'package:flutter_material3_default/core/widgets/adaptive_content_container.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AdaptiveContentContainer.horizontalInsetFor', () {
    test('uses the compact page margin on phones', () {
      expect(AdaptiveContentContainer.horizontalInsetFor(400), 16);
    });

    test('uses the medium page margin on tablets', () {
      expect(AdaptiveContentContainer.horizontalInsetFor(700), 24);
    });

    test('uses the large page margin when content fills the window', () {
      expect(AdaptiveContentContainer.horizontalInsetFor(1200), 32);
    });

    test('centres content on windows wider than the maximum width', () {
      // (2000 - 1200) / 2 = 400 dp on each side.
      expect(AdaptiveContentContainer.horizontalInsetFor(2000), 400);
    });

    test('respects a custom maximum width', () {
      // (1000 - 600) / 2 = 200 dp on each side.
      expect(
        AdaptiveContentContainer.horizontalInsetFor(1000, maxWidth: 600),
        200,
      );
    });
  });
}
