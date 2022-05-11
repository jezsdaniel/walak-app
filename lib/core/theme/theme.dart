import 'package:flutter/material.dart';

import 'colors.dart';
import 'shadows.dart';
import 'typography.dart';

export 'colors.dart';
export 'shadows.dart';
export 'typography.dart';

final wTheme = ThemeData(
  primaryColor: WColors.primary,
  scaffoldBackgroundColor: WColors.background,
  colorScheme: const ColorScheme.light().copyWith(
    primary: WColors.primary,
    secondary: WColors.secondary,
  ),
  textTheme: wText,
  fontFamily: 'OpenSans',
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      primary: WColors.primary,
      onPrimary: WColors.textContrast,
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      textStyle: wText.button,
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      primary: WColors.primary,
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      textStyle: wText.button,
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      primary: WColors.primary,
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 12),
      side: const BorderSide(width: 1, color: WColors.borders),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      textStyle: wText.button,
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    isDense: true,
    filled: true,
    fillColor: WColors.surface,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(
        color: WColors.borders,
      ),
    ),
  ),
  dialogTheme: DialogTheme(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
  ),
);
