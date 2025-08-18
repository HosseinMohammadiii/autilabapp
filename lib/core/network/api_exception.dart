import 'package:dio/dio.dart';

class ApiException {
  int statusCode;
  String message;
  DioExceptionType? type;
  ApiException({required this.statusCode, required this.message, this.type}) {
    switch (statusCode) {
      case 0:
        message = 'connectionError';
        type = DioExceptionType.connectionError;
        break;
      default:
    }
  }
}
