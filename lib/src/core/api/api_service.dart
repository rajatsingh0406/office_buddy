import 'package:dio/dio.dart';
import 'package:office_buddy/src/core/api/app_constant.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

const Map<String, dynamic> defaultHeader = {
  "content-type": "application/json",

};

class ApiService {
  final Dio _dio = Dio();

  ApiService() {
    _dio.options.baseUrl = AppConstant.baseUrl;
    _dio.options.headers = defaultHeader;
    _dio.options.connectTimeout = const Duration(seconds: 90);
    _dio.options.sendTimeout = const Duration(seconds: 90);
    _dio.options.receiveTimeout = const Duration(seconds: 90);
    // interseptor
    _dio.interceptors.add(PrettyDioLogger(
        requestBody: true,
        requestHeader: true,
        responseBody: true,
        responseHeader: true));
  }

  Dio get sendRequest => _dio;
}

class ApiResponse {
  bool success;
  dynamic data;
  String? message;

  ApiResponse({required this.success, this.data, this.message});

  factory ApiResponse.fromResponse(Response response){
    final responseData = response.data;
    return ApiResponse(
      success: true,
      data: responseData is List<dynamic> ? responseData : [responseData],
      message: "Success",
      );
  }
}
