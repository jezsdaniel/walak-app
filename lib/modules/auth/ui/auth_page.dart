import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:walak/core/theme/theme.dart';
import 'package:walak/modules/auth/ui/widgets/widgets.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark,
    ));
    return Scaffold(
      backgroundColor: WColors.secondaryVariant,
      body: SingleChildScrollView(
        child: Column(
          children: const [
            AuthHeader(),
            SizedBox(height: 16),
            AuthForm(),
          ],
        ),
      ),
    );
  }
}
