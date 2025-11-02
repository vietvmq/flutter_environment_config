# 🚨 First Time Setup Required

Welcome to `flutter_environment_config`! 

## Quick Start

If you're seeing a compile error about `_EnvironmentGeneration`, you need to run the code generator first:

```bash
dart generator/generate_environment_config.dart
```

This command will:
- ✅ Scan all your `.env.*.example` files 
- ✅ Generate type-safe getters with proper nullable types
- ✅ Add availability tracking comments
- ✅ Create the `_EnvironmentGeneration` class

## What You Get

After running the generator, you can use type-safe access:

```dart
// Type-safe nullable access
final appName = FlutterEnvironmentConfig.generation.appName ?? 'Default App';
final apiTimeout = FlutterEnvironmentConfig.generation.apiTimeout ?? 5000;
final isLoggerEnabled = FlutterEnvironmentConfig.generation.enabledLogger ?? false;

// vs traditional string-based access
final appName = FlutterEnvironmentConfig.get('APP_NAME') ?? 'Default App';
```

## Environment Files

Create your environment files in the project root:

- `.env.develop.example`
- `.env.staging.example` 
- `.env.production.example`

Example file content:
```bash
APP_NAME=My App
API_URL=https://api.example.com
VER_CODE=1
ENABLED_LOGGER=true
```

## Re-generate After Changes

Whenever you modify environment files, re-run:

```bash
dart generator/generate_environment_config.dart
```

This keeps your type-safe access in sync with your environment configuration.

---

**🔥 Pro Tip**: Add this to your IDE tasks or git hooks for automatic generation!