import 'package:autilab_project/core/network/api_exception.dart';
import 'package:autilab_project/core/network/shared_preferences.dart';
import 'package:autilab_project/features/data/doctor/data/model/all_doctor_model.dart';
import 'package:autilab_project/features/data/doctor/data/model/workscheduel_doctor_model.dart';
import 'package:dio/dio.dart';

import '../../../home/data/model/recent_visited_model.dart';
import '../model/center_model.dart';

abstract class DoctorDatasource {
  Future<List<AllDoctorModel>> fetchAllDoctor();
  Future<List<SpecialtyDoctor>> fetchSpecialtyDoctor(int doctorId);
  Future<List<RecentVisitedModel>> fetchAllSpecialty();
  Future<List<CenterModel>> fetchAllCenters();
  Future<List<WorkscheduelDoctorModel>> fetchDoctorWorkSchedule(int doctorId);
  Future<List<Time>> fetchSpecialtyDoctorWorkSchedule(int workScheduleId);
  Future<String> setAppointment(
      int doctorId, int scheduelId, String description);
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
      throw ApiException(statusCode: 0, message: 'Unknown message');
    }
  }

  @override
  Future<List<CenterModel>> fetchAllCenters() async {
    try {
      var center = await dio.get(
        '/center/',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization':
                'Bearer ${await SharedPreferencesData.getUserToken()}',
          },
        ),
      );
      List<dynamic> centerList = center.data['data'];

      return centerList
          .map((jsonObject) => CenterModel.fromJson(jsonObject))
          .toList();
    } on DioException catch (e) {
      throw ApiException(
        statusCode: e.response?.statusCode ?? 0,
        message: e.response?.statusMessage ?? 'Unknown API error',
        type: e.type,
      );
    } catch (e) {
      throw ApiException(statusCode: 0, message: 'Unknown message');
    }
  }

  @override
  Future<List<WorkscheduelDoctorModel>> fetchDoctorWorkSchedule(
      int doctorId) async {
    try {
      var workScheduleResponse = await dio.get(
        '/work_schedule/parent_id/$doctorId',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization':
                'Bearer ${await SharedPreferencesData.getUserToken()}',
          },
        ),
      );
      List<dynamic> workScheduleResponseList =
          workScheduleResponse.data['data'];

      return workScheduleResponseList
          .map((jsonObject) => WorkscheduelDoctorModel.fromJson(jsonObject))
          .toList();
    } on DioException catch (e) {
      throw ApiException(
        statusCode: e.response?.statusCode ?? 0,
        message: e.response?.statusMessage ?? 'Unknown API error',
        type: e.type,
      );
    } catch (e) {
      throw ApiException(statusCode: 0, message: 'Unknown message');
    }
  }

  @override
  Future<String> setAppointment(
      int doctorId, int scheduelId, String description) async {
    try {
      var appointmentResponse = await dio.post(
        '/appointment/',
        data: {
          'doctor_id': doctorId,
          'work_schedule_id': scheduelId,
          'description': description
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization':
                'Bearer ${await SharedPreferencesData.getUserToken()}',
          },
        ),
      );

      return appointmentResponse.data['message'];
    } on DioException catch (e) {
      rethrow;
    } catch (e) {
      throw ApiException(statusCode: 0, message: 'Unknown message');
    }
  }

  @override
  Future<List<Time>> fetchSpecialtyDoctorWorkSchedule(
      int workScheduleId) async {
    try {
      var workScheduleResponse = await dio.get(
        '/work_schedule/$workScheduleId',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization':
                'Bearer ${await SharedPreferencesData.getUserToken()}',
          },
        ),
      );
      List<dynamic> workScheduleResponseList =
          workScheduleResponse.data['data'];

      return workScheduleResponseList
          .map((jsonObject) => Time.fromJson(jsonObject))
          .toList();
    } on DioException catch (e) {
      throw ApiException(
        statusCode: e.response?.statusCode ?? 0,
        message: e.response?.statusMessage ?? 'Unknown API error',
        type: e.type,
      );
    } catch (e) {
      throw ApiException(statusCode: 0, message: 'Unknown message');
    }
  }

  @override
  Future<List<SpecialtyDoctor>> fetchSpecialtyDoctor(int doctorId) async {
    try {
      var doctorResponse = await dio.get(
        '/doctor_info/parent_id/$doctorId',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization':
                'Bearer ${await SharedPreferencesData.getUserToken()}',
          },
        ),
      );
      List<dynamic> doctorResponseResponseList = doctorResponse.data['data'];

      return doctorResponseResponseList
          .map((jsonObject) => SpecialtyDoctor.fromJson(jsonObject))
          .toList();
    } on DioException catch (e) {
      throw ApiException(
        statusCode: e.response?.statusCode ?? 0,
        message: e.response?.statusMessage ?? 'Unknown API error',
        type: e.type,
      );
    } catch (e) {
      throw ApiException(statusCode: 0, message: 'Unknown message');
    }
  }
}
