import 'package:autilab_project/core/network/dio_provider.dart';
import 'package:autilab_project/features/data/auth/data/datasource/authentication_user_datasource.dart';
import 'package:autilab_project/features/data/auth/data/repository/authentication_repository.dart';
import 'package:autilab_project/features/data/doctor/data/datasource/doctor_datasource.dart';
import 'package:autilab_project/features/data/doctor/data/repository/doctor_repository.dart';
import 'package:autilab_project/features/data/home/data/datasource/home__datasource.dart';
import 'package:autilab_project/features/data/home/data/repository/home_repository.dart';
import 'package:get_it/get_it.dart';

var locator = GetIt.instance;
Future<void> getInInit() async {
  locator.registerSingleton(DioProvider.dioProvider());
  datasource(locator);
  repository(locator);
}

void datasource(GetIt locator) {
  locator.registerFactory<AuthenticationUserDatasource>(
    () => AuthenticationUserDatasourceRemoot(
      locator.get(),
    ),
  );
  locator.registerFactory<HomeDataSource>(
    () => HomeDataSourceRemoot(
      locator.get(),
    ),
  );
  locator.registerFactory<DoctorDatasource>(
    () => DoctorDatasourceRemoot(
      locator.get(),
    ),
  );
}

void repository(GetIt locator) {
  locator.registerFactory<AuthenticationRepository>(
    () => AuthenticationRepositoryRemoot(
      locator.get(),
    ),
  );
  locator.registerFactory<HomeRepository>(
    () => HomeRepositoryRemoot(
      locator.get(),
    ),
  );
  locator.registerFactory<DoctorRepository>(
    () => DoctorRepositoryRemoot(
      locator.get(),
    ),
  );
}
