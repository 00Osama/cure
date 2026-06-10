class Profile {
  const Profile({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.dateOfBirth,
    required this.gender,
    required this.profileImagePath,
    required this.role,
    this.yearOfExperience,
    this.region,
    this.skillSet,
  });

  final String id;
  final String name;
  final String email;
  final String? phoneNumber;
  final DateTime dateOfBirth;
  final String gender;
  final String profileImagePath;
  final String role;
  final String? yearOfExperience;
  final String? region;
  final String? skillSet;

  bool get isNurse => role.toLowerCase() == 'nurse';
}
