import 'package:flutter/material.dart';

import 'package:unicons/unicons.dart';

import 'package:walak/core/theme/theme.dart';

class HistoryListAppBar extends StatelessWidget {
  final bool innerBoxIsScrolled;
  final TextEditingController searchController;

  const HistoryListAppBar({
    Key? key,
    required this.innerBoxIsScrolled,
    required this.searchController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      floating: true,
      forceElevated: innerBoxIsScrolled,
      centerTitle: false,
      backgroundColor: WColors.background,
      elevation: 1,
      bottom: AppBar(
        elevation: 0,
        backgroundColor: WColors.background,
        title: Container(
          height: 60,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: TextFormField(
                  controller: searchController,
                  style: wText.caption,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(UniconsLine.search),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        searchController.clear();
                      },
                      child: const Icon(UniconsLine.times_circle),
                    ),
                    hintText: 'Buscar',
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              UniconsLine.filter,
              color: WColors.textHighEmphasis,
            ),
            onPressed: () {},
          ),
          const SizedBox(width: 12),
        ],
      ),
      title: Image.asset(
        'assets/img/logo-dark.png',
        width: 48,
      ),
      actions: [
        Container(
          height: 40,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Balance disponible',
                  style: wText.caption,
                ),
                Text(
                  '\$100',
                  style: wText.subtitle2,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
