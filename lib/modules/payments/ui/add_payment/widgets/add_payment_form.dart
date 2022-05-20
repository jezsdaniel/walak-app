import 'package:flutter/material.dart';

import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';

import 'package:walak/core/utils/utils.dart';
import 'package:walak/modules/source/models/models.dart';

class AddPaymentForm extends StatelessWidget {
  final PaymentMethod? selectedPaymentMethod;
  final TextEditingController amountController;
  final TextEditingController codeController;
  final TextEditingController nameController;
  final void Function() onSubmit;

  const AddPaymentForm({
    Key? key,
    required this.selectedPaymentMethod,
    required this.amountController,
    required this.codeController,
    required this.nameController,
    required this.onSubmit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextFormField(
          controller: amountController,
          validator: WValidators.required(context),
          keyboardType: TextInputType.number,
          textInputAction: selectedPaymentMethod != null &&
                  selectedPaymentMethod!.requiresConfirmationCode
              ? TextInputAction.next
              : TextInputAction.done,
          onFieldSubmitted: selectedPaymentMethod != null &&
                  selectedPaymentMethod!.requiresConfirmationCode
              ? null
              : (_) => onSubmit(),
          decoration: const InputDecoration(
            labelText: 'Monto pagado',
            hintText: '\$00.00',
          ),
          inputFormatters: [
            MoneyInputFormatter(
              leadingSymbol: '\$',
            ),
          ],
        ),
        if (selectedPaymentMethod != null &&
            selectedPaymentMethod!.requiresConfirmationCode)
          Container(
            margin: const EdgeInsets.only(top: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: codeController,
                  validator: WValidators.required(context),
                  textInputAction: selectedPaymentMethod!.isCrypto
                      ? TextInputAction.done
                      : TextInputAction.next,
                  onFieldSubmitted: selectedPaymentMethod!.isCrypto
                      ? (_) => onSubmit()
                      : null,
                  decoration: InputDecoration(
                    labelText: selectedPaymentMethod!.isCrypto
                        ? 'Hash'
                        : 'ID Confirmación',
                  ),
                ),
                if (!selectedPaymentMethod!.isCrypto)
                  Container(
                    margin: const EdgeInsets.only(top: 24),
                    child: TextFormField(
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (_) => onSubmit(),
                      controller: nameController,
                      decoration: const InputDecoration(
                        labelText: 'Nombre del remitente',
                      ),
                    ),
                  ),
              ],
            ),
          ),
      ],
    );
  }
}
