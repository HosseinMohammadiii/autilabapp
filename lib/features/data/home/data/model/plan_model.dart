List<PlanFeatures> planFeaturesList = [
  PlanFeatures(
    planId: 0,
    description: 'Full access to the tools section',
  ),
  PlanFeatures(
    planId: 0,
    description: 'Access to aptitude test',
  ),
  PlanFeatures(
    planId: 0,
    description: 'Access to personality test',
  ),
  PlanFeatures(
    planId: 0,
    description: 'Unlimited appointment booking',
  ),
  PlanFeatures(
    planId: 0,
    description: 'Access to nearby centers',
  ),
  PlanFeatures(
    planId: 0,
    description: 'Doctor appointment booking discount',
  ),
];

class PlanModel {
  final String name;
  final double price;
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
  factory PlanModel.fromLocal(PlanType type) {
    switch (type) {
      case PlanType.free:
        return PlanModel(
          name: 'Free Plan',
          price: 0,
          description: 'Full access to the application for one week',
          planFeatures: planFeaturesList,
        );
      case PlanType.monthly:
        return PlanModel(
          name: r'99$/Month',
          price: 99,
          description: 'Full 1 month access to the application',
          planFeatures: planFeaturesList,
        );
      case PlanType.yearly:
        return PlanModel(
          name: r'299$/years',
          price: 299,
          description: 'Full one-year access to the application',
          planFeatures: planFeaturesList,
        );
    }
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

enum PlanType {
  free,
  monthly,
  yearly,
}
