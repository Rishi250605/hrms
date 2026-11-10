import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'preferences.g.dart';

/// Small per-device preferences (e.g. the selected business unit per user).
abstract interface class Preferences {
  Future<String?> read(String key);
  Future<void> write(String key, String? value);
}

class SecurePreferences implements Preferences {
  SecurePreferences([FlutterSecureStorage? storage]) : _storage = storage ?? const FlutterSecureStorage();

  final FlutterSecureStorage _storage;

  @override
  Future<String?> read(String key) => _storage.read(key: 'hrms.pref.$key');

  @override
  Future<void> write(String key, String? value) => value == null ? _storage.delete(key: 'hrms.pref.$key') : _storage.write(key: 'hrms.pref.$key', value: value);
}

/// For tests.
class MemoryPreferences implements Preferences {
  final values = <String, String>{};

  @override
  Future<String?> read(String key) async => values[key];

  @override
  Future<void> write(String key, String? value) async => value == null ? values.remove(key) : values[key] = value;
}

@Riverpod(keepAlive: true)
Preferences preferences(Ref ref) => SecurePreferences();
