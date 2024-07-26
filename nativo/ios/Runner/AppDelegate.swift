import Flutter
import UIKit

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {

		let controller : FlutterViewController = window?.rooViewController as! FlutterViewController
		let channel = FlutterMethodChannel(name: "jordy.com.br/native", 
			binaryMessenger: controller.binaryMessenger)

		channel.setMethodcallHandler({
			(call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in 

			guard call.method == "calcSum" else {
				result(FlutterMethodNotImplemented)
				return
			}
			if let args = call.arguments as? [String: any],
				let a = args["a"] as? Int,
				let b = args["b"] as? Int {
					result(a + b)
				} else {
					result(-1)
				}
		})

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
