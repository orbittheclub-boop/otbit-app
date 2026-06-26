import Flutter
import UIKit

class SceneDelegate: FlutterSceneDelegate {
  // Under the UIScene lifecycle, iOS delivers URL-open callbacks to
  // scene:openURLContexts: — and Flutter only forwards those to plugins that
  // registered for *scene* life-cycle events. Plugins like google_sign_in and
  // flutter_web_auth_2 (TikTok) only hook the classic application:openURL:, so
  // their OAuth redirect callback is otherwise dropped and sign-in never
  // completes. Bridge each URL to the app delegate so those plugins receive it.
  override func scene(
    _ scene: UIScene,
    openURLContexts URLContexts: Set<UIOpenURLContext>
  ) {
    super.scene(scene, openURLContexts: URLContexts)
    if let delegate = UIApplication.shared.delegate {
      for context in URLContexts {
        _ = delegate.application?(
          UIApplication.shared, open: context.url, options: [:])
      }
    }
  }
}
