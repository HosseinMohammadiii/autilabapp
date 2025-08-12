class RecentVisitedModel {
  final String name;
  final String imagePath;
  RecentVisitedModel({
    required this.name,
    required this.imagePath,
  });

  factory RecentVisitedModel.fromJson(Map<String, dynamic> jsonObject) {
    return RecentVisitedModel(
      name: jsonObject['name'],
      imagePath: jsonObject['image_path'],
    );
  }
}
