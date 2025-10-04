import 'package:autilab_project/features/data/test/data/repository/testrepository.dart';
import 'package:autilab_project/features/data/test/presentation/bloc/test_event.dart';
import 'package:autilab_project/features/data/test/presentation/bloc/test_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final class TestBloc extends Bloc<TestEvent, TestState> {
  TestRepository testRepository;
  TestBloc(this.testRepository) : super(TestInitiateState()) {
    on<DisplayAllIntelligence>(
      (event, emit) async {
        emit(TestLoading());
        var intelligenceResponse = await testRepository.fetchAllIntelligence();

        intelligenceResponse.fold(
          (error) {
            emit(TestError(error));
          },
          (intelligence) {
            emit(DisplayAllIntelligenceState(intelligence));
          },
        );
      },
    );
    on<DisplayIntelligence>(
      (event, emit) async {
        emit(TestLoading());
        var intelligenceResponse =
            await testRepository.fetchIntelligence(event.intelligenceId);
        var intelligenceResponseList =
            await testRepository.fetchAllIntelligence();

        intelligenceResponse.fold(
          (error) {
            emit(TestError(error));
          },
          (intelligence) {
            intelligenceResponseList.fold(
              (error) {
                emit(TestError(error));
              },
              (intelligenceList) {
                emit(DisplayIntelligenceState(intelligence, intelligenceList));
              },
            );
          },
        );
      },
    );

    on<SendIntelligenceAnswer>(
      (event, emit) async {
        var response =
            await testRepository.sendAnswerIntelligence(event.testanswerParam);
        response.fold(
          (error) {
            emit(TestError(error));
          },
          (answer) {
            emit(IntelligenceAnswerState(answer));
          },
        );
      },
    );
    on<SendAutismTestAnswer>(
      (event, emit) async {
        var response =
            await testRepository.sendAnswerAutismTest(event.testanswerParam);
        response.fold(
          (error) {
            emit(TestError(error));
          },
          (answer) {
            emit(AutismTestAnswerState(answer));
          },
        );
      },
    );
    on<DisplayAutismTest>(
      (event, emit) async {
        emit(TestLoading());

        var response = await testRepository.fetchAutismTest(event.testId);
        response.fold(
          (error) {
            emit(TestError(error));
          },
          (autismTest) {
            emit(DisplayAutismTestState(autismTest));
          },
        );
      },
    );

    on<DeleteIntelligenceAnswer>(
      (event, emit) async {
        var deleteIntelligence =
            await testRepository.deleteAnswerIntelligenceTest(event.responseId);
        deleteIntelligence.fold(
          (error) {
            emit(TestError(error));
          },
          (delete) {
            emit(DeleteIntelligenceAnswerState());
          },
        );
      },
    );
    on<DeleteAutismAnswer>(
      (event, emit) async {
        var deleteAutismTest =
            await testRepository.deleteAnswerAutismTest(event.responseId);
        deleteAutismTest.fold(
          (error) {
            emit(TestError(error));
          },
          (delete) {
            emit(DeleteAutismAnswerState());
          },
        );
      },
    );
    on<DisplayAutismTestResult>(
      (event, emit) async {
        emit(TestLoading());
        var autismTestResultResponse =
            await testRepository.fetchAutismTestResult();

        autismTestResultResponse.fold(
          (error) {
            emit(TestError(error));
          },
          (testResult) {
            emit(DisplayAutismTestResultState(testResult));
          },
        );
      },
    );
  }
}
