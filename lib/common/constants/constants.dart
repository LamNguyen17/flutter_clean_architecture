import 'package:flutter/services.dart';

const String channel = 'com.example.flutter_clean_architecture/channel';
const methodChannel = MethodChannel(channel);

/// Get First install time
/// Return   : a [String] when success or [PlatformException] when failed
/// Ex: methodChannel.invokeMethod(firstInstallTime); //
const String firstInstallTime = 'first_install_time_method';

/// Get App Version
/// Return   : a [String] when success or [PlatformException] when failed
/// Ex: methodChannel.invokeMethod(appVersion); // 1.0.0
const String appVersion = 'app_version_method';

/// Get App Name
/// Return   : a [String] when success or [PlatformException] when failed
/// Ex: methodChannel.invokeMethod(appName); // Flutter_clean_architecture
const String appName = 'app_name_method';

/// Get Build Number
/// Return   : a [String] when success or [PlatformException] when failed
/// Ex: methodChannel.invokeMethod(buildNumber); // 1
///
const String buildNumber = 'build_number_method';
