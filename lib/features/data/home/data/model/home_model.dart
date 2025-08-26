import 'package:autilab_project/features/data/home/data/model/intelligence_test_model.dart';
import 'package:autilab_project/features/data/home/data/model/newappointment_model.dart';
import 'package:autilab_project/features/data/home/data/model/plan_model.dart';
import 'package:autilab_project/features/data/home/data/model/recent_visited_model.dart';

class HomeModel {
  List<NewappointmentModel> newappointmentModel;
  List<IntelligenceTestModel> intelligenceTestModel;
  List<RecentVisitedModel> recentVisitedModel;
  List<PlanModel> planModel;
  HomeModel({
    required this.newappointmentModel,
    required this.intelligenceTestModel,
    required this.recentVisitedModel,
    required this.planModel,
  });

  factory HomeModel.fromJson(Map<String, dynamic> jsonObject) {
    var appointmentList = (jsonObject['new_appointments'] as List<dynamic>?)
            ?.map((item) => NewappointmentModel.fromJson(item))
            .toList() ??
        [];
    var intelligenceTestList =
        (jsonObject['intelligence_test'] as List<dynamic>?)
                ?.map((item) => IntelligenceTestModel.fromJson(item))
                .toList() ??
            [];
    List<RecentVisitedModel> recentVisitedModelList =
        (jsonObject['recent_visited'] as List<dynamic>?)
                ?.expand((innerList) => (innerList as List<dynamic>)
                    .map((item) => RecentVisitedModel.fromJson(item)))
                .toList() ??
            [];
    var planModelList = (jsonObject['plan'] as List<dynamic>?)
            ?.map((item) => PlanModel.fromJson(item as Map<String, dynamic>))
            .toList() ??
        [];
    return HomeModel(
      newappointmentModel: appointmentList,
      intelligenceTestModel: intelligenceTestList,
      recentVisitedModel: recentVisitedModelList,
      planModel: planModelList,
    );
  }
}
