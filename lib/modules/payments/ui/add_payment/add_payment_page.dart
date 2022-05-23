import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unicons/unicons.dart';

import '../../../../core/network/network.dart';
import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../bloc/payments_bloc.dart';
import 'widgets/widgets.dart';
import '../../../source/bloc/source_bloc.dart';
import '../../../source/models/models.dart';

class AddPaymentPage extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute<void>(
      builder: (_) => const AddPaymentPage(),
    );
  }

  const AddPaymentPage({Key? key}) : super(key: key);

  @override
  State<AddPaymentPage> createState() => _AddPaymentPageState();
}

class _AddPaymentPageState extends State<AddPaymentPage> {
  PaymentMethod? _selectedPaymentMethod;

  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _codeController = TextEditingController();
  final _nameController = TextEditingController();

  void _onSubmit() {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState!.validate()) {
      context.read<PaymentsBloc>().add(
            PaymentsEventAddPayment(
              amount: double.parse((_amountController.text).substring(1)),
              paymentMethodId: _selectedPaymentMethod!.id,
              code: _selectedPaymentMethod!.requiresConfirmationCode
                  ? _codeController.text
                  : null,
              name: _selectedPaymentMethod!.requiresConfirmationCode &&
                      !_selectedPaymentMethod!.isCrypto
                  ? _nameController.text
                  : null,
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<PaymentsBloc, PaymentsState>(
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
            context.read<PaymentsBloc>().add(
                PaymentsEventGetPaymentsHistory(from: fromDate, to: toDate));

            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            Navigator.pop(context);
          }
        },
        child: BlocBuilder<SourceBloc, SourceState>(
          builder: (context, state) {
            return Stack(
              children: [
                Positioned.fill(
                  child: CustomScrollView(
                    slivers: [
                      const SectionAppBar(),
                      SliverFillRemaining(
                        hasScrollBody: false,
                        child: (state.paymentMethodsStatus ==
                                RequestStatus.inProgress)
                            ? const Center(
                                child: SizedBox(
                                  width: 42,
                                  height: 42,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                ),
                              )
                            : Form(
                                key: _formKey,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 24,
                                  ),
                                  child: Column(
                                    children: [
                                      const SizedBox(height: 4),
                                      Container(
                                        padding:
                                            const EdgeInsets.only(bottom: 24),
                                        width: double.infinity,
                                        child: Text(
                                          'Insertar pago',
                                          style: wText.headline5!
                                              .copyWith(color: WColors.primary),
                                        ),
                                      ),
                                      Text(
                                        'Para sumar balance a su cuenta debe ingresar los pagos realizados: Elija el método de pago, ingrese el monto pagado, detalle de los datos de comprobación y el nombre del remitente.',
                                        style: wText.bodyText2,
                                      ),
                                      const SizedBox(height: 24),
                                      PaymentMethodSelect(
                                        paymentMethods: state.paymentMethods,
                                        selectedPaymentMethod:
                                            _selectedPaymentMethod,
                                        onChange: (paymentMethod) {
                                          setState(() {
                                            _selectedPaymentMethod =
                                                paymentMethod;
                                          });
                                        },
                                      ),
                                      const SizedBox(height: 12),
                                      SizedBox(
                                        width: double.infinity,
                                        child: TextButton.icon(
                                          style: TextButton.styleFrom(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 16,
                                              vertical: 12,
                                            ),
                                          ),
                                          onPressed:
                                              _selectedPaymentMethod == null
                                                  ? null
                                                  : () {
                                                      showDialog(
                                                        context: context,
                                                        builder: (context) {
                                                          return PaymentMethodDetailsDialog(
                                                            selectedPaymentMethod:
                                                                _selectedPaymentMethod,
                                                          );
                                                        },
                                                      );
                                                    },
                                          icon: const Icon(
                                              UniconsLine.search_plus),
                                          label: const Text(
                                              'Detalles del método de pago'),
                                        ),
                                      ),
                                      const SizedBox(height: 24),
                                      AddPaymentForm(
                                        selectedPaymentMethod:
                                            _selectedPaymentMethod,
                                        amountController: _amountController,
                                        codeController: _codeController,
                                        nameController: _nameController,
                                        onSubmit: _onSubmit,
                                      ),
                                      const Expanded(
                                          child: SizedBox(height: 24)),
                                      SizedBox(
                                        width: double.infinity,
                                        child: ElevatedButton(
                                          onPressed:
                                              _selectedPaymentMethod == null
                                                  ? null
                                                  : () {
                                                      _onSubmit();
                                                    },
                                          child: const Text('Ingresar Pago'),
                                        ),
                                      ),
                                      const SizedBox(height: 24),
                                    ],
                                  ),
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
                BlocBuilder<PaymentsBloc, PaymentsState>(
                  builder: (context, state) {
                    if (state.status == RequestStatus.inProgress) {
                      return Positioned.fill(
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
                      );
                    }
                    return Container();
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
