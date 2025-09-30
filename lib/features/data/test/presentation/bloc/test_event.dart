import 'package:autilab_project/features/data/test/data/model/testanswer_param.dart';

abstract class TestEvent {}

/// Event to trigger display of all doctors.
final class DisplayAllIntelligence extends TestEvent {}

final class DisplayIntelligence extends TestEvent {
  final int intelligenceId;
  DisplayIntelligence({required this.intelligenceId});
}

final class DisplayAutismTest extends TestEvent {
  final int testId;
  DisplayAutismTest({required this.testId});
}

final class SendIntelligenceAnswer extends TestEvent {
  TestanswerParam testanswerParam;
  SendIntelligenceAnswer({required this.testanswerParam});
}

final class DeleteIntelligenceAnswer extends TestEvent {
  final int responseId;
  DeleteIntelligenceAnswer({required this.responseId});
}
