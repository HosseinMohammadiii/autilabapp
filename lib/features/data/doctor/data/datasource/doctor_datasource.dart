import 'package:autilab_project/core/network/api_exception.dart';
import 'package:autilab_project/core/network/shared_preferences.dart';
import 'package:autilab_project/features/data/doctor/data/model/all_doctor_model.dart';
import 'package:dio/dio.dart';

abstract class DoctorDatasource {
  Future<List<AllDoctorModel>> fetchAllDoctor();
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
      if (response.statusCode == 200) {
        return response.data['data']
            .map((jsonObject) => AllDoctorModel.fromJson(jsonObject))
            .toList();
      } else {
        throw ApiException(statusCode: 0, message: 'Invalid response format');
      }
    } on DioException catch (e) {
      throw ApiException(
          statusCode: e.response?.statusCode ?? 0,
          message: e.response?.statusMessage ?? 'Unknown API error');
    } catch (e) {
      throw ApiException(statusCode: 0, message: 'Unknown message');
    }
  }
}
