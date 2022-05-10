import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';

import 'package:walak/core/theme/theme.dart';

class WAlertContainer extends StatelessWidget {
  final String error;

  const WAlertContainer({
    Key? key,
    required this.error,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: WColors.errorLight,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Icon(
            UniconsLine.exclamation_triangle,
            color: WColors.error,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              error,
              style: wText.bodyText1,
            ),
          ),
        ],
      ),
    );
  }
}
