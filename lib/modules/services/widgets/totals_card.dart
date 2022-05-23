import 'package:flutter/material.dart';

import '../../../core/theme/theme.dart';

class TotalsCard extends StatelessWidget {
  final Map<String, String> totals;
  final double totalAmount;

  const TotalsCard({
    Key? key,
    required this.totals,
    required this.totalAmount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(
          color: WColors.borders,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(12),
        color: WColors.surface,
      ),
      child: Column(
        children: [
          ...totals.entries.map((entry) {
            final String key = entry.key;
            final String value = entry.value;
            return Container(
              margin: const EdgeInsets.only(bottom: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    key,
                    style: wText.bodyText1,
                  ),
                  Text(
                    value,
                    style: wText.bodyText1,
                  ),
                ],
              ),
            );
          }).toList(),
          const Divider(),
          Container(
            margin: const EdgeInsets.only(top: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total a pagar',
                  style: wText.bodyText1!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '\$${totalAmount.toStringAsFixed(2)}',
                  style: wText.bodyText1!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
