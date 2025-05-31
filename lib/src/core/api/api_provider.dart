// import 'package:dio/dio.dart';
// import 'package:flutter/foundation.dart';
// import 'package:pmg/src/core/app_constant.dart';
// import 'package:pretty_dio_logger/pretty_dio_logger.dart';

// class ApiProvider {
//   static final Dio _dio = Dio(BaseOptions(
//       contentType: 'application/json',
//       // headers: {
//       //   'Content-Type': 'application/json',
//       // },
//       connectTimeout: const Duration(seconds: 90),
//       sendTimeout: const Duration(seconds: 90),
//       receiveTimeout: const Duration(seconds: 90),
//       baseUrl: AppConstant.baseUrl));

//   static Dio getDio({String? baseUrl}) {
//     if (baseUrl != null) {
//       _dio.options.baseUrl = baseUrl;
//     }

//     // Prevent adding PrettyDioLogger multiple times
//     if (kDebugMode && !_dio.interceptors.any((i) => i is PrettyDioLogger)) {
//       _dio.interceptors.add(
//         PrettyDioLogger(
//             requestBody: false,
//             request: true,
//             requestHeader: true,
//             responseHeader: false,
//             responseBody: false),
//       );
//     }
//     return _dio;
//   }
// }

// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:office_buddy/src/core/utils/shared_preference.dart';

class ApiProvider {
  static final Dio _dio = Dio(BaseOptions(
    headers: {
      'Cache-Control': 'no-cache',
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    },
    connectTimeout: const Duration(seconds: 90),
    sendTimeout: const Duration(seconds: 90),
    receiveTimeout: const Duration(seconds: 90),
  ));

  static String? _accessToken;

  static void setAccessToken(String token) {
    debugPrint('token in api provider ---$token');
    _accessToken = token;
  }

  static Dio getDio() {
    debugPrint('token in api ---$_accessToken');
    _dio.interceptors.clear(); // Clear to avoid duplicate interceptors

    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        // final isLogin = options.path.contains("/login");
        final isLoggedIn = await PrefManager.getLoggedInStatus();

        if (isLoggedIn && _accessToken != null && _accessToken!.isNotEmpty) {
          options.headers['Authorization'] = 'Bearer $_accessToken';
        }

        return handler.next(options);
      },
      onError: (e, handler) => handler.next(e),
      onResponse: (e, handler) => handler.next(e),
    ));

    if (kDebugMode) {
      _dio.interceptors.add(
        LogInterceptor(
          requestBody: true,
          responseBody: false,
        ),
      );
    }

    return _dio;
  }
}

// class ApiProvider {
//   static final Dio _dio = Dio(BaseOptions(
//     headers: {
//       'Cache-Control': 'no-cache',
//       'Accept': 'application/json',
//       'Content-Type': 'application/json',
//     },
//     // Added timeout related errors handling on ui
//     connectTimeout: const Duration(seconds: 90),
//     sendTimeout: const Duration(seconds: 90),
//     receiveTimeout: const Duration(seconds: 90),
//   ));

//   static Dio getDio() {
//     //to add interceptor
//     _dio.interceptors.add(InterceptorsWrapper(
//       onRequest: (options, handler) {
//         String basicAuth =
//             'Basic YXBwOjZGREZTRlMzQlBCUEJQNEJRQlFCUTlDQkNCQ0I2QlNCU0JTM0JQQlBCUDRCUUJRQlE5Q0JDQkNC';

//         options.headers['Authorization'] = basicAuth;
//         // options.headers['Rbac-Application'] = 'WorkspaceNative';
//         return handler.next(options);
//       },
//       onError: (e, handler) => handler.next(e),
//       onResponse: (e, handler) => handler.next(e) //continue with the response
//       ,
//     ));
//     if (kDebugMode) {
//       _dio.interceptors.add(
//         LogInterceptor(
//           requestBody: true, //to print resquest body
//           responseBody: false, //to print response body
//         ),
//       );
//     }
//     return _dio;
//   }
// }
