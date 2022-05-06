import 'package:flutter/material.dart';
import 'package:walak/modules/auth/ui/auth_page.dart';

import 'core/theme/theme.dart';

class WalakApp extends StatelessWidget {
  const WalakApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Walak',
      theme: wTheme,
      home: const AuthPage(),
    );
  }
}
