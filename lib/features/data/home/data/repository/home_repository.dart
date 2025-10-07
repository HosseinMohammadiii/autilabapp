import 'package:autilab_project/features/data/home/data/datasource/home__datasource.dart';
import 'package:autilab_project/features/data/home/data/model/home_model.dart';
import 'package:autilab_project/features/data/home/data/model/newappointment_model.dart';
import 'package:dartz/dartz.dart';

abstract class HomeRepository {
  Future<Either<String, List<HomeModel>>> getNewAppointmentList();
  Future<Either<String, List<AppointmentClass>>> fetchAppointmentList();
}

final class HomeRepositoryRemoot implements HomeRepository {
  HomeDataSource homeDataSource;
  HomeRepositoryRemoot(this.homeDataSource);
  @override
  Future<Either<String, List<HomeModel>>> getNewAppointmentList() async {
    try {
      var response = await homeDataSource.getNewAppointmentList();
      return Right(response);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, List<AppointmentClass>>> fetchAppointmentList() async {
    try {
      var response = await homeDataSource.fetchAppointmentList();
      return Right(response);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
