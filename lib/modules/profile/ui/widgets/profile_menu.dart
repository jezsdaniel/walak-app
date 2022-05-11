import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unicons/unicons.dart';

import 'package:walak/core/theme/theme.dart';
import 'package:walak/modules/auth/bloc/auth_bloc.dart';
import 'package:walak/modules/profile/bloc/profile_bloc.dart';
import 'package:walak/modules/profile/ui/widgets/widgets.dart';

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final profileBloc = BlocProvider.of<ProfileBloc>(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 24),
          BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              return ProfileOption(
                title: 'Cambiar contraseña',
                subtitle: 'Fortalece tu contraseña',
                icon: UniconsLine.lock_alt,
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return PasswordDialog(
                        profileBloc: profileBloc,
                        email: state.user!.email,
                      );
                    },
                  );
                },
              );
            },
          ),
          const SizedBox(height: 12),
          ProfileOption(
            title: 'Cerrar sesión',
            icon: UniconsLine.signout,
            primaryColor: WColors.error,
            onTap: () {
              context.read<AuthBloc>().add(AuthEventSignOut());
            },
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
