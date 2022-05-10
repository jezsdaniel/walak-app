import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unicons/unicons.dart';

import 'package:walak/core/network/request_status.dart';
import 'package:walak/core/theme/theme.dart';
import 'package:walak/core/utils/utils.dart';
import 'package:walak/core/widgets/widgets.dart';
import 'package:walak/modules/auth/bloc/auth_bloc.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({
    Key? key,
  }) : super(key: key);

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  bool hidePassword = true;

  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void submit() {
    FocusScope.of(context).unfocus();
    if (!formKey.currentState!.validate()) return;
    context.read<AuthBloc>().add(
          AuthEventSignIn(
            emailController.text,
            passwordController.text,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: WColors.surface,
      ),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            TextFormField(
              controller: emailController,
              validator: WValidators.email(context),
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                labelText: 'Correo electrónico',
                prefixIcon: Icon(UniconsLine.envelope),
              ),
            ),
            const SizedBox(height: 24),
            TextFormField(
              controller: passwordController,
              validator: WValidators.required(context),
              obscureText: hidePassword,
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (_) => submit(),
              decoration: InputDecoration(
                labelText: 'Contraseña',
                prefixIcon: const Icon(UniconsLine.lock_alt),
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      hidePassword = !hidePassword;
                    });
                  },
                  child: Icon(
                    hidePassword ? UniconsLine.eye_slash : UniconsLine.eye,
                  ),
                ),
              ),
            ),
            BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
              if (state.status == RequestStatus.failure) {
                return Container(
                  margin: const EdgeInsets.only(top: 24),
                  child: WAlertContainer(
                    error: state.error,
                  ),
                );
              }
              return Container();
            }),
            const SizedBox(height: 48),
            SizedBox(
              width: double.infinity,
              child: BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  return ElevatedButton(
                    onPressed: state.status == RequestStatus.inProgress
                        ? null
                        : () {
                            submit();
                          },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('INGRESAR'),
                        if (state.status == RequestStatus.inProgress)
                          Container(
                            width: 20,
                            height: 20,
                            margin: const EdgeInsets.only(left: 12),
                            child: const CircularProgressIndicator(
                              strokeWidth: 2,
                            ),
                          ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
