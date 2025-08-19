import 'package:autilab_project/core/network/api_exception.dart';
import 'package:autilab_project/features/data/auth/data/model/user_model.dart';
import 'package:autilab_project/features/data/doctor/data/model/all_doctor_model.dart';
import 'package:autilab_project/features/data/home/data/model/center_model.dart';
import 'package:autilab_project/features/data/home/data/model/recent_visited_model.dart';
import 'package:dartz/dartz.dart';

//َ/ AuthenticationState abstract class
abstract class DoctorState {}

///The initial state of the doctor process
final class DoctorInitiateState extends DoctorState {}

///Loading state for fetch or send data
final class DoctorLoading extends DoctorState {}

///Represents the state when an error occurs during the doctor process
final class DoctorError extends DoctorState {
  ApiException errorMessage;
  DoctorError(this.errorMessage);
}

/// State indicating successful receipt of doctor response
final class DoctorResponse extends DoctorState {
  Either<String, String> response;
  DoctorResponse(this.response);
}

/// State indicating successful receipt of doctor response
final class FetchDoctorDataResponse extends DoctorState {
  Either<String, UserModel> response;
  FetchDoctorDataResponse(this.response);
}

///Represents the response state after the all doctors process
final class AllDoctorResponseState extends DoctorState {
  List<AllDoctorModel> displayAllDoctor;
  List<RecentVisitedModel> displayAllSpecialty;
  AllDoctorResponseState(this.displayAllDoctor, this.displayAllSpecialty);
}

///Represents the response state after the all centers process
final class AllCenterResponseState extends DoctorState {
  List<CenterModel> displayAllCenters;
  AllCenterResponseState(this.displayAllCenters);
}
