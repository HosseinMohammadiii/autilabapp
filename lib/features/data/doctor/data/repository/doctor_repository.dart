import 'package:autilab_project/core/network/api_exception.dart';
import 'package:autilab_project/features/data/doctor/data/datasource/doctor_datasource.dart';
import 'package:autilab_project/features/data/doctor/data/model/all_doctor_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../home/data/model/recent_visited_model.dart';

abstract class DoctorRepository {
  Future<Either<ApiException, List<AllDoctorModel>>> fetchDoctorList();
  Future<Either<ApiException, List<RecentVisitedModel>>> fetchAllSpecialty();
}

final class DoctorRepositoryRemoot implements DoctorRepository {
  final DoctorDatasource datasource;
  DoctorRepositoryRemoot(this.datasource);
  @override
  Future<Either<ApiException, List<AllDoctorModel>>> fetchDoctorList() async {
    try {
      var response = await datasource.fetchAllDoctor();
      return right(response);
    } on DioException catch (e) {
      return left(ApiException(
        statusCode: e.response?.statusCode ?? 0,
        message: e.response?.statusMessage ?? 'Unknown error',
        type: e.type,
      ));
    } catch (e) {
      return left(ApiException(
        statusCode: 0,
        message: 'Unknown error',
      ));
    }
  }

  @override
  Future<Either<ApiException, List<RecentVisitedModel>>>
      fetchAllSpecialty() async {
    try {
      var specialty = await datasource.fetchAllSpecialty();
      return right(specialty);
    } on DioException catch (e) {
      return left(ApiException(
        statusCode: e.response?.statusCode ?? 0,
        message: e.response?.statusMessage ?? 'Unknown error',
        type: e.type,
      ));
    } catch (e) {
      return left(ApiException(
        statusCode: 0,
        message: 'Unknown error',
      ));
    }
  }
}
