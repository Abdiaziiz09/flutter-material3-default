import 'package:flutter_material3_default/core/responsive/breakpoints.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('WindowSizeClass.fromWidth', () {
    test('classifies widths at and around every Material 3 breakpoint', () {
      const expectedClassByWidth = <double, WindowSizeClass>{
        0: WindowSizeClass.compact,
        320: WindowSizeClass.compact,
        599.9: WindowSizeClass.compact,
        600: WindowSizeClass.medium,
        839.9: WindowSizeClass.medium,
        840: WindowSizeClass.expanded,
        1199.9: WindowSizeClass.expanded,
        1200: WindowSizeClass.large,
        1599.9: WindowSizeClass.large,
        1600: WindowSizeClass.extraLarge,
        2560: WindowSizeClass.extraLarge,
      };

      expectedClassByWidth.forEach((width, expectedClass) {
        expect(
          WindowSizeClass.fromWidth(width),
          expectedClass,
          reason: 'A width of $width should be ${expectedClass.name}.',
        );
      });
    });

    test('treats an unbounded width as the largest class', () {
      expect(
        WindowSizeClass.fromWidth(double.infinity),
        WindowSizeClass.extraLarge,
      );
    });

    test('treats a negative width as compact', () {
      expect(WindowSizeClass.fromWidth(-1), WindowSizeClass.compact);
    });
  });

  group('WindowSizeClass.isAtLeast', () {
    test('is true for the same and for smaller classes', () {
      expect(WindowSizeClass.medium.isAtLeast(WindowSizeClass.medium), isTrue);
      expect(
        WindowSizeClass.expanded.isAtLeast(WindowSizeClass.compact),
        isTrue,
      );
    });

    test('is false for larger classes', () {
      expect(
        WindowSizeClass.compact.isAtLeast(WindowSizeClass.medium),
        isFalse,
      );
    });
  });

  group('WindowSizeClass.pageMargin', () {
    test('never shrinks as the window grows', () {
      for (var index = 1; index < WindowSizeClass.values.length; index++) {
        expect(
          WindowSizeClass.values[index].pageMargin,
          greaterThanOrEqualTo(WindowSizeClass.values[index - 1].pageMargin),
        );
      }
    });
  });
}
