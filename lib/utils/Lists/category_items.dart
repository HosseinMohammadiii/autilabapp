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
      const Color(0xffC772FF)),
  CategoryItems(
      'Developmental\nPediatricians',
      'assets/images/pediatrician_image.png',
      const Color.fromRGBO(83, 226, 255, 0.7)),
  CategoryItems('Pediatric\nNutrition', 'assets/images/conversation_image.png',
      const Color(0xff8AEDCE)),
  CategoryItems('General\nPractice', 'assets/images/Genera-Practice.png',
      const Color(0xffFF7272)),
  CategoryItems('Pediatric\nNeurologists',
      'assets/images/psychologist_image.png', const Color(0xff5669FF)),
  CategoryItems('Speech\nTherapy', 'assets/images/speech_therapy_image.png',
      const Color(0xffFFB253)),
];
