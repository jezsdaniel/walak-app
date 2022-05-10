import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:walak/modules/auth/bloc/auth_bloc.dart';

class MainPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const MainPage());
  }

  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            context.read<AuthBloc>().add(AuthEventSignOut());
          },
          child: const Text('Salir'),
        ),
      ),
    );
  }
}
