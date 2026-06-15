import '../entities/profile.dart';

abstract class ProfileRepository {
  Future<Profile?> getProfile();

  Future<void> updateProfile({
    required String name,
    required String phoneNumber,
    required DateTime dateOfBirth,
    required String gender,
    String? yearOfExperience,
    String? region,
    String? skillSet,
    String? profileImagePath,
  });

  Future<String?> uploadProfileImage(String imagePath);

  Future<void> updateFcmToken(String token);

  Future<void> deleteAccount(String role);

  Future<void> logout();
}
