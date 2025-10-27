import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_environment_config/flutter_environment_config.dart';

void main() {
  const MethodChannel channel = MethodChannel('flutter_environment_config');

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return {'FABRIC': 67};
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('get variable', () async {
    await FlutterEnvironmentConfig.loadEnvVariables();
    expect(FlutterEnvironmentConfig.get('FABRIC'), 67);
  });
}
