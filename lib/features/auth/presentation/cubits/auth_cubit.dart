import 'package:cure/features/auth/domain/entities/user.dart';
import 'package:cure/features/auth/domain/usecase/auth_usecase.dart';
import 'package:cure/shared/utils/result.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class Authenticated extends AuthState {
  final User user;

  Authenticated(this.user);
}

class Unauthenticated extends AuthState {}

class AuthError extends AuthState {
  final String message;

  AuthError(this.message);
}

class AuthCubit extends Cubit<AuthState> {
  final AuthUseCase authUseCase;

  AuthCubit({required this.authUseCase}) : super(AuthInitial());

  Future<void> checkAuthStatus() async {
    emit(AuthLoading());
    try {
      final user = await authUseCase.getCurrentUser();

      if (user != null) {
        emit(Authenticated(user));
      } else {
        emit(Unauthenticated());
      }
    } catch (e) {
      emit(AuthError('Failed to check auth status: $e'));
    }
  }

  Future<void> signIn(String email, String password) async {
    emit(AuthLoading());

    final result = await authUseCase.signInUseCase(
      email: email,
      password: password,
    );

    if (result is Success<User>) {
      emit(Authenticated(result.data));
    } else if (result is Failure<User>) {
      emit(AuthError(result.error.toString()));
    } else {
      emit(AuthError('Unexpected sign-in result.'));
    }
  }

  Future<void> signOut() async {
    emit(AuthLoading());

    final result = await authUseCase.signOutUseCase();

    if (result is Success<void>) {
      emit(Unauthenticated());
    } else if (result is Failure<void>) {
      emit(AuthError(result.error.toString()));
    } else {
      emit(AuthError('Unexpected sign-out result.'));
    }
  }

  Future<void> restoreSession() async {
    emit(AuthLoading());

    final result = await authUseCase.restoreSession();

    if (result is Success<User?>) {
      final user = result.data;
      if (user != null) {
        emit(Authenticated(user));
      } else {
        emit(Unauthenticated());
      }
    } else if (result is Failure<User?>) {
      emit(AuthError(result.error.toString()));
    } else {
      emit(AuthError('Unexpected restore session result.'));
    }
  }
}
