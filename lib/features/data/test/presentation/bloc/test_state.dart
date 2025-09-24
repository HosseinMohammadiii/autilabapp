import 'package:autilab_project/features/data/test/data/model/intelligence_model.dart';

import '../../../../../core/network/api_exception.dart';

abstract class TestState {}

///The initial state of the doctor process
final class TestInitiateState extends TestState {}

///Loading state for fetch or send data
final class TestLoading extends TestState {}

///Represents the state when an error occurs during the doctor process
final class TestError extends TestState {
  ApiException errorMessage;
  TestError(this.errorMessage);
}

final class DisplayAllIntelligenceState extends TestState {
  List<IntelligenceModel> displayIntelligenceList;
  DisplayAllIntelligenceState(this.displayIntelligenceList);
}

final class DisplayIntelligenceState extends TestState {
  List<IntelligenceModel> displayIntelligenceList;

  List<IntelligenceModel> displayIntelligence;
  DisplayIntelligenceState(
      this.displayIntelligence, this.displayIntelligenceList);
}

final class DisplayAutismTestState extends TestState {
  List<AutismTestModel> displayAutismTest;
  DisplayAutismTestState(this.displayAutismTest);
}

final class IntelligenceAnswerState extends TestState {
  final int message;
  IntelligenceAnswerState(this.message);
}
