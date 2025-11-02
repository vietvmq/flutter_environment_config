# Generator

This folder contains all the code generation tools and utilities for the `flutter_environment_config` package.

## Files

### `generate_environment_config.dart`

The main code generation script that reads environment files and generates type-safe Dart code.

**Usage:**

```bash
dart generator/generate_environment_config.dart
```

**What it does:**

- Reads `.env.develop.example`, `.env.staging.example`, `.env.production.example` files
- Generates `lib/src/flutter_environment_config_generated.g.dart` with type-safe getters
- Creates nullable access patterns (returns null if not set or invalid)
- Infers types (String, int, bool, double) from environment variable values

### `environment_config_generator.dart`
Build runner generator class for more advanced code generation scenarios (optional).

**Usage:**
```bash
flutter packages pub run build_runner build
```

### `annotations.dart`
Contains annotations used for marking classes for code generation when using the build_runner approach.

### `build.yaml`
Configuration file for build_runner (if using the build_runner approach instead of the simple script).

## Generated Output

The generator creates:
- `_EnvironmentGeneration` class with type-safe getters
- Extension on `FlutterEnvironmentConfig` for static access
- Constants for all environment variable keys

## Access Pattern

After generation, use the type-safe API:

```dart
// Nullable access - returns null if not set or invalid
String? appName = FlutterEnvironmentConfig.generation.appName;
bool? logger = FlutterEnvironmentConfig.generation.enabledLogger;

// Handle null values as needed
String appNameSafe = appName ?? 'Default App Name';
bool loggerEnabled = logger ?? false;

// Constants
String key = FlutterEnvironmentConfig.generation.kAppNameKey;
```

## Development Workflow

1. Update your `.env` files with new variables
2. Run: `dart generator/generate_environment_config.dart`
3. Use the generated type-safe getters in your code
4. Commit both the environment files and generated code

## Environment File Structure

The generator expects environment files in the project root:
- `.env.develop` (or `.env.develop.example`)
- `.env.staging` (or `.env.staging.example`) 
- `.env.production` (or `.env.production.example`)

Format:
```bash
APP_NAME=My App
APP_ID=com.example.myapp
VER_CODE=1
VER_NAME=1.0.0
ENABLED_LOGGER=true
API_URL=https://api.example.com
```