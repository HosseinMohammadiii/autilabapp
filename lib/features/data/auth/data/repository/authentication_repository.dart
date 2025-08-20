import 'dart:io';

import 'package:autilab_project/features/data/auth/data/datasource/authentication_user_datasource.dart';
import 'package:autilab_project/features/data/auth/data/model/user_model.dart';
import 'package:autilab_project/features/data/auth/data/model/user_param.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/network/api_exception.dart';

abstract class AuthenticationRepository {
  Future<Either<String, String>> registerUser(UserParam userParam);
  Future<Either<String, String>> logInUser(UserParam userParam);
  Future<Either<String, UserModel>> updateUserProfile(UserParam userModel);
  Future<Either<String, String>> uploadPhotoUser(File photo);
  Future<Either<String, UserModel>> fetchUserData();
}

final class AuthenticationRepositoryRemoot implements AuthenticationRepository {
  final AuthenticationUserDatasource _datasourceRemoot;
  AuthenticationRepositoryRemoot(this._datasourceRemoot);
  @override
  Future<Either<String, String>> logInUser(UserParam userParam) async {
    try {
      var response = await _datasourceRemoot.logInUser(userParam);
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message);
    }
  }

  @override
  Future<Either<String, String>> registerUser(UserParam userParam) async {
    try {
      var response = await _datasourceRemoot.registerUser(userParam);
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message);
    }
  }

  @override
  Future<Either<String, UserModel>> updateUserProfile(
      UserParam userModel) async {
    try {
      var response = await _datasourceRemoot.updateUserProfile(userModel);
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message);
    }
  }

  @override
  Future<Either<String, UserModel>> fetchUserData() async {
    try {
      var response = await _datasourceRemoot.fetchUserData();
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message);
    }
  }

  @override
  Future<Either<String, String>> uploadPhotoUser(File photo) async {
    try {
      var response = await _datasourceRemoot.uploadPhotoUser(photo);
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message);
    }
  }
}
