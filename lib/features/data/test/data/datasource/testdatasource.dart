import 'package:autilab_project/core/network/api_exception.dart';
import 'package:autilab_project/features/data/test/data/model/intelligence_model.dart';
import 'package:autilab_project/features/data/test/data/model/testanswer_param.dart';
import 'package:dio/dio.dart';

import '../../../../../core/network/shared_preferences.dart';

abstract class Testdatasource {
  Future<List<IntelligenceModel>> fetchAllIntelligence();
  Future<List<IntelligenceModel>> fetchIntelligence(int id);
  Future<List<AutismTestModel>> fetchAutismTest(int id);
  Future<String> sendAnswerIntelligence(TestanswerParam testanswerParam);
  Future<String> sendAnswerAutismTest(TestanswerParam testanswerParam);
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
  Future<String> sendAnswerIntelligence(TestanswerParam testanswerParam) async {
    try {
      var response = await dio.post(
        '/intelligence_response/',
        data: {
          'question_id': testanswerParam.questionId,
          'answer_id': testanswerParam.answerId,
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization':
                'Bearer ${await SharedPreferencesData.getUserToken()}',
          },
        ),
      );
      return response.data['message'];
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
  Future<String> sendAnswerAutismTest(TestanswerParam testanswerParam) {
    // TODO: implement sendAnswerAutismTest
    throw UnimplementedError();
  }
}
