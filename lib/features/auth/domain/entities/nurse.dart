import 'package:cure/features/auth/domain/entities/user.dart';

class Nurse extends User {
  final String? yearOfExperience;
  final String? region;
  final String? skillSet;

  Nurse({
    required super.id,
    required super.name,
    required super.email,
    required super.phoneNumber,
    required super.dateOfBirth,
    required super.gender,
    required super.profileImageUrl,
    required this.yearOfExperience,
    required this.region,
    required this.skillSet,
  });
}
