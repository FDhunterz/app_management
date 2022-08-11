import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'memory.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with TickerProviderStateMixin {
  String _platformVersion = 'Unknown';
  AnimationController? a;
  Animation? aa;
  @override
  void initState() {
    a = AnimationController(vsync: this, duration: Duration(seconds: 5));
    aa = Tween(begin: 0.0, end: 2.0).animate(a!
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          a!.reverse();
        } else if (status == AnimationStatus.dismissed) {
          a!.forward();
        }
      }));
    a!.forward();

    super.initState();
    initPlatformState();
    Future.delayed(Duration.zero, () {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
        ),
      );
      // Clipboard.setData(ClipboardData(text: json.encode({"testing": "test"})));
    });
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {} catch (_) {
      print(_);
      platformVersion = 'Failed to get Memory Info.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {});
  }

  Offset pointer = Offset(0, 0);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MemmoryUI(),
    );
  }
}
