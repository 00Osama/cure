/// Base class for all users
class User {
  final String id;
  final String name;
  final String email;
  final String phoneNumber;
  final DateTime dateOfBirth;
  final String gender;
  String profileImageUrl;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.dateOfBirth,
    required this.gender,
    required this.profileImageUrl,
  });

  int get age {
    final now = DateTime.now();
    int age = now.year - dateOfBirth.year;
    if (now.month < dateOfBirth.month ||
        (now.month == dateOfBirth.month && now.day < dateOfBirth.day)) {
      age--;
    }
    return age;
  }
}
