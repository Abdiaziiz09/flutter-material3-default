/// Minimal, dependency-free key-value persistence interface.
///
/// Use this abstraction to persist user preferences, recent selections, or
/// progress across sessions without coupling `core/` or `features/` to a
/// specific storage package.
///
/// The foundation ships with [InMemoryKeyValueStore] for tests and ephemeral
/// sessions; production apps can implement [KeyValueStore] on top of
/// `shared_preferences`, `flutter_secure_storage`, or IndexedDB/SQLite.
abstract interface class KeyValueStore {
  /// Reads the string stored for [key], or `null` if not present.
  String? readString(String key);

  /// Stores [value] under [key].
  Future<void> writeString(String key, String value);

  /// Removes any value stored under [key].
  Future<void> remove(String key);

  /// Clears all entries in this store.
  Future<void> clear();
}

/// Ephemeral in-memory implementation of [KeyValueStore].
///
/// Useful as a safe default and in unit/widget tests.
class InMemoryKeyValueStore implements KeyValueStore {
  /// Creates an empty in-memory store, optionally seeded with [initialValues].
  InMemoryKeyValueStore([Map<String, String>? initialValues])
    : _values = <String, String>{...?initialValues};

  final Map<String, String> _values;

  @override
  String? readString(String key) => _values[key];

  @override
  Future<void> writeString(String key, String value) async {
    _values[key] = value;
  }

  @override
  Future<void> remove(String key) async {
    _values.remove(key);
  }

  @override
  Future<void> clear() async {
    _values.clear();
  }
}
