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
  // Get dependency info
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
  final home = Platform.environment['HOME'];
  if (home == null) return null;
  
  final gitDir = Directory('$home/.pub-cache/git');
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

Future<String?> _findInHostedCache() async {
  final home = Platform.environment['HOME'];
  if (home == null) return null;
  
  final hostedDir = Directory('$home/.pub-cache/hosted/pub.dev');
  if (!hostedDir.existsSync()) return null;
  
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
    // Ignore
  }
  
  return null;
}
