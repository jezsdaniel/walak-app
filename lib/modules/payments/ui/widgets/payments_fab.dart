import 'package:flutter/material.dart';

import 'package:unicons/unicons.dart';

class PaymentsFab extends StatelessWidget {
  const PaymentsFab({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      label: const Text('Ingresar Pago'),
      icon: const Icon(UniconsLine.plus),
      onPressed: () {},
    );
  }
}
