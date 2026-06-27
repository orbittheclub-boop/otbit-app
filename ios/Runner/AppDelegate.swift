import Flutter
import FirebaseMessaging
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate, FlutterImplicitEngineDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  func didInitializeImplicitFlutterEngine(_ engineBridge: FlutterImplicitEngineBridge) {
    GeneratedPluginRegistrant.register(with: engineBridge.pluginRegistry)
  }

  // Hand the APNs device token directly to Firebase Messaging. Under Flutter
  // 3.44's new implicit-engine / UIScene lifecycle, the automatic forwarding of
  // this callback to firebase_messaging doesn't fire, so getAPNSToken() stays
  // null and no FCM token is ever minted. Setting it explicitly fixes that.
  override func application(
    _ application: UIApplication,
    didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data
  ) {
    Messaging.messaging().apnsToken = deviceToken
    super.application(
      application, didRegisterForRemoteNotificationsWithDeviceToken: deviceToken)
  }

  override func application(
    _ application: UIApplication,
    didFailToRegisterForRemoteNotificationsWithError error: Error
  ) {
    NSLog("[orbit] APNs registration failed: \(error.localizedDescription)")
    super.application(
      application, didFailToRegisterForRemoteNotificationsWithError: error)
  }
}
