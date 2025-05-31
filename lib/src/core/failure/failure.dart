import 'dart:io';
import 'package:dio/dio.dart';

class Failure {
  //––– Predefined failures –––
  static const Failure requestCancelled = Failure._('Request Cancelled');
  static const Failure unauthorisedRequest = Failure._('Unauthorised Request');
  static const Failure badRequest = Failure._('Bad Request');
  static const Failure badCertificate = Failure._('Bad Certificate');
  static const Failure unknown = Failure._('Unknown Error Occurred');
  static const Failure methodNotAllowed = Failure._('Method Not Allowed');
  static const Failure notAcceptable = Failure._('Not Acceptable');
  static const Failure requestTimeout = Failure._('Request Timeout');
  static const Failure sendTimeout = Failure._('Send Timeout');
  static const Failure connectTimeout = Failure._('Connect Timeout');
  static const Failure conflict = Failure._('Error due to a Conflict');
  static const Failure internalServerError = Failure._('Internal Server Error');
  static const Failure notImplemented = Failure._('Not Implemented');
  static const Failure serviceUnavailable = Failure._('Service Unavailable');
  static const Failure noInternetConnection =
      Failure._('No Internet Connection');
  static const Failure formatException = Failure._('Format Exception');
  static const Failure unableToProcess = Failure._('Unable to Process');
  static const Failure unexpectedError = Failure._('Unexpected Error');
  static const Failure invalidCredentials = Failure._('Invalid Credentials');
  static const Failure permissionDenied = Failure._('Permission Denied');
  static const Failure accountLocked = Failure._('Account Locked');
  static const Failure notFound = Failure._('Not Found');

  //––– Factory for custom backend messages –––
  static Failure customError(String message) => Failure._(message);

  const Failure._(this.errorMessage);
  final String errorMessage;

  /// Inspect a DioException (or Socket/Format/Arg errors) and return a Failure.
  static Failure getDioException(Object error) {
    if (error is DioException) {
      // 1) Handle HTTP 4xx/5xx first by looking for a JSON “error” field:
      if (error.type == DioExceptionType.badResponse) {
        final resp = error.response;
        if (resp != null && resp.data is Map<String, dynamic>) {
          final body = resp.data as Map<String, dynamic>;
          if (body['error'] is String) {
            return customError(body['error'] as String);
          }
        }
        // 2) Fallback to status‐code mapping:
        switch (resp?.statusCode) {
          case 400:
            return badRequest;
          case 401:
          case 403:
            return unauthorisedRequest;
          case 404:
            return notFound;
          case 408:
            return requestTimeout;
          case 409:
            return conflict;
          case 500:
            return internalServerError;
          case 503:
            return serviceUnavailable;
          default:
            final code = resp?.statusCode ?? -1;
            return customError('Received invalid status code: $code');
        }
      }

      // 3) Other Dio-related errors:
      switch (error.type) {
        case DioExceptionType.cancel:
          return requestCancelled;
        case DioExceptionType.connectionTimeout:
          return requestTimeout;
        case DioExceptionType.receiveTimeout:
          return sendTimeout;
        case DioExceptionType.sendTimeout:
          return sendTimeout;
        case DioExceptionType.connectionError:
          return noInternetConnection;
        case DioExceptionType.badCertificate:
          return badCertificate;
        case DioExceptionType.unknown:
          return unknown;
        // badResponse is already handled above
        case DioExceptionType.badResponse:
          // TODO: Handle this case.
          throw UnimplementedError();
      }
    }

    // 4) Non-Dio exceptions:
    if (error is SocketException) return connectTimeout;
    if (error is FormatException) return formatException;
    if (error is ArgumentError) {
      return error.toString().contains('is not a subtype of')
          ? unableToProcess
          : unexpectedError;
    }

    // 5) Last resort:
    return unexpectedError;
  }

  /// Convenience for throwing from a raw Response
  static Failure fromResponse(Response<dynamic> response) {
    return getDioException(DioException.badResponse(
      requestOptions: response.requestOptions,
      response: response,
      statusCode: response.statusCode!,
    ));
  }

  @override
  String toString() => errorMessage;
}
