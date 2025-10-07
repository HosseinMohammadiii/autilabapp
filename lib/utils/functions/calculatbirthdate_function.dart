//Method for calculating age by receiving the date of birth API
int calculateAge(String dateFromApi) {
  // convert DateTime to String
  DateTime? birthDate = DateTime.tryParse(dateFromApi) ?? DateTime.now();

  // DateTime now
  DateTime now = DateTime.now();

  // Year difference
  int age = now.year - birthDate.year;

  //  Check if the month/day of birth is past or not
  if (now.month < birthDate.month ||
      (now.month == birthDate.month && now.day < birthDate.day)) {
    age--;
  }

  return age;
}
