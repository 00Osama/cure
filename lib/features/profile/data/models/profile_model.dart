import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/profile.dart';

class ProfileModel {
  const ProfileModel({
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

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      email: json['email'] as String? ?? '',
      phoneNumber: json['phone_number'] as String?,
      dateOfBirth: _parseDate(json['date_of_birth']),
      gender: json['gender'] as String? ?? '',
      role: json['role'] as String? ?? 'patient',
      profileImagePath: json['profile_image_url'] as String? ?? 'default',
      yearOfExperience: json['year_of_experience'] as String?,
      region: json['region'] as String?,
      skillSet: json['skill_set'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone_number': phoneNumber,
      'date_of_birth': dateOfBirth.toIso8601String(),
      'gender': gender,
      'role': role,
      'year_of_experience': yearOfExperience,
      'region': region,
      'skill_set': skillSet,
      'profile_image_url': profileImagePath,
    };
  }

  Profile toEntity() {
    return Profile(
      id: id,
      name: name,
      email: email,
      phoneNumber: phoneNumber,
      dateOfBirth: dateOfBirth,
      gender: gender,
      profileImagePath: profileImagePath,
      role: role,
      yearOfExperience: yearOfExperience,
      region: region,
      skillSet: skillSet,
    );
  }
}

DateTime _parseDate(Object? value) {
  if (value is Timestamp) return value.toDate();
  if (value is DateTime) return value;
  if (value is String && value.isNotEmpty) {
    return DateTime.tryParse(value) ?? DateTime.now();
  }
  return DateTime.now();
}
