class RecentVisitedModel {
  final String name;
  final String imagePath;
  final String codeColor;
  RecentVisitedModel({
    required this.name,
    required this.imagePath,
    required this.codeColor,
  });

  factory RecentVisitedModel.fromJson(Map<String, dynamic> jsonObject) {
    return RecentVisitedModel(
      name: jsonObject['name'] ?? '',
      imagePath: jsonObject['image_path'] ?? '',
      codeColor: jsonObject['code_color'] ?? '0xffC772FF',
    );
  }
}
