
import 'package:dio/dio.dart';

import '../network/network_info.dart';
import '../utils/enums.dart';
import '../utils/logger.dart';
import '../utils/shared_preference.dart';
import 'api_log_interceptor.dart';
import 'app_constant.dart';

class ApiCalling {
  late Dio _dio;
  final NetworkInfo _networkInfo = NetworkInfo();

  Future<CustomResponse> callApi(
      {required ApiTypes apiTypes,
        required String url,
        String? referer,
        Object? data,
        String? token,
        Map<String, String?>? optionalHeader,
        ResponseType? responseType}) async {
    final bool isConnected = await _networkInfo.isConnected();
    final sessionId = await PrefManager.getUserSessionId();
    final csrf = await PrefManager.getUserCsrfToken();
    if (!isConnected) {
      return CustomResponse(error: CustomException.noInternet.message);
    }

    try {
      Response<dynamic> response;
      _initDio(token: token, responseType: responseType, optionalHeader: {
        'Cookie': 'sessionid=$sessionId;csrftoken=$csrf',
        'X-CSRFToken': csrf,
        'Referer': referer
      });
      switch (apiTypes) {
        case ApiTypes.get:
          response = await _dio.get(url);
          break;
        case ApiTypes.post:
          response = await _dio.post(url, data: data);
          break;
        case ApiTypes.patch:
          response = await _dio.patch(url, data: data);
          break;
        case ApiTypes.delete:
          response = await _dio.delete(url, data: data);
          break;
      }
      return CustomResponse(
          response: response, statusCode: response.statusCode);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError ||
          e.response?.statusCode == 500) {
        return CustomResponse(
            error: CustomException.serverError.message,
            statusCode: e.response?.statusCode);
      }
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.sendTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        return CustomResponse(
            error: CustomException.timeOutError.message,
            statusCode: e.response?.statusCode);
      }
      if (e.response != null) {
        return CustomResponse(
            response: e.response, statusCode: e.response?.statusCode);
      } else {
        return CustomResponse();
      }
    }
  }

  void _initDio(
      {required String? token,
        required Map<String, String?>? optionalHeader,
        required ResponseType? responseType}) {
    // String? authorization;
    // authorization = token;
    late Map<String, String?> header;
    if (optionalHeader != null) {
      header = optionalHeader;
    }
    final BaseOptions options = BaseOptions(
        baseUrl: AppConstant.baseUrl,
        receiveTimeout: const Duration(seconds: 100),
        connectTimeout: const Duration(seconds: 100),
        headers: header,
        responseType: responseType ?? ResponseType.json);
    _dio = Dio(options);
    if (Logger.mode == LogMode.debug) {
      _dio.interceptors.add(LoggerInterceptor());
    }
  }
}

class CustomResponse {
  CustomResponse(
      {this.response, this.statusCode, this.error = 'Something Went Wrong'});

  final Response<dynamic>? response;
  final int? statusCode;
  String error;

  static fromJson(data) {}
}
