import 'package:autilab_project/core/network/shared_preferences.dart';
import 'package:dio/dio.dart';

class BaseUrl {
  // Define a static constant for the base URL of your API
  // static const String baseUrl = 'https://api.autilab.com/api';
  static const String baseUrl = 'https://a04f578bdc3b.ngrok-free.app/api/';
}

class DioProvider {
  static Dio dioProvider() {
    final dio = Dio(
      BaseOptions(
        baseUrl: BaseUrl.baseUrl,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${SharedPreferencesData.getUserToken()}',
        },
      ),
    );
    return dio;
  }
}
