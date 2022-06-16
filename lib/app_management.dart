import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';

import 'model/service.dart';

class AppManagement {
  static const MethodChannel _channel = MethodChannel('app_management');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<Memory> get memoryInfo async {
    final String? mem = await _channel.invokeMethod('getMemoryInfo');
    final parse = json.decode(mem!);
    return Memory(
      available: int.parse(parse["available_mem"]),
      percentage: double.parse(parse["percentage_mem"]),
      total: int.parse(parse["total_mem"]),
    );
  }

  static Future<String> get killAllApp async {
    return await _channel.invokeMethod('killAll');
  }

  static Future<String> runInstalledApp(String packageName) async {
    return await _channel.invokeMethod('runAppInPhone', [packageName]);
  }

  static Future<List<App>> getInstalledApps() async {
    final String getApp = await _channel.invokeMethod('getInstalledApp');
    final parseApp = json.decode(getApp);
    List<App> app = [];
    for (var i in parseApp) {
      app.add(App(name: i['name'], packageName: i['package']));
    }
    return app;
  }
}
