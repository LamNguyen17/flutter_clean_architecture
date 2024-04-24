import UIKit
import Flutter

let DEVICE_INFO_CHANNEL = "com.example.flutter_clean_architecture/channel"
let FIRST_INSTALL_TIME = "first_install_time_method"
let APP_VERSION = "app_version_method"
let APP_NAME = "app_name_method"
let BUILD_NUMBER = "build_number_method"

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let flutterVC = window?.rootViewController as! FlutterViewController
        
        let cryptoChannel = FlutterMethodChannel(
            name: DEVICE_INFO_CHANNEL,
            binaryMessenger: flutterVC.binaryMessenger
        )
        cryptoChannel.setMethodCallHandler { call, result in
            switch (call.method) {
            case FIRST_INSTALL_TIME:
                    result(self.getFirstInstallTime())
            case APP_VERSION:
                    result(self.getAppVersion())
            case APP_NAME:
                    result(self.getAppName())
            case BUILD_NUMBER:
                    result(self.getBuildNumber())
            default: result(FlutterMethodNotImplemented)
            }
        }
        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    private func getBuildNumber() -> String {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String ?? "unknown"
    }
    
    private func getAppVersion() -> String {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? "unknown"
    }
    
    private func getAppName() -> String {
        let displayName = Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String
        let bundleName = Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String
        return displayName ?? bundleName ?? "unknown"
    }
    
    private func getFirstInstallTime() -> Int64 {
        let urlToDocumentsFolder = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last!
        do {
            let attributes = try FileManager.default.attributesOfItem(atPath: urlToDocumentsFolder.path)
            if let installDate = attributes[.creationDate] as? Date {
                return Int64(floor(installDate.timeIntervalSince1970 * 1000))
            }
        } catch {
            print("Error getting first install time: \(error)")
        }
        return 0
    }
}
