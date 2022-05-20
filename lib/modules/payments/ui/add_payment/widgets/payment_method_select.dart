import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';

import 'package:walak/modules/source/models/models.dart';

class PaymentMethodSelect extends StatelessWidget {
  final List<PaymentMethod> paymentMethods;
  final PaymentMethod? selectedPaymentMethod;
  final void Function(PaymentMethod?) onChange;

  const PaymentMethodSelect({
    Key? key,
    required this.paymentMethods,
    required this.selectedPaymentMethod,
    required this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InputDecorator(
      decoration: const InputDecoration(
        labelText: 'Método de pago',
      ),
      isEmpty: selectedPaymentMethod == null,
      child: DropdownButtonHideUnderline(
        child: DropdownButton<PaymentMethod>(
          value: selectedPaymentMethod,
          isDense: true,
          onChanged: (PaymentMethod? newValue) {
            onChange(newValue);
          },
          items: paymentMethods.map((PaymentMethod paymentMethod) {
            return DropdownMenuItem<PaymentMethod>(
              value: paymentMethod,
              child: Row(
                children: [
                  SvgPicture.asset(
                    paymentMethod.icon,
                    width: 24,
                  ),
                  const SizedBox(width: 8),
                  Text(paymentMethod.title),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
