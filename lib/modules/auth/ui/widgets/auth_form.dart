import 'package:flutter/material.dart';

import 'package:unicons/unicons.dart';

import 'package:walak/core/theme/theme.dart';
import 'package:walak/core/utils/utils.dart';

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
    if (!formKey.currentState!.validate()) return;
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
            const SizedBox(height: 48),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => submit(),
                child: const Text('INGRESAR'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
