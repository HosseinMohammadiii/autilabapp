import 'package:autilab_project/core/network/dio_provider.dart';
import 'package:autilab_project/features/data/auth/data/datasource/authentication_user_datasource.dart';
import 'package:autilab_project/features/data/auth/data/repository/authentication_repository.dart';
import 'package:get_it/get_it.dart';

var locator = GetIt.instance;
Future<void> getInInit() async {
  locator.registerSingleton(DioProvider.dioProvider());
  datasource(locator);
  repository(locator);
}

Future<void> datasource(GetIt locator) async {
  locator.registerFactory<AuthenticationUserDatasource>(
    () => AuthenticationUserDatasourceRemoot(
      locator.get(),
    ),
  );
}

Future<void> repository(GetIt locator) async {
  locator.registerFactory<AuthenticationRepository>(
    () => AuthenticationRepositoryRemoot(
      locator.get(),
    ),
  );
}
