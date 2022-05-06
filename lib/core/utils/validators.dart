import 'package:flutter/material.dart';

class WValidators {
  static FormFieldValidator required(BuildContext context) {
    FormFieldValidator validator;
    validator = (value) {
      if (value.toString().isEmpty) {
        return 'Obligatorio';
      }
      return null;
    };
    return validator;
  }

  static FormFieldValidator email(BuildContext context) {
    FormFieldValidator validator;
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern as String);

    validator = (value) {
      if (!regex.hasMatch(value.toString())) {
        return 'Email no válido';
      }
      return null;
    };

    return validator;
  }
}

