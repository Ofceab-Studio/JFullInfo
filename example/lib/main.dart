import 'package:flutter/material.dart';
import 'package:jfullinfo/jFullInfo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _state = 'Unknown';
  final _jFullInfo = JFullInfo();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('JInfoPlugin Example'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Text(_state),
          ),
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              child: const Icon(Icons.android),
              onPressed: () async {
                final val = await _jFullInfo.getAndroidInformation();
                debugPrint(val.toString());
                setState(() {
                  _state = val.toString();
                });
              },
            ),
            FloatingActionButton(
              child: const Icon(Icons.device_unknown),
              onPressed: () async {
                final val = await _jFullInfo.getHardwareInformation();
                debugPrint(val.toString());
                setState(() {
                  _state = val.toString();
                });
              },
            ),
            FloatingActionButton(
              child: const Icon(Icons.sim_card),
              onPressed: () async {
                final val = await _jFullInfo.getSimInformation();
                for (var i in val) {
                  debugPrint(i.toString());
                }
                setState(() {
                  _state = val.first.toString();
                });
              },
            ),
            FloatingActionButton(
              child: const Icon(Icons.app_shortcut),
              onPressed: () async {
                final val = await _jFullInfo.getApplicationInformation();
                debugPrint(val.toString());
                setState(() {
                  _state = val.toString();
                });
              },
            ),
            FloatingActionButton(
              child: const Icon(Icons.all_inclusive),
              onPressed: () async {
                final val = await _jFullInfo.getAllInformation();
                debugPrint(val.toString());
                setState(() {
                  _state = val.toString();
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
