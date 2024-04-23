package com.example.flutter_clean_architecture

import android.content.Context
import android.content.pm.PackageInfo
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private companion object {
        const val DEVICE_INFO_CHANNEL = "com.example.flutter_clean_architecture/channel"
        const val FIRST_INSTALL_TIME_METHOD = "first_install_time_method"
        const val VERSION_NAME_METHOD = "version_name_method"
        const val VERSION_CODE_METHOD = "version_code_method"
        const val APP_NAME_METHOD = "app_name_method"
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, DEVICE_INFO_CHANNEL).apply {
            setMethodCallHandler { call: MethodCall, result: MethodChannel.Result ->
                when (call.method) {
                    FIRST_INSTALL_TIME_METHOD -> result.success(getFirstInstallTime())
                    VERSION_NAME_METHOD -> result.success(getVersionName())
                    VERSION_CODE_METHOD -> result.success(getVersionCode())
                    APP_NAME_METHOD -> result.success(getAppName())
                    else -> result.notImplemented()
                }
            }
        }
    }

    private fun getPackageInfo(): PackageInfo {
        return applicationContext.packageManager.getPackageInfo(applicationContext.packageName, 0)
    }

    private fun getVersionName(): String {
        return getPackageInfo().versionName
    }

    private fun getVersionCode(): String {
        return getPackageInfo().versionCode.toString()
    }

    private fun getAppName(): String {
        return applicationContext.applicationInfo.loadLabel(applicationContext.packageManager).toString()
    }

    private fun getFirstInstallTime(): Double {
        return getPackageInfo().firstInstallTime.toDouble()
    }
}
