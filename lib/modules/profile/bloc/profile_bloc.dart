import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:walak/core/network/network.dart';
import 'package:walak/modules/profile/repository/profile_repository.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState>
    with NetworkErrorHandler {
  final ProfileRepository profileRepository;

  ProfileBloc(this.profileRepository) : super(const ProfileState()) {
    on<ProfileEventChangePassword>((event, emit) async {
      emit(state.copyWith(status: RequestStatus.inProgress));
      final res = await profileRepository.changePassword(
        event.email,
        event.oldPassword,
        event.newPassword,
      );
      if (res is ResultSuccess<bool> && res.value) {
        emit(state.copyWith(status: RequestStatus.success));
      } else {
        emit(
          state.copyWith(
            errorMessage: getErrorFromResult(res),
            status: RequestStatus.failure,
          ),
        );
      }
    });
  }
}
