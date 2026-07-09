//Local List
List<IntelligenceTestModel> intelligenceTestList = [
  IntelligenceTestModel.fromLocal(IntelligenceType.artistic),
  IntelligenceTestModel.fromLocal(IntelligenceType.enterprising),
  IntelligenceTestModel.fromLocal(IntelligenceType.investigator),
  IntelligenceTestModel.fromLocal(IntelligenceType.social),
  IntelligenceTestModel.fromLocal(IntelligenceType.realistic),
  IntelligenceTestModel.fromLocal(IntelligenceType.conventional),
];

class IntelligenceTestModel {
  final String type;
  final double percentage;
  IntelligenceTestModel({
    required this.type,
    required this.percentage,
  });

  factory IntelligenceTestModel.fromJson(Map<String, dynamic> jsonObject) {
    return IntelligenceTestModel(
      type: jsonObject['type'],
      percentage: jsonObject['percentage'],
    );
  }

  factory IntelligenceTestModel.fromLocal(IntelligenceType type) {
    switch (type) {
      case IntelligenceType.artistic:
        return IntelligenceTestModel(
          type: 'Artistic',
          percentage: 20,
        );
      case IntelligenceType.enterprising:
        return IntelligenceTestModel(
          type: 'Enterprising',
          percentage: 45.5,
        );
      case IntelligenceType.investigator:
        return IntelligenceTestModel(
          type: 'Investigator',
          percentage: 80.8,
        );
      case IntelligenceType.social:
        return IntelligenceTestModel(
          type: 'Social',
          percentage: 45.5,
        );
      case IntelligenceType.realistic:
        return IntelligenceTestModel(
          type: 'Realistic',
          percentage: 50,
        );
      case IntelligenceType.conventional:
        return IntelligenceTestModel(
          type: 'Conventional',
          percentage: 10.5,
        );
    }
  }
}

enum IntelligenceType {
  artistic,
  enterprising,
  investigator,
  social,
  realistic,
  conventional,
}
