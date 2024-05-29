import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_logs_firebase_timber/flutter_logs_firebase_timber.dart';
import 'package:flutter_logs_firebase_timber/remote/logs_tree.dart';

void main() async {
  // Ensure that the Flutter framework is initialized
  WidgetsFlutterBinding.ensureInitialized();
  //Initialze the package only for debug mode
  if (kDebugMode) {
    await FlutterLogsFirebaseTimber.initialize();
  }
  runApp(const Example());
}

class Example extends StatelessWidget {
  const Example({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter logs firebase timber example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () => {
            // Log a message using FlutterLogsFirebaseTimber
            FlutterLogsFirebaseTimber.log(
                logLevel: LogLevel.info,
                tag: "onPressed()",
                message: "This is a log message",
                error: null)
          },
          child: const Text('Click me'),
        ),
      ),
    );
  }
}
