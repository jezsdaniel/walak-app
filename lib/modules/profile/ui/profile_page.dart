import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:walak/modules/profile/bloc/profile_bloc.dart';
import 'package:walak/modules/profile/repository/profile_repository.dart';
import 'package:walak/modules/profile/ui/widgets/widgets.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final profileRepository = RepositoryProvider.of<ProfileRepository>(context);
    return BlocProvider(
      create: (_) => ProfileBloc(profileRepository),
      child: Column(
        children: const [
          ProfileHeader(),
          Expanded(
            child: ProfileMenu(),
          ),
        ],
      ),
    );
  }
}
