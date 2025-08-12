class PlanModel {
  final String name;
  final int price;
  final String description;
  final List<PlanFeatures> planFeatures;
  PlanModel({
    required this.name,
    required this.price,
    required this.description,
    required this.planFeatures,
  });

  factory PlanModel.fromJson(Map<String, dynamic> jsonObject) {
    var planFeaturesList = (jsonObject['features'] as List<dynamic>?)
            ?.map(
              (item) => PlanFeatures.fromJson(item),
            )
            .toList() ??
        [];
    return PlanModel(
      name: jsonObject['name'],
      price: jsonObject['price'],
      description: jsonObject['description'],
      planFeatures: planFeaturesList,
    );
  }
}

class PlanFeatures {
  final int planId;
  final String description;
  PlanFeatures({
    required this.planId,
    required this.description,
  });
  factory PlanFeatures.fromJson(Map<String, dynamic> jsonObject) {
    return PlanFeatures(
      planId: jsonObject['plan_id'] ?? 0,
      description: jsonObject['description'] ?? '',
    );
  }
}
