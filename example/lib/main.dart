import 'package:flutter/material.dart';
import 'dart:async';
import 'package:app_management/app_management.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
    Future.delayed(Duration.zero, () {
      // Clipboard.setData(ClipboardData(text: json.encode({"testing": "test"})));
    });
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      final app = await AppManagement.getInstalledApps();
      platformVersion = app.first.name ?? ''; //(await AppManagement.runInstalledApp(app[1].packageName!)).toString();
    } catch (_) {
      print(_);
      platformVersion = 'Failed to get Memory Info.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('click to Run Apps'),
        ),
        body: InkWell(
          onTap: () async {
            final app = await AppManagement.getInstalledApps();
            AppManagement.runInstalledApp(app.first.packageName ?? '');
          },
          child: Center(
            child: Text('Running on: $_platformVersion\n'),
          ),
        ),
      ),
    );
  }
}
