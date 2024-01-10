import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './platformdata.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Platform Code Demo Part 3',
      debugShowCheckedModeBanner: false,     // Don't show Debug string on Android App in debug mode.
      theme: ThemeData(
        // This is the theme of your application.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Platform Tutorial Part 3'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Get battery level error string if no result.
  String _batteryLevel = 'Unknown battery level.';

  // Get computation result error string if no result.
  String _computationResult = 'Unknown computation result.';

  Future<String> makeBatteryLevelCall() async {
    String batteryLevel = await PlatformData.getBatteryLevel();

    setState(() {
      _batteryLevel = batteryLevel;
    });
    return batteryLevel;
  }

  Future<String> makeComputationCall(int x, int y) async {
    String computationResult = await PlatformData.getComputationResult(x,y);

    setState(() {
      _computationResult = computationResult;
    });
    return computationResult;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () => makeBatteryLevelCall(),
              child: const Text('Get Battery Level'),
            ),
            Text(_batteryLevel),
            ElevatedButton(
                onPressed: () => makeComputationCall(4, 11),
                child: const Text('Get Computation Result')),
            Text(_computationResult),
          ],
        ),
      ),
    );
  }
}
