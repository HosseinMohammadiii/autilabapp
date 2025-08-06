import 'package:autilab_project/features/data/auth/data/model/user_param.dart';

/// Base class for all authentication-related events.
abstract class AuthenticationEvent {}

/// Event to trigger display of current user information.
final class DisplayInformationUser extends AuthenticationEvent {}

/// Event to initiate a login request with provided credentials.
final class LogInRequest extends AuthenticationEvent {
  final UserParam userParam;

  LogInRequest({required this.userParam});
}

/// Event to initiate a sign-up request with user details.
final class SignUpRequest extends AuthenticationEvent {
  final UserParam userParam;

  SignUpRequest({
    required this.userParam,
  });
}
