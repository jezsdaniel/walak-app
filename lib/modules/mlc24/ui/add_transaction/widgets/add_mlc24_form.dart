import 'package:flutter/material.dart';

import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';

import '../../../../../core/utils/utils.dart';

class AddMLC24Form extends StatelessWidget {
  final TextEditingController cardController;
  final TextEditingController nameController;
  final TextEditingController amountController;
  final void Function() onSubmit;

  const AddMLC24Form({
    Key? key,
    required this.cardController,
    required this.nameController,
    required this.amountController,
    required this.onSubmit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextFormField(
          controller: cardController,
          validator: WValidators.onlyNumbersAndSpaces(context),
          keyboardType: TextInputType.number,
          textInputAction: TextInputAction.next,
          decoration: const InputDecoration(
            labelText: 'Número de tarjeta',
          ),
          inputFormatters: [
            MaskedInputFormatter(
              '#### #### #### ####',
            ),
          ],
        ),
        const SizedBox(height: 24),
        TextFormField(
          controller: nameController,
          validator: WValidators.required(context),
          textCapitalization: TextCapitalization.words,
          textInputAction: TextInputAction.next,
          decoration: const InputDecoration(
            labelText: 'Nombre y apellidos del titular',
          ),
        ),
        const SizedBox(height: 24),
        TextFormField(
          controller: amountController,
          validator: WValidators.moneyWithoutDecimals(context),
          keyboardType: TextInputType.number,
          textInputAction: TextInputAction.done,
          onFieldSubmitted: (_) => onSubmit(),
          decoration: const InputDecoration(
            labelText: 'Cantidad a enviar',
            hintText: '\$00.00',
          ),
          inputFormatters: [
            MoneyInputFormatter(
              leadingSymbol: '\$',
              thousandSeparator: ThousandSeparator.None,
            ),
          ],
        ),
      ],
    );
  }
}
