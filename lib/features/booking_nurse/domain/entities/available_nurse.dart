class AvailableNurse {
  const AvailableNurse({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.dateOfBirth,
    required this.gender,
    required this.profileImageUrl,
    required this.yearOfExperience,
    required this.region,
    required this.skillSet,
  });

  final String id;
  final String name;
  final String email;
  final String? phoneNumber;
  final DateTime dateOfBirth;
  final String gender;
  final String profileImageUrl;
  final String? yearOfExperience;
  final String? region;
  final String? skillSet;

  int get age {
    final now = DateTime.now();
    var years = now.year - dateOfBirth.year;
    final birthdayPassed =
        now.month > dateOfBirth.month ||
        (now.month == dateOfBirth.month && now.day >= dateOfBirth.day);

    if (!birthdayPassed) years--;
    return years;
  }
}
