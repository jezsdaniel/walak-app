import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';

import 'package:walak/core/theme/theme.dart';

class AuthHeader extends StatelessWidget {
  const AuthHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      child: Column(
        children: [
          SafeArea(
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.only(top: 16),
              alignment: Alignment.topLeft,
              child: SvgPicture.asset(
                'assets/img/logo.svg',
                width: 56,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Iniciar sesión',
            style: wText.headline4!.copyWith(
              color: WColors.textContrast,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            'Por favor ingrese las credenciales de su cuenta para continuar',
            style: wText.subtitle2!.copyWith(
              color: WColors.textContrast,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
