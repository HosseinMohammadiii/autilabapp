import 'package:autilab_project/core/network/api_exception.dart';
import 'package:autilab_project/features/data/test/data/model/intelligence_model.dart';
import 'package:autilab_project/features/data/test/data/model/testanswer_param.dart';
import 'package:dio/dio.dart';

import '../../../../../core/network/shared_preferences.dart';

abstract class Testdatasource {
  Future<List<IntelligenceModel>> fetchAllIntelligence();
  Future<List<IntelligenceModel>> fetchIntelligence(int id);
  Future<List<AutismTestModel>> fetchAutismTest(int id);
  Future<List<AutismTestResult>> fetchAutismTestResult();
  Future<int> sendAnswerIntelligence(TestanswerParam testanswerParam);
  Future<int> sendAnswerAutismTest(TestanswerParam testanswerParam);
  Future<String> deleteAnswerIntelligenceTest(int id);
  Future<String> deleteAnswerAutismTest(int id);
}

final class TestdatasourceRemoot implements Testdatasource {
  Dio dio;
  TestdatasourceRemoot(this.dio);
  @override
  Future<List<IntelligenceModel>> fetchAllIntelligence() async {
    try {
      var response = await dio.get(
        '/intelligence_question/',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization':
                'Bearer ${await SharedPreferencesData.getUserToken()}',
          },
        ),
      );
      List<dynamic> intelligenceResponse = response.data['data'];
      return intelligenceResponse
          .map<IntelligenceModel>(
              (jsonObject) => IntelligenceModel.fromJson(jsonObject))
          .toList();
    } on DioException catch (e) {
      throw ApiException(
          statusCode: e.response?.statusCode ?? 0,
          message: e.response?.statusMessage ?? 'Unknown API error');
    } catch (e) {
      throw ApiException(statusCode: 0, message: 'Unknown message');
    }
  }

  @override
  Future<List<IntelligenceModel>> fetchIntelligence(int id) async {
    try {
      var response = await dio.get(
        '/intelligence_question/$id',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization':
                'Bearer ${await SharedPreferencesData.getUserToken()}',
          },
        ),
      );
      List<dynamic> intelligenceResponse = response.data['data'];
      return intelligenceResponse
          .map<IntelligenceModel>(
              (jsonObject) => IntelligenceModel.fromJson(jsonObject))
          .toList();
    } on DioException catch (e) {
      throw ApiException(
          statusCode: e.response?.statusCode ?? 0,
          message: e.response?.statusMessage ?? 'Unknown API error');
    } catch (e) {
      throw ApiException(statusCode: 0, message: 'Unknown message');
    }
  }

  @override
  Future<int> sendAnswerIntelligence(TestanswerParam testanswerParam) async {
    try {
      int id = 0;
      var response = await dio.post(
        '/intelligence_response/',
        data: {
          "answers": [
            {
              'question_id': testanswerParam.questionId,
              'answer_id': testanswerParam.answerId,
            }
          ]
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization':
                'Bearer ${await SharedPreferencesData.getUserToken()}',
          },
        ),
      );
      var questionId =
          response.data['data'].map((json) => id = json['id']).toList();
      return questionId.last;
    } on DioException catch (e) {
      throw ApiException(
          statusCode: e.response?.statusCode ?? 0,
          message: e.response?.statusMessage ?? 'Unknown API error');
    } catch (e) {
      throw ApiException(statusCode: 0, message: 'Unknown message');
    }
  }

  @override
  Future<List<AutismTestModel>> fetchAutismTest(int id) async {
    try {
      var response = await dio.get(
        '/autism_question/$id',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization':
                'Bearer ${await SharedPreferencesData.getUserToken()}',
          },
        ),
      );
      List<dynamic> intelligenceResponse = response.data['data'];
      return intelligenceResponse
          .map<AutismTestModel>(
              (jsonObject) => AutismTestModel.fromJson(jsonObject))
          .toList();
    } on DioException catch (e) {
      throw ApiException(
          statusCode: e.response?.statusCode ?? 0,
          message: e.response?.statusMessage ?? 'Unknown API error');
    } catch (e) {
      throw ApiException(statusCode: 0, message: 'Unknown message');
    }
  }

  @override
  Future<int> sendAnswerAutismTest(TestanswerParam testanswerParam) async {
    try {
      int id = 0;
      var response = await dio.post(
        '/autism_user_answer/',
        data: {
          "user_answers": [
            {
              'question_id': testanswerParam.questionId,
              'answer_id': testanswerParam.answerId,
            }
          ]
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization':
                'Bearer ${await SharedPreferencesData.getUserToken()}',
          },
        ),
      );
      var questionId =
          response.data['data'].map((json) => id = json['id']).toList();
      return questionId.last;
    } on DioException catch (e) {
      throw ApiException(
          statusCode: e.response?.statusCode ?? 0,
          message: e.response?.statusMessage ?? 'Unknown API error');
    } catch (e) {
      throw ApiException(statusCode: 0, message: 'Unknown message');
    }
  }

  @override
  Future<String> deleteAnswerIntelligenceTest(int id) async {
    try {
      await dio.delete(
        '/intelligence_response/response/$id',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization':
                'Bearer ${await SharedPreferencesData.getUserToken()}',
          },
        ),
      );
      return 'Delete Successfully';
    } on DioException catch (e) {
      throw ApiException(
          statusCode: e.response?.statusCode ?? 0,
          message: e.response?.statusMessage ?? 'Unknown API error');
    } catch (e) {
      throw ApiException(statusCode: 0, message: 'Unknown message');
    }
  }

  @override
  Future<String> deleteAnswerAutismTest(int id) async {
    try {
      await dio.delete(
        '/autism_user_answer/$id',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization':
                'Bearer ${await SharedPreferencesData.getUserToken()}',
          },
        ),
      );
      return 'Delete Successfully';
    } on DioException catch (e) {
      throw ApiException(
          statusCode: e.response?.statusCode ?? 0,
          message: e.response?.statusMessage ?? 'Unknown API error');
    } catch (e) {
      throw ApiException(statusCode: 0, message: 'Unknown message');
    }
  }

  @override
  Future<List<AutismTestResult>> fetchAutismTestResult() async {
    try {
      var response = await dio.get(
        '/autism_result/',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization':
                'Bearer ${await SharedPreferencesData.getUserToken()}',
          },
        ),
      );
      List<dynamic> intelligenceResponse = response.data['data'];
      return intelligenceResponse
          .map<AutismTestResult>(
              (jsonObject) => AutismTestResult.fromJson(jsonObject))
          .toList();
    } on DioException catch (e) {
      throw ApiException(
          statusCode: e.response?.statusCode ?? 0,
          message: e.response?.statusMessage ?? 'Unknown API error');
    } catch (e) {
      throw ApiException(statusCode: 0, message: 'Unknown message');
    }
  }
}
