#!/usr/bin/env dart

import "dart:io";
import "dart:convert";

void main() async {
  print('🔧 Flutter Environment Config Generator');
  
  // Find generator based on dependency type
  final generatorPath = await _findGenerator();
  
  if (generatorPath != null) {
    print('🚀 Running generator from: $generatorPath');
    
    // Copy generator to temporary location in current project
    final tempDir = Directory('.dart_tool/flutter_environment_config');
    if (!tempDir.existsSync()) {
      tempDir.createSync(recursive: true);
    }
    
    final tempGeneratorPath = '${tempDir.path}/generate_environment_config.dart';
    final generatorFile = File(generatorPath);
    final tempGeneratorFile = File(tempGeneratorPath);
    
    // Copy generator content
    await tempGeneratorFile.writeAsString(await generatorFile.readAsString());
    
    // Run from current directory with temp file
    final result = await Process.run(
      'dart', 
      [tempGeneratorPath],
      workingDirectory: Directory.current.path,
    );
    
    print(result.stdout);
    if (result.stderr.toString().isNotEmpty) {
      print('⚠️ ${result.stderr}');
    }
    
    // Clean up temp file
    if (tempGeneratorFile.existsSync()) {
      tempGeneratorFile.deleteSync();
    }
    
    exit(result.exitCode);
  } else {
    print('❌ Generator not found.');
    print('💡 Make sure flutter_environment_config is added to your project dependencies');
    exit(1);
  }
}

Future<String?> _findGenerator() async {
  // First try to find local path dependency
  final localPath = await _findLocalPathDependency();
  if (localPath != null) {
    return localPath;
  }
  
  // Get dependency info from pub deps
  final result = await Process.run('flutter', ['pub', 'deps', '--json']);
  if (result.exitCode != 0) return null;
  
  try {
    final depsJson = jsonDecode(result.stdout);
    final packages = depsJson['packages'] as List?;
    
    if (packages != null) {
      for (final package in packages) {
        if (package['name'] == 'flutter_environment_config') {
          final source = package['source'];
          final description = package['description'];
          
          switch (source) {
            case 'path':
              // Local path dependency
              final path = description['path'];
              return '$path/generator/generate_environment_config.dart';
              
            case 'git':
              // Git dependency - find in pub cache
              return await _findInGitCache();
              
            case 'hosted':
              // Hosted dependency - find in pub cache
              return await _findInHostedCache();
          }
        }
      }
    }
  } catch (e) {
    // Fallback to manual search
  }
  
  // Fallback: try all possible locations
  return await _findInGitCache() ?? await _findInHostedCache();
}

Future<String?> _findInGitCache() async {
  final pubCacheDir = _getPubCacheDirectory();
  if (pubCacheDir == null) return null;
  
  final gitDir = Directory('$pubCacheDir/git');
  if (!gitDir.existsSync()) return null;
  
  try {
    await for (final entity in gitDir.list()) {
      if (entity is Directory) {
        final dirName = entity.path.split(Platform.pathSeparator).last;
        if (dirName.startsWith('flutter_environment_config-')) {
          final generatorPath = '${entity.path}/generator/generate_environment_config.dart';
          if (File(generatorPath).existsSync()) {
            return generatorPath;
          }
        }
      }
    }
  } catch (e) {
    // Ignore
  }
  
  return null;
}

/// Get pub cache directory based on OS environment variables
/// See: https://dart.dev/tools/pub/environment-variables
String? _getPubCacheDirectory() {
  // 1. Check PUB_CACHE environment variable first
  final pubCache = Platform.environment['PUB_CACHE'];
  if (pubCache != null && pubCache.isNotEmpty) {
    print('🔍 Using PUB_CACHE: $pubCache');
    return pubCache;
  }
  
  // 2. Use OS-specific default locations
  if (Platform.isWindows) {
    print('🔍 Windows detected, checking LOCALAPPDATA/APPDATA...');
    // Windows: %LOCALAPPDATA%\Pub\Cache or %APPDATA%\Pub\Cache
    final localAppData = Platform.environment['LOCALAPPDATA'];
    if (localAppData != null) {
      final path = '$localAppData\\Pub\\Cache';
      print('🔍 Using LOCALAPPDATA: $path');
      return path;
    }
    final appData = Platform.environment['APPDATA'];
    if (appData != null) {
      final path = '$appData\\Pub\\Cache';
      print('🔍 Using APPDATA: $path');
      return path;
    }
  } else {
    print('🔍 macOS/Linux detected, using HOME/.pub-cache...');
    // macOS/Linux: ~/.pub-cache
    final home = Platform.environment['HOME'];
    if (home != null) {
      final path = '$home/.pub-cache';
      print('🔍 Using HOME: $path');
      return path;
    }
  }
  
  print('❌ No pub cache directory found');
  return null;
}

/// Find flutter_environment_config in local packages using path dependencies
Future<String?> _findLocalPathDependency() async {
  try {
    // Search for pubspec.yaml files in packages directory
    final packagesDir = Directory('packages');
    if (!await packagesDir.exists()) return null;
    
    await for (final entity in packagesDir.list()) {
      if (entity is Directory) {
        final pubspecFile = File('${entity.path}/pubspec.yaml');
        if (await pubspecFile.exists()) {
          try {
            final content = await pubspecFile.readAsString();
            if (content.contains('flutter_environment_config:') && 
                content.contains('path:')) {
              // Found a package with path dependency to flutter_environment_config
              // Extract the path
              final lines = content.split('\n');
              for (int i = 0; i < lines.length; i++) {
                if (lines[i].trim() == 'flutter_environment_config:') {
                  // Look for path in next few lines
                  for (int j = i + 1; j < lines.length && j < i + 5; j++) {
                    final line = lines[j].trim();
                    if (line.startsWith('path:')) {
                      final path = line.substring(5).trim();
                      return '$path/generator/generate_environment_config.dart';
                    }
                  }
                }
              }
            }
          } catch (e) {
            // Skip invalid files
            continue;
          }
        }
      }
    }
  } catch (e) {
    // Skip if packages directory doesn't exist
  }
  
  return null;
}

Future<String?> _findInHostedCache() async {
  final pubCacheDir = _getPubCacheDirectory();
  if (pubCacheDir == null) return null;
  
  // Try different hosted cache locations
  final hostedPaths = [
    '$pubCacheDir/hosted/pub.dev',
    '$pubCacheDir/hosted/pub.dartlang.org', // Legacy path
  ];
  
  for (final hostedPath in hostedPaths) {
    final hostedDir = Directory(hostedPath);
    if (!hostedDir.existsSync()) continue;
    
    try {
      await for (final entity in hostedDir.list()) {
        if (entity is Directory) {
          final dirName = entity.path.split(Platform.pathSeparator).last;
          if (dirName.startsWith('flutter_environment_config-')) {
            final generatorPath = '${entity.path}/generator/generate_environment_config.dart';
            if (File(generatorPath).existsSync()) {
              return generatorPath;
            }
          }
        }
      }
    } catch (e) {
      // Ignore and try next path
      continue;
    }
  }
  
  return null;
}
