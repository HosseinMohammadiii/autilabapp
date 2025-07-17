import 'dart:ui';

class CategoryItems {
  String title;
  String image;
  Color color;
  CategoryItems(this.title, this.image, this.color);
}

//Category list for display Specialties items
List<CategoryItems> categoryItemsList = [
  CategoryItems('Child\nPsychiatrists', 'assets/images/behaviorism_image.png',
      const Color(0xffD18EFD)),
  CategoryItems('Developmental\nPediatricians',
      'assets/images/pediatrician_image.png', const Color(0xff9BEBFB)),
  CategoryItems('Pediatric\nNutrition', 'assets/images/conversation_image.png',
      const Color(0xff9FEFD6)),
  CategoryItems('General\nPractice', 'assets/images/Genera-Practice.png',
      const Color(0xffFF8B8B)),
  CategoryItems('Pediatric\nNeurologists',
      'assets/images/psychologist_image.png', const Color(0xffABB4FA)),
  CategoryItems('Speech\nTherapy', 'assets/images/speech_therapy_image.png',
      const Color(0xffFCC787)),
];
