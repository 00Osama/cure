import '../../domain/entities/user.dart';

/// Data model for User entity
/// 
/// Handles JSON serialization and conversion between data and domain layers
class UserModel {
  final String id;
  final String email;
  final String? displayName;

  const UserModel({
    required this.id,
    required this.email,
    this.displayName,
  });

  /// Create UserModel from JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      email: json['email'] as String,
      displayName: json['display_name'] as String?,
    );
  }

  /// Convert UserModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'display_name': displayName,
    };
  }

  /// Convert data model to domain entity
  User toDomain() {
    return User(
      id: id,
      email: email,
      displayName: displayName,
    );
  }

  /// Create data model from domain entity
  factory UserModel.fromDomain(User user) {
    return UserModel(
      id: user.id,
      email: user.email,
      displayName: user.displayName,
    );
  }

  @override
  String toString() => 'UserModel(id: $id, email: $email, displayName: $displayName)';
}
