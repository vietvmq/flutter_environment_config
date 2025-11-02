# Flutter Environment Configuration Guide

This guide explains how to set up and work with multiple environments (development, staging, production) in Flutter projects using the `flutter_environment_config` package.

## Table of Contents

1. [Introduction](#introduction)
2. [Installation](#installation)
3. [Basic Usage](#basic-usage)
4. [Type-Safe Environment Access](#type-safe-environment-access)
5. [Environment File Setup](#environment-file-setup)
6. [iOS Configuration](#ios-configuration)
7. [Android Configuration](#android-configuration)
8. [Best Practices](#best-practices)
9. [Troubleshooting](#troubleshooting)

## Introduction

During Flutter app development, you need to work with different environments:

- **Develop**: For local development and testing
- **Staging**: For testing in production-like environment
- **Production**: For the live application

The `flutter_environment_config` package helps you manage environment-specific configurations like API endpoints, app names, bundle IDs, and other settings.

## Installation

1. Add the dependency to your `pubspec.yaml`:

```yaml
dependencies:
  flutter_environment_config: ^1.0.0
```

2. Run the following command to install:

```bash
flutter pub get
```

## Basic Usage

### 1. Create Environment Files

Create environment files in your project root directory:

```
.env.develop         # Develop environment
.env.staging         # Staging environment
.env.production      # Production environment
```

### 2. Define Environment Variables

Example `.env.develop` file for develop:

```bash
APP_NAME=[DEV] Flutter Config
APP_ID=com.flutter_config.develop
API_URL=https://dev-api.example.com
VER_CODE=1
VER_NAME=1.0.0
ENABLED_LOGGER=true
```

Example `.env.staging` file:

```bash
APP_NAME=[STAGING] Flutter Config
APP_ID=com.flutter_config.staging
API_URL=https://staging-api.example.com
VER_CODE=1
VER_NAME=1.0.0
ENABLED_LOGGER=false
```

Example `.env.production` file:

```bash
APP_NAME=Flutter Config
APP_ID=com.flutter_config.production
API_URL=https://api.example.com
VER_CODE=1
VER_NAME=1.0.0
ENABLED_LOGGER=false
```

### 3. Load Environment Variables

In your `main.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_environment_config/flutter_environment_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterEnvironmentConfig.loadEnvVariables();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: FlutterEnvironmentConfig.get('APP_NAME') ?? 'Flutter App',
      home: const MyHomePage(),
    );
  }
}
```

### 4. Access Environment Variables

You can access environment variables anywhere in your app:

```dart
// Get a specific variable
String appName = FlutterEnvironmentConfig.get('APP_NAME') ?? 'Default App Name';
String apiUrl = FlutterEnvironmentConfig.get('API_URL') ?? 'https://default-api.com';
bool enabledLogger = FlutterEnvironmentConfig.get('ENABLED_LOGGER') == 'true';

// Get all variables
Map<String, String?> allVariables = FlutterEnvironmentConfig.variables;
```

## Type-Safe Environment Access

The package provides a type-safe way to access environment variables through code generation.

### 1. Setup Environment Files

First, create your environment files with all the variables you need:

**.env.develop**
```bash
APP_NAME=[DEV] Flutter Config
APP_ID=com.dev.flutterconfig
API_URL=https://dev-api.example.com
VER_CODE=1
VER_NAME=1.0.0
ENABLED_LOGGER=true
DATABASE_URL=https://dev-db.example.com
API_TIMEOUT=30000
ENABLE_ANALYTICS=false
```

### 2. Generate Type-Safe Access Class

Run the generator to create type-safe getters:

```bash
dart generator/generate_environment_config.dart
```

This will generate `lib/src/flutter_environment_config_value.g.dart` with type-safe getters for all your environment variables.

### 3. Use Type-Safe Access

```dart
```dart
import 'package:flutter_environment_config/flutter_environment_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterEnvironmentConfig.loadEnvVariables();
  
  // Type-safe access to environment variables (all nullable)
  final generation = FlutterEnvironmentConfig.generation;
  
  // Get nullable values - returns null if not set or invalid
  String? appName = generation.appName;
  bool? enabledLogger = generation.enabledLogger;
  int? verCode = generation.verCode;
  
  // Handle null values with your preferred approach
  String appNameSafe = appName ?? 'Default App Name';
  bool loggerEnabled = enabledLogger ?? false;
  int versionCode = verCode ?? 1;
  
  // Access constants for keys
  String appNameKey = FlutterEnvironmentConfigValue.kAppNameKey;
  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final generation = FlutterEnvironmentConfig.generation;
    
    return MaterialApp(
      title: generation.appName ?? 'Flutter App',
      home: Scaffold(
        appBar: AppBar(
          title: Text(generation.appName ?? 'Flutter App'),
        ),
        body: Column(
          children: [
            Text('API URL: ${generation.apiUrl ?? 'Not configured'}'),
            Text('Version: ${generation.verName ?? '0.0.0'}+${generation.verCode ?? 0}'),
            Text('Logger Enabled: ${generation.enabledLogger ?? false}'),
            Text('Analytics: ${generation.enableAnalytics ?? false}'),
          ],
        ),
      ),
    );
  }
}
```
```

### 4. Benefits of Type-Safe Access

- **Compile-time safety**: Typos in variable names are caught at compile time
- **Type inference**: Variables are properly typed (String, int, bool, double)
- **Null safety**: All getters return nullable types - handle null values as needed
- **Code completion**: IDE provides autocomplete for all environment variables
- **Flexibility**: You decide how to handle missing values (null coalescing, default values, etc.)

### 5. Regenerating After Changes

Whenever you add, remove, or modify environment variables:

1. Update your `.env` files
2. Run the generator: `dart generator/generate_environment_config.dart`
3. The generated code will automatically include your changes

## Environment File Setup

### File Structure

```
your_flutter_project/
├── .env.develop           # Develop (default)
├── .env.staging           # Staging
├── .env.production        # Production
├── lib/
│   └── main.dart
├── android/
├── ios/
└── pubspec.yaml
```

### Git Configuration

Add environment files to `.gitignore` to keep sensitive data secure:

```gitignore
# Environment files
.env.develop
.env.staging
.env.production
.env.local

# Generated files
**/ios/Flutter/tmp.xcconfig
```

Create example files for team members:

```
.env.develop.example
.env.staging.example
.env.production.example
```

## iOS Configuration

### 1. Xcode Configuration Files

Add the following line to both `ios/Flutter/Debug.xcconfig` and `ios/Flutter/Release.xcconfig`:

```
#include? "tmp.xcconfig"
```

### 2. Xcode Schemes Setup

1. Open your iOS project in Xcode: `ios/Runner.xcodeproj`

2. Go to **Product** → **Scheme** → **Edit Scheme**

3. Select **Build** → **Pre-actions**

4. Add "New Run Script Action" with:

```bash
echo ".env.develop" > ${SRCROOT}/.envfile
```

5. Add another "New Run Script Action":

```bash
${SRCROOT}/.symlinks/plugins/flutter_environment_config/ios/Classes/BuildXCConfig.rb ${SRCROOT}/ ${SRCROOT}/Flutter/tmp.xcconfig
```

6. Set "Provide build settings from" to **Runner**

7. Duplicate the scheme for each environment:
   - **develop**: Change first script to `echo ".env.develop" > ${SRCROOT}/.envfile`
   - **staging**: Change first script to `echo ".env.staging" > ${SRCROOT}/.envfile`
   - **production**: Change first script to `echo ".env.production" > ${SRCROOT}/.envfile`

### 3. Build Configuration

1. In Xcode, select your project → **Runner** → **Info**

2. Duplicate configurations for each environment:
   - Debug-develop, Release-develop
   - Debug-staging, Release-staging
   - Debug-production, Release-production

### 4. Dynamic App Information

Configure dynamic app information in **Build Settings**:

- **Product Bundle Identifier**: `${APP_ID}`
- **Product Name**: `${APP_NAME}`

In **User-Defined** section, set:

- `APP_ID`: `${APP_ID}`
- `APP_NAME`: `${APP_NAME}`
- `FLUTTER_BUILD_NAME`: `${VER_NAME}`
- `FLUTTER_BUILD_NUMBER`: `${VER_CODE}`

## Android Configuration

### 1. Gradle Configuration

Edit `android/app/build.gradle`:

```gradle
// Add at the top
project.ext.envConfigFiles = [
    develop    : ".env.develop",
    staging    : ".env.staging",
    production : ".env.production"
]

apply from: project(':flutter_environment_config').projectDir.getPath() + "/dotenv.gradle"

android {
    // ... existing configuration

    flavorDimensions "environment"

    productFlavors {
        develop {
            dimension "environment"
            applicationId project.env.get("APP_ID")
            versionCode project.env.get("VER_CODE").toInteger()
            versionName project.env.get("VER_NAME")
            resValue "string", "app_name", project.env.get("APP_NAME")
        }

        staging {
            dimension "environment"
            applicationId project.env.get("APP_ID")
            versionCode project.env.get("VER_CODE").toInteger()
            versionName project.env.get("VER_NAME")
            resValue "string", "app_name", project.env.get("APP_NAME")
        }

        production {
            dimension "environment"
            applicationId project.env.get("APP_ID")
            versionCode project.env.get("VER_CODE").toInteger()
            versionName project.env.get("VER_NAME")
            resValue "string", "app_name", project.env.get("APP_NAME")
        }
    }

    defaultConfig {
        // ... existing configuration
        resValue "string", "build_config_package", "your.package.name"
    }
}
```

### 2. Android Manifest Configuration

Edit `android/app/src/main/AndroidManifest.xml`:

```xml
<application
    android:label="@string/app_name"
    android:icon="@mipmap/ic_launcher">
    <!-- ... other configuration -->
</application>
```

### 3. ProGuard Configuration

Add to `android/app/proguard-rules.pro`:

```
-keep class your.package.name.BuildConfig { *; }
```

## Best Practices

### 1. Environment Variable Naming

Use consistent naming conventions:

```bash
# App Information
APP_NAME=My App
APP_ID=com.company.myapp
APP_VERSION=1.0.0
APP_BUILD_NUMBER=1

# API Configuration
API_BASE_URL=https://api.example.com
API_TIMEOUT=30000

# Feature Flags
ENABLE_ANALYTICS=true
ENABLE_CRASH_REPORTING=false
ENABLE_LOGGING=true

# Third-party Keys (be careful with sensitive data)
GOOGLE_MAPS_API_KEY=your_key_here
FIREBASE_PROJECT_ID=your_project_id
```

### 2. Environment Validation

Create a helper class to validate required environment variables:

```dart
class EnvironmentConfig {
  static void validateRequiredVariables() {
    final required = [
      'APP_NAME',
      'APP_ID',
      'API_BASE_URL',
      'APP_VERSION'
    ];

    for (final variable in required) {
      final value = FlutterEnvironmentConfig.get(variable);
      if (value == null || value.isEmpty) {
        throw Exception('Required environment variable $variable is missing');
      }
    }
  }

  static String get appName => FlutterEnvironmentConfig.get('APP_NAME')!;
  static String get apiBaseUrl => FlutterEnvironmentConfig.get('API_BASE_URL')!;
  static bool get enabledLogger => FlutterEnvironmentConfig.get('ENABLED_LOGGER') == 'true';
}
```

### 3. Building for Different Environments

```bash
# Develop
flutter run --flavor develop
flutter build apk --flavor develop

# Staging
flutter run --flavor staging
flutter build apk --flavor staging

# Production
flutter run --flavor production
flutter build apk --flavor production --release
```

## Troubleshooting

### Common Issues

1. **Environment variables not loading**

   - Ensure `await FlutterEnvironmentConfig.loadEnvVariables()` is called before `runApp()`
   - Check that environment files exist in the project root
   - Verify file naming matches exactly (case-sensitive)

2. **iOS build issues**

   - Ensure `tmp.xcconfig` is in `.gitignore`
   - Verify Xcode schemes are properly configured
   - Check that Ruby script has execute permissions

3. **Android build issues**

   - Ensure gradle files are properly configured
   - Check that flavor names match environment file configurations
   - Verify ProGuard rules are in place for release builds

4. **Variables returning null**
   - Check spelling of variable names (case-sensitive)
   - Ensure variables are defined in the correct environment file
   - Verify the correct environment file is being loaded

### Debug Tips

Add debugging to see which environment file is loaded:

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterEnvironmentConfig.loadEnvVariables();

  // Debug: Print all loaded variables
  print('Loaded environment variables:');
  FlutterEnvironmentConfig.variables.forEach((key, value) {
    print('$key: $value');
  });

  runApp(const MyApp());
}
```

## Conclusion

Using environment configurations properly allows you to:

- Maintain separate configurations for different deployment stages
- Keep sensitive information secure
- Easily switch between environments during development
- Automate builds with different configurations

This setup provides a robust foundation for managing multiple environments in your Flutter applications.
