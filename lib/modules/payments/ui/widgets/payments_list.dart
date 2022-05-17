import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import 'package:walak/core/constants/constants.dart';
import 'package:walak/core/widgets/widgets.dart';
import 'package:walak/modules/payments/models/models.dart';

class PaymentsList extends StatelessWidget {
  final List<SourceTransaction> payments;

  const PaymentsList({
    Key? key,
    required this.payments,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      separatorBuilder: (context, index) {
        return const SizedBox(height: 16);
      },
      itemCount: payments.length,
      itemBuilder: (BuildContext context, int index) {
        final payment = payments[index];
        String subtitle = '';
        if (payment.paymentMethod.title != '') {
          subtitle += payment.paymentMethod.title;
          if (payment.verificationCode != '') {
            subtitle += ' | ';
          }
        }
        subtitle += payment.verificationCode ?? '';
        return HistoryListItem(
          title: '\$${payment.amount.toStringAsFixed(2)}',
          subtitle: subtitle != '' ? subtitle : null,
          status: payment.status,
          statusMap: transactionStatusMap,
          details: {
            'ID': payment.id.toString(),
            'ID de confirmación': payment.verificationCode ?? '',
            'Remitente': payment.senderName ?? '',
            'Monto': '\$${payment.amount.toStringAsFixed(2)}',
            'Método de pago': payment.paymentMethod.title,
            'Fecha': DateFormat('yyyy-MM-dd').format(payment.creationDate),
          },
        );
      },
    );
  }
}
