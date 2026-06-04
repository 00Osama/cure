import 'package:cure/features/auth/domain/entities/user.dart';
import 'package:cure/features/auth/domain/entities/patient.dart';
import 'package:cure/features/auth/domain/entities/nurse.dart';

class UserModel {
  final String id;
  final String name;
  final String email;
  final String? phoneNumber;
  final DateTime dateOfBirth;
  final String gender;

  final String role;

  final String? yearOfExperience;
  final String? region;
  final String? skillSet;

  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.dateOfBirth,
    required this.gender,
    required this.role,
    this.yearOfExperience,
    this.region,
    this.skillSet,
  });

  // =========================
  // FROM JSON
  // =========================
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phoneNumber: json['phone_number'],
      dateOfBirth: DateTime.parse(json['date_of_birth']),
      gender: json['gender'],
      role: json['role'],

      yearOfExperience: json['year_of_experience'],
      region: json['region'],
      skillSet: json['skill_set'],
    );
  }

  // =========================
  // TO JSON
  // =========================
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone_number': phoneNumber,
      'date_of_birth': dateOfBirth.toIso8601String(),
      'gender': gender,
      'role': role,

      // nurse fields (nullable for patient)
      'year_of_experience': yearOfExperience,
      'region': region,
      'skill_set': skillSet,
    };
  }

  // =========================
  // FROM DOMAIN
  // =========================
  factory UserModel.fromDomain(User user) {
    if (user is Nurse) {
      return UserModel(
        id: user.id,
        name: user.name,
        email: user.email,
        phoneNumber: user.phoneNumber,
        dateOfBirth: user.dateOfBirth,
        gender: user.gender,
        role: 'nurse',
        yearOfExperience: user.yearOfExperience,
        region: user.region,
        skillSet: user.skillSet,
      );
    }

    return UserModel(
      id: user.id,
      name: user.name,
      email: user.email,
      phoneNumber: user.phoneNumber,
      dateOfBirth: user.dateOfBirth,
      gender: user.gender,
      role: 'patient',
    );
  }

  // =========================
  // TO DOMAIN
  // =========================
  User toDomain() {
    if (role == 'nurse') {
      return Nurse(
        id: id,
        name: name,
        email: email,
        phoneNumber: phoneNumber,
        dateOfBirth: dateOfBirth,
        gender: gender,
        yearOfExperience: yearOfExperience,
        region: region,
        skillSet: skillSet,
      );
    }

    return Patient(
      id: id,
      name: name,
      email: email,
      phoneNumber: phoneNumber,
      dateOfBirth: dateOfBirth,
      gender: gender,
    );
  }
}
