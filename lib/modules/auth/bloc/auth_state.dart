part of 'auth_bloc.dart';

enum AuthStatus { UNKNOWN, UNAUTHENTICATED, AUTHENTICATED }

class AuthState {
  final AuthStatus authStatus;
  final User? user;

  final RequestStatus status;
  final String error;

  AuthState({
    required this.authStatus,
    this.user,
    this.status = RequestStatus.initial,
    this.error = '',
  });

  AuthState copyWith({
    AuthStatus? authStatus,
    User? user,
    RequestStatus? status,
    String? error,
  }) {
    return AuthState(
      authStatus: authStatus ?? this.authStatus,
      user: user ?? this.user,
      status: status ?? RequestStatus.initial,
      error: error ?? '',
    );
  }
}
