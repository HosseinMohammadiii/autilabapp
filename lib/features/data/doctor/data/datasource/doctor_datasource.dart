import 'package:autilab_project/core/network/api_exception.dart';
import 'package:autilab_project/core/network/shared_preferences.dart';
import 'package:autilab_project/features/data/doctor/data/model/all_doctor_model.dart';
import 'package:dio/dio.dart';

import '../../../home/data/model/recent_visited_model.dart';

abstract class DoctorDatasource {
  Future<List<AllDoctorModel>> fetchAllDoctor();
  Future<List<RecentVisitedModel>> fetchAllSpecialty();
}

final class DoctorDatasourceRemoot implements DoctorDatasource {
  Dio dio;
  DoctorDatasourceRemoot(this.dio);
  @override
  Future<List<AllDoctorModel>> fetchAllDoctor() async {
    try {
      var response = await dio.get(
        '/doctor_info/',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization':
                'Bearer ${await SharedPreferencesData.getUserToken()}',
          },
        ),
      );
      List<dynamic> doctorsList = response.data['data'];

      return doctorsList
          .map((jsonObject) => AllDoctorModel.fromJson(jsonObject))
          .toList();
    } on DioException catch (e) {
      throw ApiException(
          statusCode: e.response?.statusCode ?? 0,
          message: e.response?.statusMessage ?? 'Unknown API error');
    } catch (e) {
      print('Caught in generic catch: $e');

      throw ApiException(statusCode: 0, message: 'Unknown message');
    }
  }

  @override
  Future<List<RecentVisitedModel>> fetchAllSpecialty() async {
    try {
      var specialty = await dio.get(
        '/speciality/',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization':
                'Bearer ${await SharedPreferencesData.getUserToken()}',
          },
        ),
      );
      List<dynamic> specialtyList = specialty.data['data'];

      return specialtyList
          .map((jsonObject) => RecentVisitedModel.fromJson(jsonObject))
          .toList();
    } on DioException catch (e) {
      throw ApiException(
        statusCode: e.response?.statusCode ?? 0,
        message: e.response?.statusMessage ?? 'Unknown API error',
        type: e.type,
      );
    } catch (e) {
      print('Caught in generic catch: $e');
      throw ApiException(statusCode: 0, message: 'Unknown message');
    }
  }
}
