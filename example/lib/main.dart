import 'package:flutter/material.dart';
import 'package:flutter_env_config/flutter_env_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterEnvConfig.loadEnvVariables();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final allValues = <Widget>[];
    FlutterEnvConfig.variables.forEach((k, v) {
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
                'Values of version: ${FlutterEnvConfig.get('APP_VERSION_NAME')}+${FlutterEnvConfig.get('APP_VERSION_BUILD')}',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
