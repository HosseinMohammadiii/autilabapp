import 'package:autilab_project/core/network/api_exception.dart';
import 'package:autilab_project/features/data/auth/data/model/user_model.dart';
import 'package:autilab_project/features/data/doctor/data/model/all_doctor_model.dart';
import 'package:autilab_project/features/data/doctor/data/model/workscheduel_doctor_model.dart';
import 'package:autilab_project/features/data/home/data/model/recent_visited_model.dart';
import 'package:dartz/dartz.dart';

//َ/ DoctorState abstract class
abstract class DoctorState {}

///The initial state of the doctor process
final class DoctorInitiateState extends DoctorState {}

///Loading state for fetch or send data
final class DoctorLoading extends DoctorState {}

final class WorkScheduelDoctorLoading extends DoctorState {}

final class SetAppointmentLoading extends DoctorState {}

///Represents the state when an error occurs during the doctor process
final class DoctorError extends DoctorState {
  ApiException errorMessage;
  DoctorError(this.errorMessage);
}

final class SetAppointmentError extends DoctorState {
  ApiException errorMessage;
  SetAppointmentError(this.errorMessage);
}

/// State indicating successful receipt of doctor response
final class DoctorResponse extends DoctorState {
  Either<String, String> response;
  DoctorResponse(this.response);
}

final class SpecialtyDoctorResponse extends DoctorState {
  List<SpecialtyDoctor> response;
  SpecialtyDoctorResponse(this.response);
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

final class DoctorWorkScheduelResponseState extends DoctorState {
  List<WorkscheduelDoctorModel> displayDoctorWorkScheduel;
  DoctorWorkScheduelResponseState(this.displayDoctorWorkScheduel);
}

final class SpecialtyDoctorWorkScheduelResponseState extends DoctorState {
  List<Time> displaySpecialtyDoctorWorkScheduel;
  SpecialtyDoctorWorkScheduelResponseState(
      this.displaySpecialtyDoctorWorkScheduel);
}

final class SetAppointmentResponseState extends DoctorState {
  SetAppointmentResponseState();
}
