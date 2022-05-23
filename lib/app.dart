import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/ui/main_page.dart';
import 'core/theme/theme.dart';
import 'modules/auth/bloc/auth_bloc.dart';
import 'modules/auth/repository/auth_repository.dart';
import 'modules/auth/ui/auth_page.dart';
import 'modules/auth/ui/splash_page.dart';
import 'modules/payments/bloc/payments_bloc.dart';
import 'modules/payments/repository/payments_repository.dart';
import 'modules/profile/bloc/profile_bloc.dart';
import 'modules/profile/repository/profile_repository.dart';
import 'modules/services/repository/services_repository.dart';
import 'modules/source/bloc/source_bloc.dart';
import 'modules/source/repository/source_repository.dart';

import 'modules/mlc24/bloc/mlc24_bloc.dart';
import 'modules/mlc24/repository/mlc24_repository.dart';

class WalakApp extends StatelessWidget {
  final AuthRepository authRepository;
  final ProfileRepository profileRepository;
  final PaymentsRepository paymentsRepository;
  final SourceRepository sourceRepository;
  final MLC24Repository mlc24Repository;
  final ServicesRepository servicesRepository;

  WalakApp({
    Key? key,
    required this.authRepository,
    required this.profileRepository,
    required this.paymentsRepository,
    required this.sourceRepository,
    required this.mlc24Repository,
    required this.servicesRepository,
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
        RepositoryProvider<MLC24Repository>(
          create: (_) => mlc24Repository,
        ),
        RepositoryProvider<ServicesRepository>(
          create: (_) => servicesRepository,
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
            BlocProvider(
              create: (context) => MLC24Bloc(mlc24Repository, servicesRepository),
            ),
          ],
          child: MaterialApp(
            title: 'Walak',
            theme: wTheme,
            scrollBehavior: const CupertinoScrollBehavior(),
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
