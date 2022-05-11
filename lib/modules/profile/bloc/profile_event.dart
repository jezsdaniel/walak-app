part of 'profile_bloc.dart';

@immutable
abstract class ProfileEvent {}

class ProfileEventChangePassword extends ProfileEvent {
  final String email;
  final String oldPassword;
  final String newPassword;

  ProfileEventChangePassword(this.email, this.oldPassword, this.newPassword);
}
