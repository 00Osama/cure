import 'package:cure/features/auth/domain/entities/user.dart';

class Patient extends User {
  Patient({
    required super.id,
    required super.name,
    required super.email,
    required super.phoneNumber,
    required super.dateOfBirth,
    required super.gender,
    required super.profileImageUrl,
  });
}
