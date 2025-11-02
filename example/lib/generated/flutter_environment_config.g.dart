// GENERATED CODE - DO NOT MODIFY BY HAND
// Generated on: 2025-11-02T13:42:51.918946
// Variables: 11 from 4 environment files
// Project: Consumer

import 'package:flutter_environment_config/flutter_environment_config.dart';

/// Type-safe access to environment variables through code generation.
/// This class provides static-only access and cannot be instantiated.
abstract class FlutterEnvironmentConfigGeneration {
  // Private constructor to prevent instantiation
  FlutterEnvironmentConfigGeneration._();

  /// Gets the value of APP_NAME environment variable.
  /// Available in: .env.develop, .env.production, .env.staging
  /// Missing in: .env.test
  /// Returns null if not set or invalid.
  static String? get appName {
    return FlutterEnvironmentConfig.get('APP_NAME');
  }

  /// Gets the value of APP_BUNDLE_ID environment variable.
  /// Available in: .env.develop, .env.production, .env.staging
  /// Missing in: .env.test
  /// Returns null if not set or invalid.
  static String? get appBundleId {
    return FlutterEnvironmentConfig.get('APP_BUNDLE_ID');
  }

  /// Gets the value of APP_VERSION_NAME environment variable.
  /// Available in: .env.develop, .env.production, .env.staging
  /// Missing in: .env.test
  /// Returns null if not set or invalid.
  static String? get appVersionName {
    return FlutterEnvironmentConfig.get('APP_VERSION_NAME');
  }

  /// Gets the value of APP_VERSION_BUILD environment variable.
  /// Available in: .env.develop, .env.production, .env.staging
  /// Missing in: .env.test
  /// Returns null if not set or invalid.
  static int? get appVersionBuild {
    final value = FlutterEnvironmentConfig.get('APP_VERSION_BUILD');
    return value != null ? int.tryParse(value) : null;
  }

  /// Gets the value of API_KEY environment variable.
  /// Available in: .env.develop, .env.production, .env.staging
  /// Missing in: .env.test
  /// Returns null if not set or invalid.
  static String? get apiKey {
    return FlutterEnvironmentConfig.get('API_KEY');
  }

  /// Gets the value of EMPTY_VALUE environment variable.
  /// Available in: .env.develop, .env.production, .env.staging
  /// Missing in: .env.test
  /// Returns null if not set or invalid.
  static String? get emptyValue {
    return FlutterEnvironmentConfig.get('EMPTY_VALUE');
  }

  /// Gets the value of FEATURE_ENABLED environment variable.
  /// Available in: .env.test
  /// Missing in: .env.develop, .env.production, .env.staging
  /// Returns null if not set or invalid.
  static bool? get featureEnabled {
    final value = FlutterEnvironmentConfig.get('FEATURE_ENABLED');
    return value?.toLowerCase() == 'true';
  }

  /// Gets the value of MAX_RETRIES environment variable.
  /// Available in: .env.test
  /// Missing in: .env.develop, .env.production, .env.staging
  /// Returns null if not set or invalid.
  static int? get maxRetries {
    final value = FlutterEnvironmentConfig.get('MAX_RETRIES');
    return value != null ? int.tryParse(value) : null;
  }

  /// Gets the value of TIMEOUT_SECONDS environment variable.
  /// Available in: .env.test
  /// Missing in: .env.develop, .env.production, .env.staging
  /// Returns null if not set or invalid.
  static double? get timeoutSeconds {
    final value = FlutterEnvironmentConfig.get('TIMEOUT_SECONDS');
    return value != null ? double.tryParse(value) : null;
  }

  /// Gets the value of DEBUG_MODE environment variable.
  /// Available in: .env.test
  /// Missing in: .env.develop, .env.production, .env.staging
  /// Returns null if not set or invalid.
  static bool? get debugMode {
    final value = FlutterEnvironmentConfig.get('DEBUG_MODE');
    return value?.toLowerCase() == 'true';
  }

  /// Gets the value of CACHE_SIZE environment variable.
  /// Available in: .env.test
  /// Missing in: .env.develop, .env.production, .env.staging
  /// Returns null if not set or invalid.
  static int? get cacheSize {
    final value = FlutterEnvironmentConfig.get('CACHE_SIZE');
    return value != null ? int.tryParse(value) : null;
  }

  // Environment variable keys
  static const String kAppNameKey = 'APP_NAME';
  static const String kAppBundleIdKey = 'APP_BUNDLE_ID';
  static const String kAppVersionNameKey = 'APP_VERSION_NAME';
  static const String kAppVersionBuildKey = 'APP_VERSION_BUILD';
  static const String kApiKeyKey = 'API_KEY';
  static const String kEmptyValueKey = 'EMPTY_VALUE';
  static const String kFeatureEnabledKey = 'FEATURE_ENABLED';
  static const String kMaxRetriesKey = 'MAX_RETRIES';
  static const String kTimeoutSecondsKey = 'TIMEOUT_SECONDS';
  static const String kDebugModeKey = 'DEBUG_MODE';
  static const String kCacheSizeKey = 'CACHE_SIZE';
}
