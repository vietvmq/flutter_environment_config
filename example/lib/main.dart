import 'package:flutter/material.dart';
import 'package:flutter_environment_config/flutter_environment_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterEnvironmentConfig.loadEnvVariables();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final data = FlutterEnvironmentConfig.variables.entries.toList()
      ..sort((a, b) => a.key.compareTo(b.key));
    return MaterialApp(
      title: 'Flutter Environment Config',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Environment Config'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            spacing: 16,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.zero,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minWidth: MediaQuery.of(context).size.width - 32,
                      ),
                      child: DataTable(
                        columnSpacing: 16,
                        headingRowHeight: 50,
                        dataRowMinHeight: 50,
                        dataRowMaxHeight: 50,
                        columns: const [
                          DataColumn(
                            label: Expanded(
                              child: Text(
                                'Key',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Expanded(
                              child: Text(
                                'Value',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                        rows: data.map(
                          (e) {
                            return DataRow(
                              cells: [
                                DataCell(
                                  Text(
                                    e.key,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                DataCell(
                                  Text(
                                    e.value ?? '',
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 3,
                                  ),
                                ),
                              ],
                            );
                          },
                        ).toList(),
                      ),
                    ),
                  ),
                ),
              ),
              Card(
                color: const Color(0xFFE3F2FD),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '💡 Code Generation',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16),
                      RichText(
                        text: TextSpan(
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                          ),
                          children: [
                            const TextSpan(text: 'Run\n'),
                            TextSpan(
                              text:
                                  'dart run flutter_environment_config:generate',
                              style: TextStyle(
                                fontFamily: 'monospace',
                                fontWeight: FontWeight.bold,
                                color: Colors.blue.shade800,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      RichText(
                        text: TextSpan(
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                          ),
                          children: [
                            const TextSpan(text: 'Use\n'),
                            TextSpan(
                              text:
                                  'FlutterEnvironmentConfigGeneration.property',
                              style: TextStyle(
                                fontFamily: 'monospace',
                                fontWeight: FontWeight.bold,
                                color: Colors.green.shade700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
