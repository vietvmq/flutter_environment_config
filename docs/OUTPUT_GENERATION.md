# Custom Output Directory Configuration

You can customize where the generated `flutter_environment_config.g.dart` file is placed by adding configuration to your `pubspec.yaml`.

## Configuration

Add the following section to your `pubspec.yaml`:

```yaml
# Configuration for flutter_environment_config generator
flutter_environment_config:
  # Specify custom output directory (optional, defaults to 'lib')
  output_dir: lib/config # or any other directory you prefer
```

## Examples

### Default (lib directory)

```yaml
# No configuration needed - defaults to lib/
```

Generated file: `lib/flutter_environment_config.g.dart`

### Custom generated directory

```yaml
flutter_environment_config:
  output_dir: lib/generated
```

Generated file: `lib/generated/flutter_environment_config.g.dart`

### Custom models directory

## Usage After Generation

Regardless of where you place the generated file, the import and usage remain the same:

```dart
import 'package:flutter_environment_config/flutter_environment_config.dart';

void main() {
  // Access generated environment variables
  print('App Name: ${FlutterEnvironmentConfigGeneration.appName}');
  print('API URL: ${FlutterEnvironmentConfigGeneration.apiBaseUrl}');
  print('Debug Mode: ${FlutterEnvironmentConfigGeneration.debugMode}');
}
```

## Notes

- The `output_dir` path is relative to your project root
- The directory will be created automatically if it doesn't exist
- The generated file name is always `flutter_environment_config.g.dart`
- You can use any subdirectory structure you prefer (e.g., `lib/config/env`, `lib/constants`, etc.)
