import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/available_nurse.dart';

class AvailableNurseModel {
  const AvailableNurseModel({
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

  factory AvailableNurseModel.fromJson(Map<String, dynamic> json) {
    return AvailableNurseModel(
      id: _readString(json['id']),
      name: _readString(json['name']),
      email: _readString(json['email']),
      phoneNumber: json['phone_number'] as String?,
      dateOfBirth: _readDate(json['date_of_birth']),
      gender: _readString(json['gender']),
      profileImageUrl: _readString(json['profile_image_url']),
      yearOfExperience: json['year_of_experience'] as String?,
      region: json['region'] as String?,
      skillSet: json['skill_set'] as String?,
    );
  }

  AvailableNurse toEntity() {
    return AvailableNurse(
      id: id,
      name: name,
      email: email,
      phoneNumber: phoneNumber,
      dateOfBirth: dateOfBirth,
      gender: gender,
      profileImageUrl: profileImageUrl,
      yearOfExperience: yearOfExperience,
      region: region,
      skillSet: skillSet,
    );
  }

  static DateTime _readDate(Object? value) {
    if (value is Timestamp) return value.toDate();
    if (value is String && value.isNotEmpty) return DateTime.parse(value);
    return DateTime(2000);
  }

  static String _readString(Object? value) {
    if (value == null) return '';
    return value.toString();
  }
}
