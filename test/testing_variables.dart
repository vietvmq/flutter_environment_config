import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_config_plus/flutter_config_plus.dart';

void main() {
  const MethodChannel channel = MethodChannel('flutter_config_plus');

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return {'FABRIC': 67};
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('get variable', () async {
    await FlutterConfigPlus.loadEnvVariables();
    expect(FlutterConfigPlus.get('FABRIC'), 67);
  });
}
