import 'package:autilab_project/core/network/dio_provider.dart';
import 'package:autilab_project/core/network/shared_preferences.dart';
import 'package:dio/dio.dart';

class TokenInterceptor extends QueuedInterceptorsWrapper {
  final Dio _dio;

  TokenInterceptor(this._dio);

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    // توکن را از حافظه بخوان
    final String? accessToken = await SharedPreferencesData.getUserToken();

    if (accessToken != null) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }
    // درخواست را ادامه بده
    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // فقط در صورتی که خطای 401 (Unauthorized) باشد، منطق را اجرا کن
    if (err.response?.statusCode == 401) {
      try {
        print('Access Token has expired, trying to refresh...');

        // درخواست بازآوری توکن را ارسال کن
        final newAccessToken = await _refreshToken();

        // توکن جدید را ذخیره کن
        await SharedPreferencesData.saveUserToken(newAccessToken);

        print('Token refreshed successfully!');

        // درخواستی که خطا داده بود را با توکن جدید دوباره امتحان کن
        final response =
            await _retryRequest(err.requestOptions, newAccessToken);

        // نتیجه درخواست موفق را برگردان
        return handler.resolve(response);
      } on DioException catch (e) {
        // اگر بازآوری توکن هم خطا داد، کاربر را خارج کن
        print('Failed to refresh token: ${e.message}');
        // اینجا باید منطق خروج کاربر (logout) را پیاده کنید
        // مثلا پاک کردن توکن‌ها و هدایت به صفحه لاگین
        // await SharedPreferencesData.clearAll();
        return handler.reject(err); // خطای اصلی را برگردان
      }
    }

    // اگر خطا 401 نبود، فقط آن را برگردان
    return handler.next(err);
  }

  Future<String> _refreshToken() async {
    // برای جلوگیری از حلقه بی‌نهایت (infinite loop)، از یک نمونه Dio جدید استفاده کن
    final dioRefresh = Dio();
    final refreshToken = await SharedPreferencesData.getUserToken();

    final response = await dioRefresh.post(
      '${BaseUrl.baseUrl}/api/token/refresh', // <-- آدرس اندپوینت بازآوری توکن
      data: {'refreshToken': refreshToken},
    );

    if (response.statusCode == 200) {
      // فرض می‌کنیم سرور توکن جدید را در این فیلد برمی‌گرداند
      return response.data['accessToken'];
    } else {
      throw DioException(
          requestOptions: response.requestOptions,
          message: 'Refresh token failed');
    }
  }

  Future<Response> _retryRequest(
      RequestOptions requestOptions, String newAccessToken) {
    // یک نمونه جدید از آپشن‌های درخواست بساز
    final options = Options(
      method: requestOptions.method,
      headers: {
        ...requestOptions.headers,
        'Authorization':
            'Bearer $newAccessToken', // هدر را با توکن جدید آپدیت کن
      },
    );

    // درخواست را با داده‌ها و پارامترهای اصلی دوباره ارسال کن
    return _dio.request<dynamic>(
      requestOptions.path,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
      options: options,
    );
  }
}
