import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unicons/unicons.dart';

import 'package:walak/core/theme/theme.dart';
import 'package:walak/modules/source/bloc/source_bloc.dart';

class SectionAppBar extends StatelessWidget {

  const SectionAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      floating: true,
      centerTitle: false,
      backgroundColor: WColors.background,
      elevation: 1,
      leading: IconButton(
        icon: const Icon(UniconsLine.angle_left, color: WColors.text),
        onPressed: () {
          Navigator.pop(context);
        },
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
