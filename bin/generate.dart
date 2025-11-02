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

  // Check for environment files
  final envFiles = <String>[];
  for (final file in ['.env', '.env.develop', '.env.staging', '.env.production']) {
    if (File(file).existsSync()) {
      envFiles.add(file);
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