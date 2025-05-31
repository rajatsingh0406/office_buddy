import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'app_constant.dart';

class ApiProvider {
  ApiProvider._();

  static final Dio _dio = Dio(
    BaseOptions(
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
      connectTimeout: const Duration(seconds: 90),
      sendTimeout: const Duration(seconds: 90),
      receiveTimeout: const Duration(seconds: 90),
      baseUrl: AppConstant.baseUrl,
    ),
  );

  static Dio getDio({String? baseUrl}) {
    // Set dynamic base URL if provided
    if (baseUrl != null) {
      _dio.options.baseUrl = baseUrl;
    }

    // Prevent adding PrettyDioLogger multiple times
    if (kDebugMode && !_dio.interceptors.any((i) => i is PrettyDioLogger)) {
      _dio.interceptors.add(
        PrettyDioLogger(
            requestBody: false,
            request: true,
            requestHeader: false,
            responseHeader: false,
            responseBody: false),
      );
    }
    return _dio;
  }
}
