import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app.dart';
import 'modules/auth/repository/auth_service.dart';
import 'modules/payments/repository/payments_service.dart';
import 'modules/profile/repository/profile_service.dart';
import 'modules/services/repository/services_service.dart';
import 'modules/source/repository/source_service.dart';
import 'modules/mlc24/repository/mlc24_service.dart';

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
      mlc24Repository: MLC24Service(),
      servicesRepository: ServicesService(),
    ),
  );
}
