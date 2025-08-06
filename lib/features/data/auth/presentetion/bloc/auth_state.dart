import 'package:autilab_project/features/data/auth/data/model/user_model.dart';
import 'package:dartz/dartz.dart';

//َ/ AuthenticationState abstract class
abstract class AuthenticationState {}

///The initial state of the authentication process
final class AuthInitiateState extends AuthenticationState {}

///Loading state for fetch or send data
final class AuthenticationLoading extends AuthenticationState {}

///Represents the state when an error occurs during the authentication process
final class AuthenticationError extends AuthenticationState {
  Object errorMessage;
  AuthenticationError(this.errorMessage);
}

/// State indicating successful receipt of authentication response
final class AuthenticationResponse extends AuthenticationState {
  Either<String, String> response;
  AuthenticationResponse(this.response);
}

/// State indicating successful receipt of authentication response
final class FetchUserDataResponse extends AuthenticationState {
  Either<String, UserModel> response;
  FetchUserDataResponse(this.response);
}

///Represents the response state after the user information process
final class UserInfoResponseState extends AuthenticationState {
  Either<String, List<UserModel>> displayUserInfo;
  UserInfoResponseState(this.displayUserInfo);
}
