# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [2.1.0] - 2025-11-02

### 🎉 Major Features Added

- 🚀 **Type-Safe Code Generation**: Automatic generation of type-safe getters with intelligent type inference
- 🔍 **Recursive File Scanning**: Automatically discovers `.env` files in subdirectories
- 📦 **Multi-Package Support**: Seamless integration with complex project structures and monorepos
- 🌍 **Cross-Platform Generator**: Full support for Windows, macOS, and Linux development environments
- 🎨 **Enhanced CLI**: Beautiful colored terminal output with detailed progress information

### 🛠️ Generator Features

- ✨ **Automatic Type Detection**: Infers `String`, `bool`, `int`, `double` types from environment values
- 📂 **Smart Project Detection**: Automatically finds configuration from sub-packages
- 🔄 **Multiple Dependency Sources**: Supports path, git, and hosted package dependencies
- 🎯 **Custom Output Directories**: Configurable output locations via `pubspec.yaml`
- 📊 **Detailed Reporting**: Shows discovered files, generated variables, and output locations

### 🌐 Cross-Platform Improvements

- 🖥️ **Windows Support**: Uses `%LOCALAPPDATA%\Pub\Cache` or `%APPDATA%\Pub\Cache`
- 🍎 **macOS Support**: Uses `~/.pub-cache` with proper HOME detection
- 🐧 **Linux Support**: Full compatibility with Linux development environments
- 🔧 **PUB_CACHE Detection**: Respects custom `PUB_CACHE` environment variable

### 📝 CLI Commands

- `dart run flutter_environment_config:generate` - Generate type-safe code
- Automatic detection of generator location across all dependency types
- Intelligent fallback to pub cache when local paths not available

### 🎨 Developer Experience

- 🌈 **Colored Output**: Cyan, blue, yellow, magenta terminal colors for better readability
- 📋 **Progress Tracking**: Real-time feedback on file discovery and code generation
- 🔍 **Debug Information**: Detailed logging for troubleshooting
- ✅ **Success Indicators**: Clear completion messages with file locations

### 📚 Documentation Updates

- 📖 **Comprehensive README**: Updated with all new features and examples
- 🛠️ **Setup Guides**: Enhanced installation and configuration instructions
- 🧪 **Testing Examples**: Updated testing patterns with generated code
- 🔧 **Configuration Reference**: Complete pubspec.yaml configuration options

## [2.0.0] - 2025-10-26

### Breaking Changes

- 💥 **PROJECT RENAMED**: Changed project name from `flutter_environment_config` to `flutter_environment_config`
- 💥 **CLASS RENAMED**: Changed class name from `FlutterEnvironmentConfig` to `FlutterEnvironmentConfig`
- 💥 **IMPORT UPDATED**: Import path changed to `package:flutter_environment_config/flutter_environment_config.dart`

### Added

- 🚀 Complete rewrite with improved API design
- 📱 Enhanced native platform support for iOS and Android
- 🧪 Better testing utilities with `loadValueForTesting`
- 📚 Comprehensive documentation and setup guides
- ✨ Support for multiple environment files (.env.development, .env.staging, etc.)
- 🔧 Improved error handling and validation
- 🎯 Better TypeScript-like null safety support

### Changed

- 💥 **BREAKING**: Updated minimum Flutter version to 1.10.0
- 💥 **BREAKING**: Updated minimum Dart SDK to 2.12.0 (null safety)
- 🔄 Refactored core plugin architecture for better performance
- 📖 Completely rewritten README with better examples
- 🎨 Improved API consistency across platforms

### Fixed

- 🐛 Fixed null value handling issues
- 🔧 Resolved Android build configuration problems
- 📱 Fixed iOS integration issues
- ⚡ Improved plugin initialization performance

### Security

- 🔒 Added security warnings about sensitive data storage
- 📝 Enhanced documentation about best practices

## [1.1.1] - 2023-XX-XX

### Improvements

- ✅ Support for Android SDK version 21+

### Resolved Issues

- 🐛 Compatibility issues with older Android versions

## [1.1.0] - 2023-XX-XX

### Major Changes

- 🔄 Major code refactoring for better maintainability
- 📖 Improved documentation

### Stability Improvements

- 🐛 Various stability improvements

## [1.0.0] - 2023-XX-XX

### Critical Fixes

- 🐛 Fixed issue where `FlutterEnvironmentConfig.get()` returned null values
- ✅ Improved value retrieval reliability

## [0.0.2] - 2023-XX-XX

### Updates

- ⬆️ Updated to Kotlin version 1.7.10
- 📝 Enhanced documentation

### Removed

- 🗑️ Removed deprecated Registrar usage

### Configuration

- 🔧 Updated build configuration
