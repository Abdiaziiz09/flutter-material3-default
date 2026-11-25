import 'package:flutter/material.dart';
import 'package:flutter_material3_default/core/storage/key_value_store.dart';
import 'package:flutter_material3_default/core/theme/theme_controller.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('InMemoryKeyValueStore', () {
    test('writes, reads, removes and clears values', () async {
      final store = InMemoryKeyValueStore();

      expect(store.readString('key'), isNull);
      await store.writeString('key', 'value');
      expect(store.readString('key'), 'value');

      await store.remove('key');
      expect(store.readString('key'), isNull);

      await store.writeString('a', '1');
      await store.clear();
      expect(store.readString('a'), isNull);
    });
  });

  group('ThemeController persistence', () {
    test('restores and persists ThemeMode through KeyValueStore', () async {
      final store = InMemoryKeyValueStore(<String, String>{
        ThemeController.storageKey: ThemeMode.dark.name,
      });

      final controller = ThemeController(store: store);
      addTearDown(controller.dispose);
      expect(controller.themeMode, ThemeMode.dark);

      controller.updateThemeMode(ThemeMode.light);
      expect(
        store.readString(ThemeController.storageKey),
        ThemeMode.light.name,
      );
    });
  });
}
