import '../../../../../../core/network/api_exception.dart';
import '../../../data/model/center_model.dart';

//َ/ CenterState abstract class
abstract class CenterState {}

///The initial state of the doctor process
final class CenterInitiateState extends CenterState {}

///Loading state for fetch or send data
final class CenterLoading extends CenterState {}

///Represents the state when an error occurs during the doctor process
final class CenterError extends CenterState {
  ApiException errorMessage;
  CenterError(this.errorMessage);
}

///Represents the response state after the all centers process
final class AllCenterResponseState extends CenterState {
  List<CenterModel> displayAllCenters;
  AllCenterResponseState(this.displayAllCenters);
}
