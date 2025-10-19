import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_env_config/flutter_env_config.dart';

void main() {
  const MethodChannel channel = MethodChannel('flutter_env_config');

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return {'FABRIC': 67};
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('get variable', () async {
    await FlutterEnvConfig.loadEnvVariables();
    expect(FlutterEnvConfig.get('FABRIC'), 67);
  });
}