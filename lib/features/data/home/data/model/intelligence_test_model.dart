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
}
