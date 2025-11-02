#!/usr/bin/env dart

/// Flutter Environment Config Generator Runner
/// Automatically copies and runs the generator in your project

import 'dart:io';

void main() async {
  print('🔧 Flutter Environment Config Generator');
  print('');

  // Check if we're in a consumer project or library
  final pubspecFile = File('pubspec.yaml');
  if (!pubspecFile.existsSync()) {
    print('❌ No pubspec.yaml found. Run this from your Flutter project root.');
    exit(1);
  }

  // Check for environment files (recursive scan)
  final envFiles = <String>[];
  final directory = Directory.current;
  
  // First scan root directory
  await for (final entity in directory.list()) {
    if (entity is File) {
      final name = entity.path.split('/').last;
      // Look for .env, .env.*, but skip .env.example files
      if (name == '.env' || 
          (name.startsWith('.env.') && !name.endsWith('.example'))) {
        envFiles.add(name);
      }
    }
  }
  
  // If no files found in root, scan subdirectories
  if (envFiles.isEmpty) {
    await for (final entity in directory.list()) {
      if (entity is Directory) {
        final dirName = entity.path.split('/').last;
        // Skip common directories that shouldn't contain env files
        if (!_shouldSkipDirectory(dirName)) {
          final subDirFiles = await _scanDirectoryForEnvFiles(entity);
          envFiles.addAll(subDirFiles.map((path) => path.split('/').last));
        }
      }
    }
  }

  if (envFiles.isEmpty) {
    print('❌ No environment files found!');
    print('   Create at least one: .env, .env.develop, .env.staging, .env.production');
    exit(1);
  }

  print('✅ Found environment files: ${envFiles.join(', ')}');

  // Try to find the generator script in the package
  final generatorPath = await _findGenerator();
  
  if (generatorPath != null) {
    print('🚀 Running generator...');
    final result = await Process.run('dart', [generatorPath]);
    print(result.stdout);
    if (result.stderr.toString().isNotEmpty) {
      print('⚠️  ${result.stderr}');
    }
  } else {
    print('');
    print('📋 Manual Setup Required:');
    print('1. Add to pubspec.yaml dev_dependencies:');
    print('   yaml: ^3.1.2');
    print('');
    print('2. Copy generator from:');
    print('   https://github.com/vietvmq/flutter_environment_config');
    print('   /generator/generate_environment_config.dart');
    print('');
    print('3. Run: dart generate_environment_config.dart');
  }
}

Future<String?> _findGenerator() async {
  // Try to find generator in different locations
  final locations = [
    'generator/generate_environment_config.dart',  // In development
    '../generator/generate_environment_config.dart',  // From example
    '../../generator/generate_environment_config.dart',  // Alternative
  ];

  for (final location in locations) {
    if (File(location).existsSync()) {
      return location;
    }
  }

  return null;
}

/// Scan a specific directory for env files (non-recursive to avoid going too deep)
Future<List<String>> _scanDirectoryForEnvFiles(Directory directory) async {
  final envFiles = <String>[];
  
  try {
    await for (final entity in directory.list()) {
      if (entity is File) {
        final name = entity.path.split('/').last;
        // Look for .env, .env.*, but skip .env.example files
        if (name == '.env' || 
            (name.startsWith('.env.') && !name.endsWith('.example'))) {
          envFiles.add(entity.path);
        }
      }
    }
  } catch (e) {
    // Ignore permission errors or other issues
  }
  
  return envFiles;
}

/// Check if directory should be skipped during env file scanning
bool _shouldSkipDirectory(String dirName) {
  final skipDirs = {
    'node_modules', '.git', '.dart_tool', 'build', '.vscode', '.idea',
    'ios', 'android', 'web', 'linux', 'macos', 'windows', // Flutter platform dirs
    'lib', 'test', 'integration_test', // Dart/Flutter source dirs (usually don't contain env)
    '.pub-cache', '.flutter-plugins-dependencies',
    'Pods', 'Runner.xcworkspace', 'Runner.xcodeproj', // iOS specific
    'gradle', '.gradle', 'app', 'src', // Android specific
  };
  
  return skipDirs.contains(dirName) || dirName.startsWith('.');
}