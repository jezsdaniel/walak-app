import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:walak/app.dart';
import 'package:walak/modules/auth/repository/auth_demo.dart';
import 'package:walak/modules/profile/repository/profile_demo.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(
    WalakApp(
      authRepository: AuthDemo(),
      profileRepository: ProfileDemo(),
    ),
  );
}
