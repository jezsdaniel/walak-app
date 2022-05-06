import 'package:flutter/material.dart';

class WColors {
  WColors._();

  static const primary = Color(0xff00CC99);
  static const primaryVariant = Color(0xff00A463);

  static const secondary = Color(0xff0EA7DA);
  static const secondaryVariant = Color(0xff0C1C33);

  static const background = Color(0xffFAFAFA);
  static const surface = Color(0xffFFFFFF);

  static const success = Color(0xff00B46E);
  static const error = Color(0xffD50000);
  static const warning = Color(0xffFFC400);

  static const text = Color(0xff050505);
  static const textHighEmphasis = Color(0xff212121);
  static const textMediumEmphasis = Color(0xff616161);
  static const textDisable = Color(0xffBDBDBD);
  static const textContrast = Color(0xffFFFFFF);

  static const borders = Color(0xffE6E6E6);

  static const grays = MaterialColor(0xff9E9E9E, {
    900: Color(0xff212121),
    800: Color(0xff424242),
    700: Color(0xff616161),
    600: Color(0xff757575),
    500: Color(0xff9E9E9E),
    400: Color(0xffBDBDBD),
    300: Color(0xffE0E0E0),
    200: Color(0xFFEEEEEE),
    100: Color(0xffF5F5F5),
  });
}
