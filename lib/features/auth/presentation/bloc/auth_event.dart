import 'package:equatable/equatable.dart';

/// Base class for all authentication events
abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

/// Event to register a new user
class AuthRegisterEvent extends AuthEvent {
  final String email;
  final String password;

  const AuthRegisterEvent({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [email, password];
}

/// Event to sign in an existing user
class AuthSignInEvent extends AuthEvent {
  final String email;
  final String password;

  const AuthSignInEvent({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [email, password];
}

/// Event to sign out the current user
class AuthSignOutEvent extends AuthEvent {
  const AuthSignOutEvent();
}

/// Event to restore session on app start
class AuthRestoreSessionEvent extends AuthEvent {
  const AuthRestoreSessionEvent();
}

/// Event to check current authentication status
class AuthCheckStatusEvent extends AuthEvent {
  const AuthCheckStatusEvent();
}
