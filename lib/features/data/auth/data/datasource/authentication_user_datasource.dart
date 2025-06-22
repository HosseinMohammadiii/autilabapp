import 'package:autilab_project/core/network/api_exception.dart';
import 'package:autilab_project/core/network/shared_preferences.dart';
import 'package:autilab_project/features/data/auth/data/model/user_model.dart';
import 'package:dio/dio.dart';

abstract class AuthenticationUserDatasource {
  Future<String> registerUser(UserModel userModel);
  Future<String> logInUser(UserModel userModel);
}

final class AuthenticationUserDatasourceRemoot
    implements AuthenticationUserDatasource {
  Dio dio;
  AuthenticationUserDatasourceRemoot(this.dio);
  @override
  Future<String> registerUser(UserModel userModel) async {
    try {
      var response = await dio.post(
        '/auth/register',
        data: {
          {
            "email": userModel.email,
            "username": userModel.userName,
            "first_name": userModel.userName,
            "last_name": userModel.userName,
            "password": userModel.password,
          },
        },
      );
      if (response.statusCode == 201) {
        SharedPreferencesData.saveUserToken(response.data['access_token']);
        print(response.data['access_token']);
        return logInUser(userModel);
      } else {
        print('Error 1');
        return '';
      }
    } on DioException catch (ex) {
      print(ex.message);

      throw ApiException(
        statusCode: ex.response!.statusCode!,
        message: ex.response?.data['message'],
      );
    } catch (e) {
      print('Error 3');

      throw ApiException(statusCode: 0, message: 'Unknown message');
    }
  }

  @override
  Future<String> logInUser(UserModel userModel) async {
    try {
      var response = await dio.post(
        '/auth/login',
        data: {
          {
            "email": userModel.email,
            "password": userModel.password,
          },
        },
      );
      if (response.statusCode == 200) {
        SharedPreferencesData.saveUserToken(response.data['access_token']);
        return response.data['access_token'];
      } else {
        return '';
      }
    } on DioException catch (ex) {
      throw ApiException(
          statusCode: ex.response!.statusCode!, message: ex.message!);
    } catch (e) {
      throw ApiException(statusCode: 0, message: 'Unknown message');
    }
  }
}
