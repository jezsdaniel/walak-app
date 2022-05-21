import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:unicons/unicons.dart';

import 'package:walak/core/constants/constants.dart';
import 'package:walak/core/network/network.dart';
import 'package:walak/core/theme/theme.dart';
import 'package:walak/core/widgets/widgets.dart';
import 'package:walak/core/utils/utils.dart';
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

  DateTime fromDate = DateTime.now().subtract(const Duration(days: 7));
  DateTime toDate = DateTime.now();

  Map<int, String> statusOptions = {
    -1: 'Todos',
  };
  int status = -1;

  bool filter = false;

  @override
  void initState() {
    super.initState();

    context
        .read<PaymentsBloc>()
        .add(PaymentsEventGetPaymentsHistory(from: fromDate, to: toDate));

    searchController.addListener(() {
      setState(() {
        searchValue = searchController.text;
      });
    });

    transactionStatusMap.forEach((key, value) {
      statusOptions[key] = value;
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
          isLoading: state.status == RequestStatus.inProgress,
          body: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                HistoryListAppBar(
                  filters: StatefulBuilder(builder: (
                    BuildContext context,
                    StateSetter filtersState,
                  ) {
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          DateTimeField(
                            resetIcon: null,
                            initialValue: fromDate,
                            decoration: const InputDecoration(
                              labelText: 'Desde',
                              prefixIcon: Icon(
                                UniconsLine.calendar_alt,
                              ),
                            ),
                            format: DateFormat('yyyy-MM-dd'),
                            onChanged: (date) {
                              if (date != null) {
                                filtersState(() {
                                  fromDate = date;
                                  filter = true;
                                });
                              }
                            },
                            onShowPicker: (context, currentValue) {
                              return showDatePicker(
                                context: context,
                                firstDate: DateTime(2021),
                                initialDate: currentValue ?? DateTime.now(),
                                lastDate: DateTime.now(),
                              );
                            },
                          ),
                          const SizedBox(height: 24),
                          DateTimeField(
                            resetIcon: null,
                            initialValue: toDate,
                            format: DateFormat('yyyy-MM-dd'),
                            decoration: const InputDecoration(
                              prefixIcon: Icon(
                                UniconsLine.calendar_alt,
                              ),
                              labelText: 'Hasta',
                            ),
                            onChanged: (date) {
                              if (date != null) {
                                filtersState(() {
                                  toDate = date;
                                  filter = true;
                                });
                              }
                            },
                            onShowPicker: (context, currentValue) {
                              return showDatePicker(
                                context: context,
                                firstDate: DateTime(2021),
                                initialDate: currentValue ?? DateTime.now(),
                                lastDate: DateTime.now(),
                              );
                            },
                          ),
                          const SizedBox(height: 24),
                          InputDecorator(
                            decoration: const InputDecoration(
                              labelText: 'Estado',
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<int>(
                                value: status,
                                isDense: true,
                                onChanged: (int? newValue) {
                                  filtersState(() {
                                    status = newValue ?? -1;
                                    filter = true;
                                  });
                                },
                                items: statusOptions
                                    .map((int key, String value) {
                                      return MapEntry(
                                        key,
                                        DropdownMenuItem<int>(
                                          value: key,
                                          child: Text(value.capitalize()),
                                        ),
                                      );
                                    })
                                    .values
                                    .toList(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                  innerBoxIsScrolled: innerBoxIsScrolled,
                  searchController: searchController,
                  onFilter: () {
                    if (filter) {
                      context
                          .read<PaymentsBloc>()
                          .add(PaymentsEventGetPaymentsHistory(
                            from: fromDate,
                            to: toDate,
                            status: status >= 0 ? status : null,
                          ));
                    }
                    setState(() {
                      filter = false;
                    });
                  },
                ),
              ];
            },
            body: PaymentsList(
              payments: searchValue != ''
                  ? state.payments
                      .where((element) =>
                          element.amount.toInt().toString() == (searchValue))
                      .toList()
                  : state.payments,
            ),
          ),
          fab: const PaymentsFab(),
        );
      },
    );
  }
}
