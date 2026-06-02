import 'package:equatable/equatable.dart';
import '../../domain/entities/user.dart';

/// Base class for all authentication states
/// 
/// Explicit separation of Initial, Loading, Success, Error states
/// as required by the architecture specification
abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

/// Initial state - no auth operation has been performed yet
class AuthInitial extends AuthState {
  const AuthInitial();
}

/// Loading state - an auth operation is in progress
class AuthLoading extends AuthState {
  const AuthLoading();
}

/// Authenticated state - user is successfully signed in
class AuthAuthenticated extends AuthState {
  final User user;

  const AuthAuthenticated({required this.user});

  @override
  List<Object?> get props => [user];
}

/// Unauthenticated state - no user is signed in
class AuthUnauthenticated extends AuthState {
  const AuthUnauthenticated();
}

/// Error state - an auth operation failed
class AuthError extends AuthState {
  final String message;

  const AuthError({required this.message});

  @override
  List<Object?> get props => [message];
}
