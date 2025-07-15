import 'dart:ui';

class CategoryItems {
  String title;
  String image;
  Color color;
  CategoryItems(this.title, this.image, this.color);
}

//Category list for display Specialties items
List<CategoryItems> categoryItemsList = [
  CategoryItems('Child Psychiatrists', 'assets/images/pediatrician_image.png',
      const Color.fromRGBO(83, 226, 255, 0.7)),
  CategoryItems('Developmental\nPediatricians',
      'assets/images/behaviorism_image.png', const Color(0xffC772FF)),
  CategoryItems('Nutritionists', 'assets/images/physiotherapy_image.png',
      const Color(0xffFF7272)),
  CategoryItems('Physiotherapy', 'assets/images/conversation_image.png',
      const Color(0xff8AEDCE)),
  CategoryItems('Pediatric\nNeurologists',
      'assets/images/psychologist_image.png', const Color(0xff5669FF)),
  CategoryItems('Speech Therapy', 'assets/images/speech_therapy_image.png',
      const Color(0xffFFB253)),
];
