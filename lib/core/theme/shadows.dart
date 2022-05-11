import 'package:flutter/material.dart';

class WShadows {
  WShadows._();

  static const List<BoxShadow> elevation1 = [
    BoxShadow(
      color: Color.fromRGBO(0, 0, 0, 0.12),
      offset: Offset(0, 2),
      blurRadius: 4,
    ),
  ];

  static const List<BoxShadow> elevation2 = [
    BoxShadow(
      color: Color.fromRGBO(0, 0, 0, 0.1),
      offset: Offset(0, 4),
      blurRadius: 8,
    ),
  ];

  static const List<BoxShadow> elevation3 = [
    BoxShadow(
      color: Color.fromRGBO(0, 0, 0, 0.06),
      offset: Offset(0, 8),
      blurRadius: 16,
    ),
  ];

  static const List<BoxShadow> elevation4 = [
    BoxShadow(
      color: Color.fromRGBO(0, 0, 0, 0.04),
      offset: Offset(0, 16),
      blurRadius: 24,
    ),
  ];
}
