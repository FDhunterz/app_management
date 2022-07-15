import Flutter
import UIKit
import NotificationCenter

var channelssss : FlutterMethodChannel?  = nil

public class SwiftAppManagementPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    channelssss = FlutterMethodChannel(name: "app_management", binaryMessenger: registrar.messenger())
    let instance = SwiftAppManagementPlugin()
    registrar.addMethodCallDelegate(instance, channel: channelssss!)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    
    // if(call.method == "start_whatsapp_service"){
    //   NotificationCenter.default.addObserver(self, selector: #selector(DispatchQueue.main.async {SwiftAppManagementPlugin.updateNotif(_:)}), name: NSNotification.Name(rawValue: "com.whatsapp"), object: nil)
    //  return
    // }
    result(FlutterMethodNotImplemented)
  }

  @objc
  func updateNotif(_ notification: NSNotification){
      channelssss!.invokeMethod("whatsapp_message",arguments:notification.userInfo ?? notification.object  ?? "null Message")
  }
}
