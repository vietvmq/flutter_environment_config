# Flutter Environment Config

[![pub package](https://img.shields.io/pub/v/flutter_environment_config.svg)](https://pub.dev/packages/flutter_environment_config)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

A Flutter plugin that exposes environment variables to your Dart code as well as to your native code in iOS and Android. Bring some [12 factor](https://12factor.net/config) love to your Flutter apps! 🚀

Inspired by [react-native-config](https://github.com/luggit/react-native-config)

## ✨ Features

- 🔧 Load environment variables from `.env` files
- 📱 Access variables in Dart, iOS (Swift/Objective-C), and Android (Kotlin/Java)
- 🧪 Testing support with mock values
- 🔒 Multiple environment support (dev, staging, prod)
- ⚡ Zero configuration for iOS, minimal setup for Android

## 🚀 Quick Start

### 1. Create Environment File

Create a `.env` file in the root of your Flutter project:

```bash
# API Configuration
API_URL=https://api.myapp.com
API_KEY=your-api-key-here

# Feature Flags
ENABLE_ANALYTICS=true
DEBUG_MODE=false

# App Configuration
APP_NAME=MyAwesomeApp
VERSION_NAME=1.0.0
```

### 2. Load Variables in Dart

```dart
import 'package:flutter_environment_config/flutter_environment_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load environment variables
  await FlutterEnvironmentConfig.loadEnvVariables();

  runApp(MyApp());
}
```

### 3. Access Variables Anywhere

```dart
import 'package:flutter_environment_config/flutter_environment_config.dart';

class ApiService {
  static String get baseUrl => FlutterEnvironmentConfig.get('API_URL') ?? '';
  static String get apiKey => FlutterEnvironmentConfig.get('API_KEY') ?? '';
  static bool get enableAnalytics =>
    FlutterEnvironmentConfig.get('ENABLE_ANALYTICS') == 'true';
}

// Usage
final url = ApiService.baseUrl; // returns 'https://api.myapp.com'
```

## ⚠️ Security Notice

This plugin doesn't obfuscate or encrypt secrets for packaging. **Never store sensitive information in `.env` files** as they can be reverse-engineered from your app bundle.

For sensitive data, use secure storage solutions or server-side configuration.

## 📱 Native Platform Usage

### iOS (Swift/Objective-C)

First, import the plugin:

```swift
import flutter_environment_config
```

Then access your environment variables:

```swift
let apiKey = flutter_environment_config.FlutterEnvironmentConfigPlugin.env(for: "API_KEY")
```

### Android (Kotlin/Java)

Environment variables are automatically available in your Android build process. See the [Android Setup Guide](docs/ANDROID.md) for configuration details.

## 📝 Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  flutter_environment_config: ^1.0.0
```

Then run:

```bash
flutter pub get
```

## 🛠️ Setup

### iOS Setup

No additional setup required! 🎉

### Android Setup

Refer to the [Android Setup Guide](docs/ANDROID.md) for initial configuration and advanced options.

## 🧪 Testing

Use `loadValueForTesting` to mock environment variables in your tests:

```dart
import 'package:flutter_environment_config/flutter_environment_config.dart';

void main() {
  setUp(() {
    FlutterEnvironmentConfig.loadValueForTesting({
      'API_URL': 'https://test-api.com',
      'DEBUG_MODE': 'true',
    });
  });

  test('should use test environment variables', () {
    final apiUrl = FlutterEnvironmentConfig.get('API_URL');
    expect(apiUrl, equals('https://test-api.com'));
  });
}
```

## 🌍 Multiple Environments

You can use different `.env` files for different environments:

```bash
.env              # Default
.env.development  # Development
.env.staging      # Staging
.env.production   # Production
```

## 📚 Documentation

- [Android Setup Guide](docs/ANDROID.md) - Detailed Android configuration
- [iOS Setup Guide](docs/IOS.md) - Advanced iOS usage

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Inspired by [react-native-config](https://github.com/luggit/react-native-config)
- Built with ❤️ for the Flutter community
