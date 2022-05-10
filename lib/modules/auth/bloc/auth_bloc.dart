import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:walak/core/network/network.dart';
import 'package:walak/modules/auth/repository/auth_repository.dart';
import 'package:walak/modules/profile/models/models.dart';
import 'package:walak/modules/profile/repository/profile_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> with NetworkErrorHandler {
  final AuthRepository _authRepository;
  final ProfileRepository _userRepository;

  AuthBloc(this._authRepository, this._userRepository)
      : super(AuthState(authStatus: AuthStatus.UNKNOWN)) {
    on<AuthEventSignIn>((event, emit) async {
      emit(state.copyWith(
        authStatus: AuthStatus.UNKNOWN,
        status: RequestStatus.inProgress,
      ));
      final res = await _authRepository.signIn(event.email, event.password);
      if (res is ResultSuccess<User>) {
        emit(state.copyWith(
          authStatus: AuthStatus.AUTHENTICATED,
          status: RequestStatus.success,
          user: res.value,
        ));
      } else {
        emit(state.copyWith(
          status: RequestStatus.failure,
          error: getErrorFromResult(res),
        ));
      }
    });

    on<AuthEventVerify>((event, emit) async {
      emit(state.copyWith(
        authStatus: AuthStatus.UNKNOWN,
        status: RequestStatus.inProgress,
      ));
      final res = await _authRepository.verifyAuth();
      if (res is ResultSuccess<bool> && res.value) {
        final userRes = await _userRepository.me();
        if (userRes is ResultSuccess<User>) {
          emit(state.copyWith(
            authStatus: AuthStatus.AUTHENTICATED,
            status: RequestStatus.success,
            user: userRes.value,
          ));
        } else {
          emit(state.copyWith(
            authStatus: AuthStatus.UNAUTHENTICATED,
          ));
        }
      } else {
        emit(state.copyWith(
          authStatus: AuthStatus.UNAUTHENTICATED,
        ));
      }
    });

    on<AuthEventSignOut>((event, emit) async {
      _authRepository.signOut();
      emit(AuthState(
        authStatus: AuthStatus.UNAUTHENTICATED,
      ));
    });
  }
}
