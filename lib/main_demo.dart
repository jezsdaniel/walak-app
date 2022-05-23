import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app.dart';
import 'modules/auth/repository/auth_demo.dart';
import 'modules/payments/repository/payments_demo.dart';
import 'modules/profile/repository/profile_demo.dart';
import 'modules/source/repository/source_demo.dart';
import 'modules/mlc24/repository/mlc24_demo.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(
    WalakApp(
      authRepository: AuthDemo(),
      profileRepository: ProfileDemo(),
      paymentsRepository: PaymentsDemo(),
      sourceRepository: SourceDemo(),
      mlc24Repository: MLC24Demo(),
    ),
  );
}
