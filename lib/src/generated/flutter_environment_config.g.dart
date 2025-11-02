// GENERATED CODE - DO NOT MODIFY BY HAND
// Generated on: 2025-11-02T12:52:25.000890
// Variables: 11 from 3 environment files
// Project: Library

import 'package:flutter_environment_config/flutter_environment_config.dart';

/// Type-safe access to environment variables through code generation.
/// This class provides static-only access and cannot be instantiated.
abstract class FlutterEnvironmentConfigGeneration {
  // Private constructor to prevent instantiation
  FlutterEnvironmentConfigGeneration._();

  /// Gets the value of APP_NAME environment variable.
  /// Available in: .env.develop, .env.production, .env.staging
  /// Returns null if not set or invalid.
  static String? get appName {
    return FlutterEnvironmentConfig.get('APP_NAME');
  }

  /// Gets the value of API_URL environment variable.
  /// Available in: .env.develop, .env.production, .env.staging
  /// Returns null if not set or invalid.
  static String? get apiUrl {
    return FlutterEnvironmentConfig.get('API_URL');
  }

  /// Gets the value of VER_CODE environment variable.
  /// Available in: .env.develop, .env.production, .env.staging
  /// Returns null if not set or invalid.
  static int? get verCode {
    final value = FlutterEnvironmentConfig.get('VER_CODE');
    return value != null ? int.tryParse(value) : null;
  }

  /// Gets the value of VER_NAME environment variable.
  /// Available in: .env.develop, .env.production, .env.staging
  /// Returns null if not set or invalid.
  static String? get verName {
    return FlutterEnvironmentConfig.get('VER_NAME');
  }

  /// Gets the value of ENABLED_LOGGER environment variable.
  /// Available in: .env.develop, .env.production, .env.staging
  /// Returns null if not set or invalid.
  static bool? get enabledLogger {
    final value = FlutterEnvironmentConfig.get('ENABLED_LOGGER');
    return value?.toLowerCase() == 'true';
  }

  /// Gets the value of DATABASE_URL environment variable.
  /// Available in: .env.develop, .env.production, .env.staging
  /// Returns null if not set or invalid.
  static String? get databaseUrl {
    return FlutterEnvironmentConfig.get('DATABASE_URL');
  }

  /// Gets the value of API_TIMEOUT environment variable.
  /// Available in: .env.develop, .env.production, .env.staging
  /// Returns null if not set or invalid.
  static int? get apiTimeout {
    final value = FlutterEnvironmentConfig.get('API_TIMEOUT');
    return value != null ? int.tryParse(value) : null;
  }

  /// Gets the value of ENABLE_ANALYTICS environment variable.
  /// Available in: .env.develop, .env.production, .env.staging
  /// Returns null if not set or invalid.
  static bool? get enableAnalytics {
    final value = FlutterEnvironmentConfig.get('ENABLE_ANALYTICS');
    return value?.toLowerCase() == 'true';
  }

  /// Gets the value of GOOGLE_MAPS_API_KEY environment variable.
  /// Available in: .env.develop, .env.production, .env.staging
  /// Returns null if not set or invalid.
  static String? get googleMapsApiKey {
    return FlutterEnvironmentConfig.get('GOOGLE_MAPS_API_KEY');
  }

  /// Gets the value of FIREBASE_PROJECT_ID environment variable.
  /// Available in: .env.develop, .env.production, .env.staging
  /// Returns null if not set or invalid.
  static String? get firebaseProjectId {
    return FlutterEnvironmentConfig.get('FIREBASE_PROJECT_ID');
  }

  /// Gets the value of APP_ID environment variable.
  /// Available in: .env.develop, .env.production, .env.staging
  /// Returns null if not set or invalid.
  static String? get appId {
    return FlutterEnvironmentConfig.get('APP_ID');
  }

  // Environment variable keys
  static const String kAppNameKey = 'APP_NAME';
  static const String kApiUrlKey = 'API_URL';
  static const String kVerCodeKey = 'VER_CODE';
  static const String kVerNameKey = 'VER_NAME';
  static const String kEnabledLoggerKey = 'ENABLED_LOGGER';
  static const String kDatabaseUrlKey = 'DATABASE_URL';
  static const String kApiTimeoutKey = 'API_TIMEOUT';
  static const String kEnableAnalyticsKey = 'ENABLE_ANALYTICS';
  static const String kGoogleMapsApiKeyKey = 'GOOGLE_MAPS_API_KEY';
  static const String kFirebaseProjectIdKey = 'FIREBASE_PROJECT_ID';
  static const String kAppIdKey = 'APP_ID';
}
