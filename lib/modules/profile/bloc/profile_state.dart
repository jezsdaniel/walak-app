part of 'profile_bloc.dart';

@immutable
class ProfileState {
  final RequestStatus status;
  final String errorMessage;

  const ProfileState({
    this.errorMessage = '',
    this.status = RequestStatus.initial,
  });

  ProfileState copyWith({
    String? errorMessage,
    RequestStatus? status,
  }) {
    return ProfileState(
      errorMessage: errorMessage ?? '',
      status: status ?? RequestStatus.initial,
    );
  }
}
