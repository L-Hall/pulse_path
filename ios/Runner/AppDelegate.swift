import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    
    // Register Liquid Glass plugin
    guard let controller = window?.rootViewController as? FlutterViewController else {
      fatalError("rootViewController is not type FlutterViewController")
    }
    LiquidGlassPlugin.register(with: registrar(forPlugin: "LiquidGlassPlugin")!)
    
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
