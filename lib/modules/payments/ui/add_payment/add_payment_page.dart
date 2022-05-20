import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unicons/unicons.dart';

import 'package:walak/core/network/network.dart';
import 'package:walak/core/theme/theme.dart';
import 'package:walak/core/widgets/widgets.dart';
import 'package:walak/modules/payments/ui/add_payment/widgets/widgets.dart';
import 'package:walak/modules/source/bloc/source_bloc.dart';
import 'package:walak/modules/source/models/models.dart';

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
    if (_formKey.currentState!.validate()) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<SourceBloc, SourceState>(
        builder: (context, state) {
          return CustomScrollView(
            slivers: [
              const SectionAppBar(),
              SliverFillRemaining(
                hasScrollBody: false,
                child: (state.paymentMethodsStatus == RequestStatus.inProgress)
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
                                padding: const EdgeInsets.only(bottom: 24),
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
                                selectedPaymentMethod: _selectedPaymentMethod,
                                onChange: (paymentMethod) {
                                  setState(() {
                                    _selectedPaymentMethod = paymentMethod;
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
                                  onPressed: _selectedPaymentMethod == null
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
                                  icon: const Icon(UniconsLine.search_plus),
                                  label:
                                      const Text('Detalles del método de pago'),
                                ),
                              ),
                              const SizedBox(height: 24),
                              AddPaymentForm(
                                selectedPaymentMethod: _selectedPaymentMethod,
                                amountController: _amountController,
                                codeController: _codeController,
                                nameController: _nameController,
                                onSubmit: _onSubmit,
                              ),
                              const Expanded(child: SizedBox(height: 24)),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: _selectedPaymentMethod == null
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
          );
        },
      ),
    );
  }
}
