import 'package:dio/dio.dart';

import 'package:flutter_clean_architecture/common/helper/flavor_config.dart';

class RestApiGateway {
  var dio = Dio();
  static String baseUrl = FlavorConfig.instance.values.baseUrl;

  RestApiGateway() {
    dio.options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 3),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );
    dio.interceptors.add(InterceptorsWrapper(onRequest:
        (RequestOptions requestOptions, RequestInterceptorHandler handler) async {
      handler.next(requestOptions);
    }, onError: (DioError err, ErrorInterceptorHandler handler) async {
      print("Refreshing_Token: ${err.response?.statusCode}");
      if (err.response?.statusCode == 401) {
        handler.reject(err);
      } else {
        handler.reject(err);
      }
    }));
  }
}