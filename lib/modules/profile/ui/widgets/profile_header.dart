import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:walak/core/theme/theme.dart';
import 'package:walak/core/utils/user_type.dart';
import 'package:walak/modules/auth/bloc/auth_bloc.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(32)),
        color: WColors.secondaryVariant,
      ),
      child: SafeArea(
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            return Column(
              children: [
                Text(
                  getUserTypeName(state.user!.userType).toUpperCase(),
                  style: wText.caption!.copyWith(
                    color: WColors.textContrast,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  state.user!.name,
                  style: wText.headline5!.copyWith(
                    color: WColors.textContrast,
                  ),
                ),
                Text(
                  state.user!.email,
                  style: wText.subtitle2!.copyWith(
                    color: WColors.textContrast,
                  ),
                ),
                const SizedBox(height: 12),
              ],
            );
          },
        ),
      ),
    );
  }
}
