import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:walak/app.dart';
import 'package:walak/modules/auth/repository/auth_service.dart';
import 'package:walak/modules/payments/repository/payments_service.dart';
import 'package:walak/modules/profile/repository/profile_service.dart';
import 'package:walak/modules/source/repository/source_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(
    WalakApp(
      authRepository: AuthService(),
      profileRepository: ProfileService(),
      paymentsRepository: PaymentsService(),
      sourceRepository: SourceService(),
    ),
  );
}
