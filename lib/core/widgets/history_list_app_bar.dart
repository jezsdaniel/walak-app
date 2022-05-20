import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unicons/unicons.dart';

import 'package:walak/core/theme/theme.dart';
import 'package:walak/modules/source/bloc/source_bloc.dart';

class HistoryListAppBar extends StatelessWidget {
  final bool innerBoxIsScrolled;
  final TextEditingController searchController;
  final Widget? filters;
  final void Function()? onFilter;

  const HistoryListAppBar({
    Key? key,
    required this.innerBoxIsScrolled,
    required this.searchController,
    this.filters,
    this.onFilter,
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
          if (filters != null)
            Container(
              margin: const EdgeInsets.only(left: 8, right: 16),
              child: IconButton(
                icon: const Icon(
                  UniconsLine.filter,
                  color: WColors.textHighEmphasis,
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Filtros'),
                        content: filters!,
                        actions: [
                          Container(
                            margin: const EdgeInsets.all(12),
                            width: double.infinity,
                            child: OutlinedButton(
                              onPressed: () {
                                onFilter?.call();
                                Navigator.of(context).pop();
                              },
                              child: const Text('Listo'),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
        ],
      ),
      title: Image.asset(
        'assets/img/logo-dark.png',
        width: 48,
      ),
      actions: [
        BlocBuilder<SourceBloc, SourceState>(
          builder: (context, state) {
            if (state.balance != null) {
              return Container(
                height: 40,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                        '\$${state.balance!.availableBalance.toStringAsFixed(2)}',
                        style: wText.subtitle2,
                      ),
                    ],
                  ),
                ),
              );
            }
            return Container();
          },
        ),
      ],
    );
  }
}
