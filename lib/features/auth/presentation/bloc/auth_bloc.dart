import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/result.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';

/// BLoC for managing authentication state and operations
/// 
/// Handles all authentication events and emits appropriate states
/// Requirements: 1.1, 1.2, 1.3, 1.4, 1.5
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(const AuthInitial()) {
    // Register event handlers
    on<AuthRegisterEvent>(_onRegister);
    on<AuthSignInEvent>(_onSignIn);
    on<AuthSignOutEvent>(_onSignOut);
    on<AuthRestoreSessionEvent>(_onRestoreSession);
    on<AuthCheckStatusEvent>(_onCheckStatus);
  }

  /// Handle user registration (Requirements 1.1, 1.3)
  Future<void> _onRegister(
    AuthRegisterEvent event,
    Emitter<AuthState> emit,
  ) async {
    // Emit loading state
    emit(const AuthLoading());

    // Call repository to register
    final result = await authRepository.register(
      email: event.email,
      password: event.password,
    );

    // Handle result
    switch (result) {
      case Success<User>():
        emit(AuthAuthenticated(user: result.data));
      case Failure<User>():
        emit(AuthError(message: result.error.toString()));
    }
  }

  /// Handle user sign in (Requirements 1.2, 1.3)
  Future<void> _onSignIn(
    AuthSignInEvent event,
    Emitter<AuthState> emit,
  ) async {
    // Emit loading state
    emit(const AuthLoading());

    // Call repository to sign in
    final result = await authRepository.signIn(
      email: event.email,
      password: event.password,
    );

    // Handle result
    switch (result) {
      case Success<User>():
        emit(AuthAuthenticated(user: result.data));
      case Failure<User>():
        emit(AuthError(message: result.error.toString()));
    }
  }

  /// Handle user sign out (Requirement 1.5)
  Future<void> _onSignOut(
    AuthSignOutEvent event,
    Emitter<AuthState> emit,
  ) async {
    // Emit loading state
    emit(const AuthLoading());

    // Call repository to sign out
    final result = await authRepository.signOut();

    // Handle result
    switch (result) {
      case Success<void>():
        emit(const AuthUnauthenticated());
      case Failure<void>():
        emit(AuthError(message: result.error.toString()));
    }
  }

  /// Handle session restoration on app start (Requirement 1.4)
  Future<void> _onRestoreSession(
    AuthRestoreSessionEvent event,
    Emitter<AuthState> emit,
  ) async {
    // Emit loading state
    emit(const AuthLoading());

    // Call repository to restore session
    final result = await authRepository.restoreSession();

    // Handle result
    switch (result) {
      case Success<User?>():
        final user = result.data;
        if (user != null) {
          emit(AuthAuthenticated(user: user));
        } else {
          emit(const AuthUnauthenticated());
        }
      case Failure<User?>():
        emit(const AuthUnauthenticated());
    }
  }

  /// Check current authentication status
  Future<void> _onCheckStatus(
    AuthCheckStatusEvent event,
    Emitter<AuthState> emit,
  ) async {
    final user = await authRepository.getCurrentUser();

    if (user != null) {
      emit(AuthAuthenticated(user: user));
    } else {
      emit(const AuthUnauthenticated());
    }
  }
}
