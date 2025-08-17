import 'package:autilab_project/core/network/api_exception.dart';
import 'package:autilab_project/features/data/home/data/model/home_model.dart';
import 'package:dio/dio.dart';

import '../../../../../core/network/shared_preferences.dart';

abstract class HomeDataSource {
  Future<List<HomeModel>> getNewAppointmentList();
}

final class HomeDataSourceRemoot implements HomeDataSource {
  Dio dio;
  HomeDataSourceRemoot(this.dio);
  @override
  Future<List<HomeModel>> getNewAppointmentList() async {
    try {
      var response = await dio.get(
        '/home_page/patient/',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization':
                'Bearer ${await SharedPreferencesData.getUserToken()}',
          },
        ),
      );

      return response.data['data']
          .map<HomeModel>(
            (jsonObject) => HomeModel.fromJson(
              jsonObject,
            ),
          )
          .toList();
    } on DioException catch (ex) {
      throw ApiException(
        statusCode: ex.response?.statusCode ?? 0,
        message: ex.response?.statusMessage ?? 'Unknow message',
      );
    } catch (e) {
      throw ApiException(
        statusCode: 0,
        message: 'Unknow message',
      );
    }
  }
}
