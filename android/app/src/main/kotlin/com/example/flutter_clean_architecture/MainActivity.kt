package com.example.flutter_clean_architecture

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private companion object {
        const val DEVICE_INFO_CHANNEL = "com.example.flutter_clean_architecture/channel"
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, DEVICE_INFO_CHANNEL).apply {
            setMethodCallHandler { call: MethodCall, result: MethodChannel.Result ->
                when (call.method) {
                    "getDataFromNative" -> getDataFromNative(result)
                    else -> result.notImplemented()
                }
            }
        }
    }

    private fun getDataFromNative(result: MethodChannel.Result) {
        // Perform platform-specific operations to fetch the data
        return result.success("Data from Native")
    }
}
