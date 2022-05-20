import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:walak/core/ui/main_page.dart';
import 'package:walak/core/theme/theme.dart';
import 'package:walak/modules/auth/bloc/auth_bloc.dart';
import 'package:walak/modules/auth/repository/auth_repository.dart';
import 'package:walak/modules/auth/ui/auth_page.dart';
import 'package:walak/modules/auth/ui/splash_page.dart';
import 'package:walak/modules/payments/bloc/payments_bloc.dart';
import 'package:walak/modules/payments/repository/payments_repository.dart';
import 'package:walak/modules/profile/bloc/profile_bloc.dart';
import 'package:walak/modules/profile/repository/profile_repository.dart';
import 'package:walak/modules/source/bloc/source_bloc.dart';
import 'package:walak/modules/source/repository/source_repository.dart';

class WalakApp extends StatelessWidget {
  final AuthRepository authRepository;
  final ProfileRepository profileRepository;
  final PaymentsRepository paymentsRepository;
  final SourceRepository sourceRepository;

  WalakApp({
    Key? key,
    required this.authRepository,
    required this.profileRepository,
    required this.paymentsRepository,
    required this.sourceRepository,
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
        RepositoryProvider<PaymentsRepository>(
          create: (_) => paymentsRepository,
        ),
        RepositoryProvider<SourceRepository>(
          create: (_) => sourceRepository,
        ),
      ],
      child: BlocProvider(
        create: (_) => AuthBloc(authRepository, profileRepository),
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => ProfileBloc(profileRepository),
            ),
            BlocProvider(
              create: (context) => PaymentsBloc(paymentsRepository),
            ),
            BlocProvider(
              create: (context) => SourceBloc(sourceRepository),
            ),
          ],
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
      ),
    );
  }
}
