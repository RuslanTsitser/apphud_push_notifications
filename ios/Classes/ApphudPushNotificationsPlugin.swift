import Flutter
import UIKit

public class ApphudPushNotificationsPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "apphud_push_notifications", binaryMessenger: registrar.messenger())
    let instance = ApphudPushNotificationsPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
    registrar.addApplicationDelegate(instance)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "registerForPushNotifications":
      ApphudPushNotificationsPlugin.registerForPushNotifications()
      result(nil)
    case "getApnsToken":
      result(ApphudPushNotificationsPlugin.apnsToken)
    default:
      result(FlutterMethodNotImplemented)
    }
  }
}
