import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';

import 'package:walak/core/theme/theme.dart';

class HistoryListItem extends StatelessWidget {
  final String title;
  final String? subtitle;
  final int? status;
  final Map<int, String>? statusMap;
  final Map<String, String> details;

  const HistoryListItem({
    Key? key,
    required this.title,
    this.subtitle,
    this.status,
    this.statusMap,
    this.details = const {},
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color labelColor = WColors.secondary;
    String mappedStatus = '';

    if (status != null && statusMap != null) {
      mappedStatus = statusMap![status]!;
      switch (mappedStatus) {
        case 'pendiente':
          labelColor = WColors.secondary;
          break;
        case 'en proceso':
          labelColor = WColors.warning;
          break;
        case 'entregada':
          labelColor = WColors.primary;
          break;
        case 'completada':
          labelColor = WColors.primary;
          break;
        case 'cancelada':
          labelColor = WColors.error;
          break;
        case 'rechazada':
          labelColor = WColors.error;
          break;
        default:
      }
    }

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        boxShadow: WShadows.elevation4,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Container(
          width: double.infinity,
          height: 78,
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          decoration: BoxDecoration(
            border: Border(
              left: BorderSide(
                color: labelColor,
                width: 6,
              ),
            ),
            color: WColors.surface,
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: wText.subtitle2,
                    ),
                    if (subtitle != null)
                      Container(
                        margin: const EdgeInsets.only(top: 8),
                        child: Text(
                          subtitle!,
                          style: wText.caption!.copyWith(
                            color: WColors.textMediumEmphasis,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(width: 4),
              if (details.isNotEmpty)
                IconButton(
                  icon: const Icon(
                    UniconsLine.file_search_alt,
                    color: WColors.primary,
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                                child: Text(
                              'Detalles',
                              style: wText.subtitle2,
                            )),
                            if (mappedStatus != '')
                              Chip(
                                label: Text(
                                  mappedStatus,
                                ),
                                labelStyle: wText.caption!.copyWith(
                                  color: WColors.textContrast,
                                ),
                                backgroundColor: labelColor,
                                visualDensity: VisualDensity.compact,
                              ),
                          ],
                        ),
                        content: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              for (final entry in details.entries
                                  .where((element) => element.value != ''))
                                Container(
                                  margin: const EdgeInsets.only(bottom: 12),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        entry.key.toUpperCase(),
                                        style: wText.bodyText2!.copyWith(
                                          color: WColors.textMediumEmphasis,
                                        ),
                                      ),
                                      Text(
                                        entry.value,
                                        style: wText.bodyText1!.copyWith(
                                          color: WColors.textHighEmphasis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        ),
                        actions: [
                          Container(
                            width: 90,
                            margin: const EdgeInsets.all(12),
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                primary: WColors.error,
                              ),
                              onPressed: () => Navigator.of(context).pop(),
                              child: const Text('Cerrar'),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}
