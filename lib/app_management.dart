import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';

import 'model/service.dart';

class AppManagement {
  static const MethodChannel _channel = MethodChannel('app_management');

  static Future<String?> get platformVersion async {
    if (!Platform.isAndroid) {
      print('not Supported');
      return null;
    }
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<Memory?> get memoryInfo async {
    if (!Platform.isAndroid) {
      print('not Supported');
      return null;
    }
    final String? mem = await _channel.invokeMethod('getMemoryInfo');
    final parse = json.decode(mem!);
    return Memory(
      available: int.parse(parse["available_mem"]),
      percentage: double.parse(parse["percentage_mem"]),
      total: int.parse(parse["total_mem"]),
    );
  }

  static Future<String?> get killAllApp async {
    if (!Platform.isAndroid) {
      print('not Supported');
      return null;
    }
    return await _channel.invokeMethod('killAll');
  }

  static Future<String?> runInstalledApp(String packageName) async {
    if (!Platform.isAndroid) {
      print('not Supported');
      return null;
    }
    return await _channel.invokeMethod('runAppInPhone', [packageName]);
  }

  static Future<Speed?> getNetworkBandwith() async {
    if (!Platform.isAndroid) {
      print('not Supported');
      return null;
    }
    final mem = await _channel.invokeMethod('getNetworkBandwith');
    final parse = json.decode(mem!);
    return Speed(
      upload: double.parse(parse['up']),
      download: double.parse(parse['down']),
    );
  }

  static Future<List<App>?> getInstalledApps() async {
    if (!Platform.isAndroid) {
      print('not Supported');
      return null;
    }
    final String getApp = await _channel.invokeMethod('getInstalledApp');
    final parseApp = json.decode(getApp);
    List<App> app = [];
    for (var i in parseApp) {
      app.add(App(name: i['name'], packageName: i['package']));
    }
    return app;
  }

  StreamController stream = StreamController();

  Stream startWhatsappService() {
    _channel.invokeMethod('start_whatsapp_service');
    _channel.setMethodCallHandler((call) async {
      if (call.method == 'whatsapp_message') {
        stream.add(call.arguments);
      } else {}
    });
    return stream.stream;
  }
}
