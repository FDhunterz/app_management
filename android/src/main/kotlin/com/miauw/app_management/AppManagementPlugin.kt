package com.miauw.app_management

import androidx.annotation.NonNull
import android.app.Activity
import android.content.Context
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import com.miauw.app_management.ManageApp

/** AppManagementPlugin */
class AppManagementPlugin: FlutterPlugin, MethodCallHandler, ActivityAware {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel
  private lateinit var context: Context
  private lateinit var activity: Activity

  override fun onDetachedFromActivity() {
    // TODO("Not yet implemented")
}

override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    // TODO("Not yet implemented")
}

override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    activity = binding.activity;
}

override fun onDetachedFromActivityForConfigChanges() {
    // TODO("Not yet implemented")
}

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    context = flutterPluginBinding.applicationContext
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "app_management")
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    if (call.method == "getPlatformVersion") {
      result.success("Android ${android.os.Build.VERSION.RELEASE}")
    } else if(call.method == "getMemoryInfo") {
      result.success(jsonEncode(ManageApp().getMemory(context)))
    }else if(call.method == "getInstalledApp") {
      result.success(jsonEncode(ManageApp().getApp(context)))
    }else if(call.method == "killAll") {
      result.success(ManageApp().killAll(context))
    }else if(call.method == "runAppInPhone") {
      try{
        result.success(ManageApp().run(context, (call.arguments as ArrayList<*>).first() as String))
      }catch(e : Exception){
        result.error("0x0001","fatal",e.toString())
      }
    }else {
      result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}

fun jsonEncode(data : Any) : String {
  var string : String ="";
  if(data is Map<*, *>){
    string = "{"
    var count : Int = 0;
    for((k,v) in data){
      ++count;
      string += "\""+k+"\":\""+data[k]+"\""
      if(count < data.size){
          string += ","
      }
    }
    string += "}"

  }else if (data is Array<*>){
    string = "["
    var count : Int = 0;
    for(v in data){
      ++count
      if(v != null){
        string += jsonEncode(v as Any)
      }
      if(count  < data.size){
        string += ","
      }
    }
    string += "]"

  }

  return string;
}
