import 'package:pokedex/core/api/api_endpoints.dart';

enum Environment {
  development,
  staging,
  production,
}

class AppConfig {
  // Môi trường hiện tại
  static Environment environment = Environment.development;

  // Cấu hình biến theo môi trường
  static String get apiBaseUrl {
    switch (environment) {
      case Environment.development:
        return ApiEndpoints.baseUrl;
      case Environment.staging:
        return 'https://staging-api.example.com/v1';
      case Environment.production:
        return 'https://api.example.com/v1';
    }
  }

  // Các cấu hình khác
  static bool get isDevelopment => environment == Environment.development;
  static bool get isStaging => environment == Environment.staging;
  static bool get isProduction => environment == Environment.production;

  // Các cấu hình chung
  static const String appName = 'My Flutter App';
  static const String appVersion = '1.0.0';

  // Các thông số khác
  static const int connectTimeout = 30000; // 30 seconds
  static const int receiveTimeout = 30000; // 30 seconds
}
