import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/network/network.dart';
import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../services/widgets/totals_card.dart';
import '../../bloc/mlc24_bloc.dart';
import 'widgets/widgets.dart';

class AddMLC24Page extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute<void>(
      builder: (_) => const AddMLC24Page(),
    );
  }

  const AddMLC24Page({Key? key}) : super(key: key);

  @override
  State<AddMLC24Page> createState() => _AddMLC24PageState();
}

class _AddMLC24PageState extends State<AddMLC24Page> {
  final _formKey = GlobalKey<FormState>();
  final _cardController = TextEditingController();
  final _nameController = TextEditingController();
  final _amountController = TextEditingController();

  CancelToken feeCancelToken = CancelToken();

  void _onSubmit(double amountPay, double fee) {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState!.validate()) {
      context.read<MLC24Bloc>().add(
            MLC24EventAddTransaction(
              amount: double.parse((_amountController.text).substring(1)).toInt(),
              amountPay: amountPay,
              fee: fee,
              cardNumber: _cardController.text.split(' ').join(''),
              senderName: _nameController.text,
            ),
          );
    }
  }

  @override
  void initState() {
    super.initState();
    _amountController.addListener(() {
      feeCancelToken.cancel();
      feeCancelToken = CancelToken();
      if (_amountController.text.isNotEmpty &&
          double.tryParse(_amountController.text.substring(1)) != null &&
          double.parse(_amountController.text.substring(1)) > 0) {
        BlocProvider.of<MLC24Bloc>(context).add(
          MLC24EventCalculateFee(
            amount: double.parse(_amountController.text.substring(1)).toInt(),
            isAmountPay: false,
            cancelToken: feeCancelToken,
          ),
        );
      } else {
        BlocProvider.of<MLC24Bloc>(context).add(MLC24EventCleanFee());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<MLC24Bloc, MLC24State>(
        listener: (context, state) {
          if (state.status == RequestStatus.success) {
            final snackBar = SnackBar(
              content: Text(
                'Petición enviada correctamente',
                style: wText.subtitle2!.copyWith(color: WColors.textContrast),
              ),
              duration: const Duration(seconds: 6),
              backgroundColor: WColors.primaryVariant,
            );
            DateTime fromDate =
                DateTime.now().subtract(const Duration(days: 7));
            DateTime toDate = DateTime.now();
            context
                .read<MLC24Bloc>()
                .add(MLC24EventGetHistory(from: fromDate, to: toDate));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              Positioned.fill(
                child: CustomScrollView(
                  slivers: [
                    const SectionAppBar(),
                    SliverFillRemaining(
                      hasScrollBody: false,
                      child: Form(
                        key: _formKey,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                          ),
                          child: Column(
                            children: [
                              const SizedBox(height: 4),
                              Container(
                                padding: const EdgeInsets.only(bottom: 24),
                                width: double.infinity,
                                child: Text(
                                  'Cargar pedido 24hs',
                                  style: wText.headline5!
                                      .copyWith(color: WColors.primary),
                                ),
                              ),
                              Text(
                                'Por favor, complete los datos del receptor con el formato requerido',
                                style: wText.bodyText2,
                              ),
                              const SizedBox(height: 24),
                              AddMLC24Form(
                                cardController: _cardController,
                                nameController: _nameController,
                                amountController: _amountController,
                                onSubmit: () {
                                  _onSubmit(state.fee.amountPay, state.fee.fee);
                                },
                              ),
                              const SizedBox(height: 24),
                              TotalsCard(
                                totals: {
                                  'Monto a enviar': _amountController.text == '' ? '\$0.00' : _amountController.text,
                                  'Comisión':
                                      '${state.fee.fee.toStringAsFixed(2)}%',
                                },
                                totalAmount: state.fee.amountPay,
                              ),
                              const SizedBox(height: 24),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: state.feeStatus ==
                                          RequestStatus.inProgress
                                      ? null
                                      : () {
                                          _onSubmit(state.fee.amountPay,
                                              state.fee.fee);
                                        },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text('Enviar solicitud'),
                                      state.feeStatus ==
                                              RequestStatus.inProgress
                                          ? Container(
                                              width: 24,
                                              height: 24,
                                              margin: const EdgeInsets.only(
                                                left: 8,
                                              ),
                                              child:
                                                  const CircularProgressIndicator(
                                                strokeWidth: 2,
                                              ),
                                            )
                                          : const SizedBox.shrink(),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 32),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (state.status == RequestStatus.inProgress)
                Positioned.fill(
                  child: Container(
                    color: Colors.black.withOpacity(0.5),
                    child: const Center(
                      child: SizedBox(
                        width: 42,
                        height: 42,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
