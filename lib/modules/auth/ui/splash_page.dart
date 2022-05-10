import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:walak/core/network/network.dart';

import 'package:walak/core/theme/theme.dart';
import 'package:walak/modules/auth/bloc/auth_bloc.dart';

class SplashPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const SplashPage());
  }

  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    NetworkHandler().init(
      authBloc: BlocProvider.of<AuthBloc>(context),
    );
    context.read<AuthBloc>().add(AuthEventVerify());
    return const Scaffold(
      backgroundColor: WColors.secondaryVariant,
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
