import 'package:autilab_project/core/network/api_exception.dart';
import 'package:autilab_project/core/network/shared_preferences.dart';
import 'package:autilab_project/features/data/auth/data/model/user_model.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

import '../model/user_param.dart';

abstract class AuthenticationUserDatasource {
  Future<String> registerUser(UserParam userParam);
  Future<String> logInUser(UserParam userParam);
  Future<UserModel> updateUserProfile(UserParam userModel);
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
          "first_name": userParam.firstName,
          "last_name": userParam.lastName,
          "birthdate": "2025-08-04T11:47:42.304Z",
          "role_id": 5,
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
  Future<UserModel> updateUserProfile(UserParam userParam) async {
    try {
      // MultipartFile? imageFile;
      // String fileName = userParam.photo!.path.split('/').last;

      // if (userParam.photo != null) {
      //   imageFile = await MultipartFile.fromFile(
      //     fileName,
      //   );
      // }

      // FormData formData = FormData.fromMap({
      //   "email": userParam.email,
      //   "first_name": userParam.firstName,
      //   "last_name": userParam.lastName,
      //   "birthdate": userParam.birthDate,
      //   "address": userParam.address,
      //   "photo": imageFile,
      //   "gender": userParam.gender
      //   // 'photo': imageFile,
      // });
      var response = await dio.put(
        '/user/update',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization':
                'Bearer ${await SharedPreferencesData.getUserToken()}',
          },
        ),
        // data: formData,
        data: {
          "email": userParam.email,
          "first_name": userParam.firstName,
          "last_name": userParam.lastName,
          if (userParam.birthDate != null &&
              userParam.birthDate !=
                  DateFormat('yyyy-MM-dd').format(
                    DateTime.now(),
                  ))
            "birthdate": userParam.birthDate,
          "address": userParam.address,
          "description": userParam.description,
          // "photo": imageFile,
          if (userParam.gender != null &&
              userParam.gender != 'Select your gender')
            "gender": userParam.gender
        },
      );
      return UserModel.fromJson(response.data['data']);
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
      var token = await SharedPreferencesData.getUserToken();
      var response = await dio.get(
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
        '/user/current',
      );
      if (response.data != null &&
          response.data['data'] is Map<String, dynamic>) {
        return UserModel.fromJson(response.data['data']);
      } else {
        throw ApiException(statusCode: 0, message: 'Invalid response format');
      }
    } on DioException catch (ex) {
      throw ApiException(
        statusCode: ex.response?.statusCode ?? 0,
        message: ex.response?.data['message'] ?? 'Unknown API error',
      );
    } catch (e) {
      throw ApiException(statusCode: 0, message: 'Unknown message');
    }
  }
}
