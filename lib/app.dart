import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:walak/core/ui/main_page.dart';
import 'package:walak/core/theme/theme.dart';
import 'package:walak/modules/auth/bloc/auth_bloc.dart';
import 'package:walak/modules/auth/repository/auth_repository.dart';
import 'package:walak/modules/auth/ui/auth_page.dart';
import 'package:walak/modules/auth/ui/splash_page.dart';
import 'package:walak/modules/profile/repository/profile_repository.dart';

class WalakApp extends StatelessWidget {
  final AuthRepository authRepository;
  final ProfileRepository profileRepository;

  WalakApp({
    Key? key,
    required this.authRepository,
    required this.profileRepository,
  }) : super(key: key);

  final _navigatorKey = GlobalKey<NavigatorState>();
  NavigatorState get _navigator => _navigatorKey.currentState!;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>(
          create: (_) => authRepository,
        ),
        RepositoryProvider<ProfileRepository>(
          create: (_) => profileRepository,
        ),
      ],
      child: BlocProvider(
        create: (_) => AuthBloc(authRepository, profileRepository),
        child: MaterialApp(
          title: 'Walak',
          theme: wTheme,
          navigatorKey: _navigatorKey,
          onGenerateRoute: (_) => SplashPage.route(),
          builder: (context, child) {
            return BlocListener<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state.authStatus == AuthStatus.AUTHENTICATED) {
                  _navigator.pushAndRemoveUntil<void>(
                      MainPage.route(), (route) => false);
                }
                if (state.authStatus == AuthStatus.UNAUTHENTICATED) {
                  _navigator.pushAndRemoveUntil<void>(
                      AuthPage.route(), (route) => false);
                }
              },
              child: child,
            );
          },
        ),
      ),
    );
  }
}
