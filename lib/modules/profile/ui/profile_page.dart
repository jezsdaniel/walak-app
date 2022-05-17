import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:walak/modules/profile/ui/widgets/widgets.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark,
    ));
    return Column(
      children: const [
        ProfileHeader(),
        Expanded(
          child: ProfileMenu(),
        ),
      ],
    );
  }
}
