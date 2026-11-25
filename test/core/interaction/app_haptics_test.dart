import 'package:flutter_material3_default/core/interaction/app_haptics.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('AppHaptics', () {
    test('completes safely on non-mobile test hosts', () async {
      await expectLater(AppHaptics.selection(), completes);
      await expectLater(AppHaptics.lightImpact(), completes);
      await expectLater(AppHaptics.confirm(), completes);
    });
  });
}
