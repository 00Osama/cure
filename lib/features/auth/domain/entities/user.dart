/// Base class for all users
abstract class User {
  final String id;
  final String name;
  final String email;
  final String? phoneNumber;
  final DateTime dateOfBirth;
  final String gender;

  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.dateOfBirth,
    required this.gender,
  });
}
