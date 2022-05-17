import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:walak/core/network/network.dart';
import 'package:walak/core/theme/theme.dart';
import 'package:walak/core/widgets/widgets.dart';
import 'package:walak/modules/payments/bloc/payments_bloc.dart';
import 'package:walak/modules/payments/ui/widgets/widgets.dart';

class PaymentsPage extends StatefulWidget {
  const PaymentsPage({Key? key}) : super(key: key);

  @override
  State<PaymentsPage> createState() => _PaymentsPageState();
}

class _PaymentsPageState extends State<PaymentsPage> {
  final searchController = TextEditingController();
  String searchValue = '';

  @override
  void initState() {
    super.initState();
    final fromDate = DateTime.now().subtract(const Duration(days: 7));
    final toDate = DateTime.now();

    context
        .read<PaymentsBloc>()
        .add(PaymentsEventGetPaymentsHistory(from: fromDate, to: toDate));

    searchController.addListener(() {
      setState(() {
        searchValue = searchController.text;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ));
    return BlocConsumer<PaymentsBloc, PaymentsState>(
      listener: (context, state) {
        if (state.status == RequestStatus.failure) {
          final snackBar = SnackBar(
            content: Text(
              state.errorMessage,
              style: wText.subtitle2!.copyWith(color: WColors.textContrast),
            ),
            duration: const Duration(seconds: 6),
            backgroundColor: WColors.error,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
      builder: (context, state) {
        return HistoryListLayout(
          searchController: searchController,
          isLoading: state.status == RequestStatus.inProgress,
          fab: const PaymentsFab(),
          list: PaymentsList(
            payments: searchValue != ''
                ? state.payments
                    .where(
                        (element) => element.amount.toInt().toString() == (searchValue))
                    .toList()
                : state.payments,
          ),
        );
      },
    );
  }
}
