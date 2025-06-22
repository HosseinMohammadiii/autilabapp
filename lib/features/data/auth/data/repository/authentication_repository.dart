import 'package:autilab_project/features/data/auth/data/datasource/authentication_user_datasource.dart';
import 'package:autilab_project/features/data/auth/data/model/user_model.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/network/api_exception.dart';

abstract class AuthenticationRepository {
  Future<Either<String, String>> registerUser(UserModel userModel);
  Future<Either<String, String>> logInUser(UserModel userModel);
}

final class AuthenticationRepositoryRemoot implements AuthenticationRepository {
  final AuthenticationUserDatasource _datasourceRemoot;
  AuthenticationRepositoryRemoot(this._datasourceRemoot);
  @override
  Future<Either<String, String>> logInUser(UserModel userModel) async {
    try {
      var response = await _datasourceRemoot.logInUser(userModel);
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message);
    }
  }

  @override
  Future<Either<String, String>> registerUser(UserModel userModel) async {
    try {
      var response = await _datasourceRemoot.registerUser(userModel);
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message);
    }
  }
}
