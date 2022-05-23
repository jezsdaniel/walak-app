import 'package:flutter/material.dart';

import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:intl/intl.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/widgets/widgets.dart';
import '../../models/models.dart';

class MLC24List extends StatelessWidget {
  final List<MLC24Transaction> transactions;

  const MLC24List({
    Key? key,
    required this.transactions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      separatorBuilder: (context, index) {
        return const SizedBox(height: 16);
      },
      itemCount: transactions.length,
      itemBuilder: (BuildContext context, int index) {
        final transaction = transactions[index];
        return HistoryListItem(
          title: transaction.senderName,
          subtitle:
              '\$${transaction.amountPay.toStringAsFixed(2)} | ***${transaction.cardNumber.substring(transaction.cardNumber.length - 4)}',
          status: transaction.status,
          statusMap: transactionStatusMap,
          details: {
            'ID': transaction.id.toString(),
            'No. de tarjeta': formatAsCardNumber(
              transaction.cardNumber,
              useSeparators: true,
            ),
            'Destinatario': transaction.senderName,
            'Monto MLC': '\$${transaction.amount.toStringAsFixed(2)}',
            'Comisión': '${transaction.agencyFee}%',
            'Monto depositado': '\$${transaction.amountPay.toStringAsFixed(2)}',
            'Fecha de carga':
                DateFormat('yyyy-MM-dd').format(transaction.creationDate),
          },
        );
      },
    );
  }
}
