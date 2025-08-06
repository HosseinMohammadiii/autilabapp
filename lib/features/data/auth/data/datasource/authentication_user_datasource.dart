import 'package:autilab_project/core/network/api_exception.dart';
import 'package:autilab_project/core/network/shared_preferences.dart';
import 'package:autilab_project/features/data/auth/data/model/user_model.dart';
import 'package:dio/dio.dart';

import '../model/user_param.dart';

abstract class AuthenticationUserDatasource {
  Future<String> registerUser(UserParam userParam);
  Future<String> logInUser(UserParam userParam);
  Future<String> updateUserProfile(UserModel userModel);
  Future<UserModel> fetchUserData();
}

final class AuthenticationUserDatasourceRemoot
    implements AuthenticationUserDatasource {
  Dio dio;
  AuthenticationUserDatasourceRemoot(this.dio);
  @override
  Future<String> registerUser(UserParam userParam) async {
    try {
      var response = await dio.post(
        '/auth/register',
        data: {
          "email": userParam.email,
          "username": userParam.userName,
          "first_name": userParam.userName,
          "last_name": userParam.userName,
          "birthdate": "2025-08-04T11:47:42.304Z",
          "role_id": 0,
          "password": userParam.password,
        },
      );

      if (response.statusCode == 201) {
        SharedPreferencesData.saveUserToken(response.data['access_token']);
        return await logInUser(userParam);
      } else {
        return '';
      }
    } on DioException catch (ex) {
      throw ApiException(
        statusCode:
            ex.response?.statusCode != null ? ex.response!.statusCode! : 0,
        message: ex.response?.data['message'],
      );
    } catch (e) {
      throw ApiException(statusCode: 0, message: 'Unknown message');
    }
  }

  @override
  Future<String> logInUser(UserParam userParam) async {
    try {
      var response = await dio.post(
        '/auth/login',
        data: {
          "email": userParam.email,
          "password": userParam.password,
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
        statusCode: ex.response?.statusCode ?? 0,
        message: ex.response?.data['message'] ?? 'Unknown message',
      );
    } catch (e) {
      throw ApiException(statusCode: 0, message: 'Unknown message');
    }
  }

  @override
  Future<String> updateUserProfile(UserModel userModel) async {
    try {
      var response = await dio.post(
        '/user/update',
        data: {
          {
            "email": userModel.email,
            "username": userModel.userName,
            "first_name": userModel.firstName,
            "last_name": userModel.lastName,
            // "mobile": "string",
            "birthdate": userModel.birthdate,
            // "phone": "string",
            "gender": userModel.gender,
            "photo": userModel.photo,
            // "language": "string",
            // "currency": "string",
            // "active": true,
            // "role_id": 0,
          },
        },
      );
      if (response.statusCode == 200) {
        return response.data['data']
            .map<UserModel>(
              (jsonObject) => UserModel.fromJson(jsonObject),
            )
            .toList();
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

  @override
  Future<UserModel> fetchUserData() async {
    try {
      var response = await dio.get(
        '/user/current',
      );

      return response.data['data']
          .map<UserModel>(
            (jsonObject) => UserModel.fromJson(jsonObject),
          )
          .toList();
    } on DioException catch (ex) {
      throw ApiException(
          statusCode: ex.response!.statusCode!, message: ex.message!);
    } catch (e) {
      throw ApiException(statusCode: 0, message: 'Unknown message');
    }
  }
}
