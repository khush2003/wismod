import UIKit
import Flutter

import flutter_local_notifications

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {

    FlutterLocalNotificationsPlugin.setPluginRegisrantCallback { 
      (registry) in GeneratedPluginRegistrant.register(with: registry)
      }

    GeneratedPluginRegistrant.register(with: self)

      if #avaible(iOS 10.0, *){
        UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenter
      }

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
