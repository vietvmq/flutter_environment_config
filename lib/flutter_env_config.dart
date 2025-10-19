import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

/// Flutter env config writes environment variables to `BuildConfig` class for android
/// and as a `NSDictionary` for iOS
class FlutterEnvConfig {
  /// An instance of all environment variables
  late Map<String, dynamic> _variables;

  // Private Constructor
  FlutterEnvConfig._internal();

  // Instance of FlutterEnvConfig
  static final FlutterEnvConfig _instance = FlutterEnvConfig._internal();

  static const MethodChannel _channel = MethodChannel('flutter_env_config');

  /// Variables need to be loaded on app startup, recommend to do it `main.dart`
  static loadEnvVariables() async {
    final Map<String, dynamic>? loadedVariables =
        await _channel.invokeMapMethod('loadEnvVariables');
    _instance._variables = loadedVariables ?? {};
  }

  /// Returns a specific variable value give a [key]
  static dynamic get(String key) {
    var variables = _instance._variables;

    if (variables.isEmpty) {
      print(
        'FlutterEnvConfig Variables are Empty\n'
        'Ensure you have a .env file and you\n'
        'have loaded the variables',
      );
    } else if (variables.containsKey(key)) {
      return variables[key];
    } else {
      print(
        'FlutterEnvConfig Value for Key($key) not found\n'
        'Ensure you have it in .env file',
      );
    }
  }

  /// returns all the current loaded variables;
  static Map<String, dynamic> get variables {
    return Map<String, dynamic>.of(_instance._variables);
  }

  @visibleForTesting
  static loadValueForTesting(Map<String, dynamic> values) {
    _instance._variables = values;
  }
}
