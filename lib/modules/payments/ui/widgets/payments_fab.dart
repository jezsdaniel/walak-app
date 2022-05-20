import 'package:flutter/material.dart';

import 'package:unicons/unicons.dart';
import 'package:walak/modules/payments/ui/add_payment/add_payment_page.dart';

class PaymentsFab extends StatelessWidget {
  const PaymentsFab({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      label: const Text('Ingresar Pago'),
      icon: const Icon(UniconsLine.plus),
      onPressed: () {
        Navigator.push(context, AddPaymentPage.route());
      },
    );
  }
}
