import 'package:flutter/foundation.dart';

/// Build-time configuration. Override with
/// `flutter run --dart-define=API_BASE_URL=https://hrms.example.in/api/v1`.
class AppConfig {
  const AppConfig({required this.apiBaseUrl});

  final String apiBaseUrl;

  static const _fromEnv = String.fromEnvironment('API_BASE_URL');

  factory AppConfig.fromEnvironment() {
    if (_fromEnv.isNotEmpty) return AppConfig(apiBaseUrl: _fromEnv);
    // Local dev defaults: the Android emulator reaches the host machine via 10.0.2.2.
    final isAndroid = !kIsWeb && defaultTargetPlatform == TargetPlatform.android;
    return AppConfig(apiBaseUrl: isAndroid ? 'http://10.177.2.204:3000/api/v1' : 'http://10.177.2.204:3000/api/v1');
  }
}
