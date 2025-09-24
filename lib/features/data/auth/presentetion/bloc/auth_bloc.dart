import 'package:autilab_project/features/data/auth/data/repository/authentication_repository.dart';
import 'package:autilab_project/features/data/auth/presentetion/bloc/auth_event.dart';
import 'package:autilab_project/features/data/auth/presentetion/bloc/auth_state.dart';
import 'package:bloc/bloc.dart';

/// Bloc that handles authentication-related events and manages corresponding states.
final class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationRepository authenticationRepository;

  /// Creates an AuthenticationBloc with the provided repository.
  AuthenticationBloc(this.authenticationRepository)
      : super(AuthInitiateState()) {
    /// Handles event to fetch and emit current user information.
    on<DisplayInformationUser>(
      (event, emit) async {
        try {
          emit(AuthenticationLoading());
          var fetchUserData = await authenticationRepository.fetchUserData();
          emit(FetchUserDataResponse(fetchUserData));
        } catch (e) {
          emit(AuthenticationError(e));
        }
      },
    );

    /// Handles login event by calling the repository and emitting the result.
    on<LogInRequest>(
      (event, emit) async {
        try {
          emit(AuthenticationLoading());
          var logInRequest =
              await authenticationRepository.logInUser(event.userParam);
          emit(AuthenticationResponse(logInRequest));
        } catch (e) {
          emit(AuthenticationError(e));
        }
      },
    );

    /// Handles sign-up event by calling the repository and emitting the result.
    on<SignUpRequest>(
      (event, emit) async {
        try {
          emit(AuthenticationLoading());

          var signUpRequest = await authenticationRepository.registerUser(
            event.userParam,
          );
          emit(AuthenticationResponse(signUpRequest));
        } catch (e) {
          emit(AuthenticationError(e));
        }
      },
    );

    /// Handles updateUserProfilePhoto event by calling the repository and emitting the result.
    on<UploadPhoto>(
      (event, emit) async {
        emit(AuthenticationLoading());

        var uploadPhoto =
            await authenticationRepository.uploadPhotoUser(event.photo);

        uploadPhoto.fold(
          (e) {
            emit(AuthenticationError(e));
          },
          (response) {
            emit(UploadPhotoResponse(response));
          },
        );
      },
    );

    /// Handles updateUserProfile event by calling the repository and emitting the result.
    on<UpdateUserProfile>(
      (event, emit) async {
        try {
          emit(AuthenticationLoading());
          var updateProfile =
              await authenticationRepository.updateUserProfile(event.userParam);
          emit(FetchUserDataResponse(updateProfile));
        } catch (e) {
          emit(AuthenticationError(e));
        }
      },
    );
  }
}
