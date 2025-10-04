import 'package:autilab_project/features/data/test/data/datasource/testdatasource.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../../core/network/api_exception.dart';
import '../model/intelligence_model.dart';
import '../model/testanswer_param.dart';

abstract class TestRepository {
  Future<Either<ApiException, List<IntelligenceModel>>> fetchAllIntelligence();
  Future<Either<ApiException, List<IntelligenceModel>>> fetchIntelligence(
      int id);
  Future<Either<ApiException, List<AutismTestModel>>> fetchAutismTest(int id);
  Future<Either<ApiException, List<AutismTestResult>>> fetchAutismTestResult();
  Future<Either<ApiException, int>> sendAnswerIntelligence(
      TestanswerParam testanswerParam);
  Future<Either<ApiException, int>> sendAnswerAutismTest(
      TestanswerParam testanswerParam);

  Future<Either<ApiException, String>> deleteAnswerIntelligenceTest(int id);
  Future<Either<ApiException, String>> deleteAnswerAutismTest(int id);
}

final class TestRepositoryRemoot implements TestRepository {
  Testdatasource testdatasource;
  TestRepositoryRemoot(this.testdatasource);
  @override
  Future<Either<ApiException, List<IntelligenceModel>>>
      fetchAllIntelligence() async {
    try {
      var response = await testdatasource.fetchAllIntelligence();
      return right(response);
    } on DioException catch (e) {
      return left(ApiException(
        statusCode: e.response?.statusCode ?? 0,
        message: e.response?.statusMessage ?? 'Unknown error',
        type: e.type,
      ));
    } catch (e) {
      return left(ApiException(
        statusCode: 0,
        message: 'Unknown error',
      ));
    }
  }

  @override
  Future<Either<ApiException, List<IntelligenceModel>>> fetchIntelligence(
      int id) async {
    try {
      var response = await testdatasource.fetchIntelligence(id);
      return right(response);
    } on DioException catch (e) {
      return left(ApiException(
        statusCode: e.response?.statusCode ?? 0,
        message: e.response?.statusMessage ?? 'Unknown error',
        type: e.type,
      ));
    } catch (e) {
      return left(ApiException(
        statusCode: 0,
        message: 'Unknown error',
      ));
    }
  }

  @override
  Future<Either<ApiException, int>> sendAnswerIntelligence(
      TestanswerParam testanswerParam) async {
    try {
      var response =
          await testdatasource.sendAnswerIntelligence(testanswerParam);
      return right(response);
    } on DioException catch (e) {
      return left(ApiException(
        statusCode: e.response?.statusCode ?? 0,
        message: e.response?.statusMessage ?? 'Unknown error',
        type: e.type,
      ));
    } catch (e) {
      return left(ApiException(
        statusCode: 0,
        message: 'Unknown error',
      ));
    }
  }

  @override
  Future<Either<ApiException, List<AutismTestModel>>> fetchAutismTest(
      int id) async {
    try {
      var response = await testdatasource.fetchAutismTest(id);
      return right(response);
    } on DioException catch (e) {
      return left(ApiException(
        statusCode: e.response?.statusCode ?? 0,
        message: e.response?.statusMessage ?? 'Unknown error',
        type: e.type,
      ));
    } catch (e) {
      return left(ApiException(
        statusCode: 0,
        message: 'Unknown error',
      ));
    }
  }

  @override
  Future<Either<ApiException, String>> deleteAnswerIntelligenceTest(
      int id) async {
    try {
      var response = await testdatasource.deleteAnswerIntelligenceTest(id);
      return right(response);
    } on DioException catch (e) {
      return left(ApiException(
        statusCode: e.response?.statusCode ?? 0,
        message: e.response?.statusMessage ?? 'Unknown error',
        type: e.type,
      ));
    } catch (e) {
      return left(ApiException(
        statusCode: 0,
        message: 'Unknown error',
      ));
    }
  }

  @override
  Future<Either<ApiException, int>> sendAnswerAutismTest(
      TestanswerParam testanswerParam) async {
    try {
      var response = await testdatasource.sendAnswerAutismTest(testanswerParam);
      return right(response);
    } on DioException catch (e) {
      return left(ApiException(
        statusCode: e.response?.statusCode ?? 0,
        message: e.response?.statusMessage ?? 'Unknown error',
        type: e.type,
      ));
    } catch (e) {
      return left(ApiException(
        statusCode: 0,
        message: 'Unknown error',
      ));
    }
  }

  @override
  Future<Either<ApiException, String>> deleteAnswerAutismTest(int id) async {
    try {
      var response = await testdatasource.deleteAnswerAutismTest(id);
      return right(response);
    } on DioException catch (e) {
      return left(ApiException(
        statusCode: e.response?.statusCode ?? 0,
        message: e.response?.statusMessage ?? 'Unknown error',
        type: e.type,
      ));
    } catch (e) {
      return left(ApiException(
        statusCode: 0,
        message: 'Unknown error',
      ));
    }
  }

  @override
  Future<Either<ApiException, List<AutismTestResult>>>
      fetchAutismTestResult() async {
    try {
      var response = await testdatasource.fetchAutismTestResult();
      return right(response);
    } on DioException catch (e) {
      return left(ApiException(
        statusCode: e.response?.statusCode ?? 0,
        message: e.response?.statusMessage ?? 'Unknown error',
        type: e.type,
      ));
    } catch (e) {
      return left(ApiException(
        statusCode: 0,
        message: 'Unknown error',
      ));
    }
  }
}
