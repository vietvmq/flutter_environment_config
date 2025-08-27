import 'package:flutter/material.dart';
import 'package:flutter_config_plus/flutter_config_plus.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterConfigPlus.loadEnvVariables();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final allValues = <Widget>[];
    FlutterConfigPlus.variables.forEach((k, v) {
      allValues.add(Text('$k: $v'));
    });
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            children: [
              ...allValues,
              const SizedBox(
                height: 20,
              ),
              Text(
                'Values of version: ${FlutterConfigPlus.get('APP_VERSION_NAME')}+${FlutterConfigPlus.get('APP_VERSION_BUILD')}',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
