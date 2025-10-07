import 'package:autilab_project/features/data/home/data/model/home_model.dart';
import 'package:autilab_project/features/data/home/data/model/newappointment_model.dart';
import 'package:dartz/dartz.dart';

//َ/ HomeState abstract class
abstract class HomeState {}

///The initial state of the home process
final class HomeInitiateState extends HomeState {}

///Loading state for fetch data
final class HomeLoading extends HomeState {}

///Represents the state when an error occurs during the home process
final class HomeErrorHandling extends HomeState {
  final String errorMessage;
  HomeErrorHandling(this.errorMessage);
}

/// State indicating successful receipt of home response
final class HomeFetchData extends HomeState {
  Either<String, List<HomeModel>> homeResponse;
  HomeFetchData(this.homeResponse);
}

final class AppointmentFetchData extends HomeState {
  Either<String, List<AppointmentClass>> appointmentResponse;
  AppointmentFetchData(this.appointmentResponse);
}
