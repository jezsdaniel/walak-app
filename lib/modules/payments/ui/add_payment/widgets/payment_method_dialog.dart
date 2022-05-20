import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';

import 'package:walak/core/theme/theme.dart';
import 'package:walak/modules/source/models/models.dart';

class PaymentMethodDetailsDialog extends StatelessWidget {
  const PaymentMethodDetailsDialog({
    Key? key,
    required PaymentMethod? selectedPaymentMethod,
  })  : _selectedPaymentMethod = selectedPaymentMethod,
        super(key: key);

  final PaymentMethod? _selectedPaymentMethod;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SvgPicture.asset(
            _selectedPaymentMethod!.icon,
            width: 24,
          ),
          const SizedBox(width: 8),
          Text(_selectedPaymentMethod!.title),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Detalle',
            style: wText.bodyText2!.copyWith(
              color: WColors.textMediumEmphasis,
            ),
          ),
          Text(
            _selectedPaymentMethod!.url ?? '',
            style: wText.bodyText1!.copyWith(
              color: WColors.textHighEmphasis,
            ),
          ),
        ],
      ),
      actions: [
        Container(
          margin: const EdgeInsets.all(12),
          width: double.infinity,
          child: OutlinedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Listo'),
          ),
        ),
      ],
    );
  }
}
