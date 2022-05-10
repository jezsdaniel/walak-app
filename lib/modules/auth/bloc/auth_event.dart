part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class AuthEventSignIn extends AuthEvent {
  final String email;
  final String password;

  AuthEventSignIn(this.email, this.password);
}

class AuthEventVerify extends AuthEvent {
  AuthEventVerify();
}

class AuthEventSignOut extends AuthEvent {
  AuthEventSignOut();
}
