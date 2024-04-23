import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    private let DEVICE_INFO_CHANNEL = "com.example.flutter_clean_architecture/channel"
    private let FIRST_INSTALL_TIME_METHOD = "first_install_time_method"
    private let VERSION_NAME_METHOD = "version_name_method"
    private let VERSION_CODE_METHOD = "version_code_method"
    private let APP_NAME_METHOD = "app_name_method"
    
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        GeneratedPluginRegistrant.register(with: self)
        let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
        let platformChannel = FlutterMethodChannel(name: DEVICE_INFO_CHANNEL,
                                                   binaryMessenger: controller.binaryMessenger)
        platformChannel.setMethodCallHandler({
            (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
            
            if (call.method == FIRST_INSTALL_TIME_METHOD) {
                result(self?.getFirstInstallTime())
            } else if (call.method == VERSION_NAME_METHOD) {
                result(self?.getVersionName())
            } else if (call.method == VERSION_CODE_METHOD) {
                result(self?.getVersionCode())
            } else if (call.method == APP_NAME_METHOD) {
                result(self?.getAppName())
            } else {
                result(FlutterMethodNotImplemented)
            }
            
            //            switch (call.method) {
            //            case FIRST_INSTALL_TIME_METHOD:
            //                result(self?.getFirstInstallTime())
            //            case VERSION_NAME_METHOD:
            //                result(self?.getVersionName())
            //            case VERSION_CODE_METHOD:
            //                result(self?.getVersionCode())
            //            case APP_NAME_METHOD:
            //                result(self?.getAppName())
            //            default:
            //                result(FlutterMethodNotImplemented)
            //            }
        })
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    private func getVersionName() -> String {
        let currentDevice = UIDevice.current
        return currentDevice.systemName ?? "unknown"
    }
    
    private func getVersionCode() -> String {
        let currentDevice = UIDevice.current
        return currentDevice.systemVersion ?? "unknown"
    }
    
    private func getAppName() -> String {
        let displayName = Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String
        let bundleName = Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String
        return displayName ?? bundleName ?? "unknown"
    }
    
    private func getFirstInstallTime() -> String {
        return "123"
        //         let urlToDocumentsFolder = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last
        //         var installDate: Date?
        //         do {
        //             installDate = try FileManager.default.attributesOfItem(atPath: urlToDocumentsFolder?.path ?? "")[.creationDate] as? Date
        //         } catch {
        //         }
        //         return NSNumber(value: floor(installDate?.timeIntervalSince1970 * 1000)).int64Value
    }
}
