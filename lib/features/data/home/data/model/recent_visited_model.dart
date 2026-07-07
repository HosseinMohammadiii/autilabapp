//Recent type for local data
enum RecentType {
  childPsychiatry,
  developmentalPediatricians,
  pediatricNutrition,
  generalPractice,
  pediatricNeurologists,
  speechtherapy,
}

class RecentVisitedModel {
  final String name;
  final String imagePath;
  final String codeColor;
  RecentVisitedModel({
    required this.name,
    required this.imagePath,
    required this.codeColor,
  });
  //factory constructor for fetch data from server
  factory RecentVisitedModel.fromJson(Map<String, dynamic> jsonObject) {
    return RecentVisitedModel(
      name: jsonObject['name'] ?? '',
      imagePath: jsonObject['image_path'] ?? '',
      codeColor: jsonObject['code_color'] ?? '0xffC772FF',
    );
  }

  //factory constructor for fetch data from local
  factory RecentVisitedModel.fromLocal(RecentType type) {
    switch (type) {
      case RecentType.childPsychiatry:
        return RecentVisitedModel(
          name: 'Child Psychiatry',
          imagePath: 'assets/images/behaviorism_image.png',
          codeColor: '0xffC772FF',
        );
      case RecentType.developmentalPediatricians:
        return RecentVisitedModel(
          name: 'Developmental Pediatricians',
          imagePath: 'assets/images/pediatrician_image.png',
          codeColor: '0xff84E8FC',
        );
      case RecentType.pediatricNutrition:
        return RecentVisitedModel(
          name: 'Pediatric Nutrition',
          imagePath: 'assets/images/conversation_image.png',
          codeColor: '0xff8AEDCE',
        );
      case RecentType.generalPractice:
        return RecentVisitedModel(
          name: 'General Practice',
          imagePath: 'assets/images/Genera-Practice.png',
          codeColor: '0xffFF7979',
        );
      case RecentType.pediatricNeurologists:
        return RecentVisitedModel(
          name: 'Pediatric Neurologists',
          imagePath: 'assets/images/psychologist_image.png',
          codeColor: '0xff8A97FB',
        );
      case RecentType.speechtherapy:
        return RecentVisitedModel(
          name: 'Speech Therapy',
          imagePath: 'assets/images/speech_therapy_image.png',
          codeColor: '0xffFEBC6C',
        );
    }
  }
}
