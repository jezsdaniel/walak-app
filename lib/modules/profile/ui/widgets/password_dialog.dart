import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:unicons/unicons.dart';
import 'package:walak/core/network/network.dart';

import 'package:walak/core/theme/theme.dart';
import 'package:walak/core/utils/utils.dart';
import 'package:walak/core/widgets/widgets.dart';
import 'package:walak/modules/profile/bloc/profile_bloc.dart';

class PasswordDialog extends StatefulWidget {
  final String email;
  final ProfileBloc profileBloc;

  const PasswordDialog({
    Key? key,
    required this.email,
    required this.profileBloc,
  }) : super(key: key);

  @override
  State<PasswordDialog> createState() => _PasswordDialogState();
}

class _PasswordDialogState extends State<PasswordDialog> {
  bool _showOldPassword = false;
  bool _showNewPassword = false;
  bool _showConfirmPassword = false;

  final _formKey = GlobalKey<FormState>();
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  void _submit() {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) return;

    widget.profileBloc.add(ProfileEventChangePassword(
      widget.email,
      _oldPasswordController.text,
      _newPasswordController.text,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: BlocConsumer<ProfileBloc, ProfileState>(
            bloc: widget.profileBloc,
            listener: (context, state) {
              if (state.status == RequestStatus.success) {
                Navigator.of(context).pop();
                const snackBar = SnackBar(
                  content: Text('Contraseña cambiada correctamente'),
                  duration: Duration(seconds: 6),
                  backgroundColor: WColors.success,
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
            },
            builder: (context, state) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Cambiar contraseña',
                    style: wText.subtitle1,
                  ),
                  const SizedBox(height: 24),
                  TextFormField(
                    controller: _oldPasswordController,
                    obscureText: !_showOldPassword,
                    textInputAction: TextInputAction.next,
                    validator: WValidators.required(context),
                    enabled: state.status != RequestStatus.inProgress,
                    decoration: InputDecoration(
                      hintText: 'Contraseña actual',
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            _showOldPassword = !_showOldPassword;
                          });
                        },
                        child: Icon(
                          !_showOldPassword
                              ? UniconsLine.eye_slash
                              : UniconsLine.eye,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _newPasswordController,
                    obscureText: !_showNewPassword,
                    textInputAction: TextInputAction.next,
                    validator: WValidators.required(context),
                    enabled: state.status != RequestStatus.inProgress,
                    decoration: InputDecoration(
                      hintText: 'Contraseña nueva',
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            _showNewPassword = !_showNewPassword;
                          });
                        },
                        child: Icon(
                          !_showNewPassword
                              ? UniconsLine.eye_slash
                              : UniconsLine.eye,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _confirmPasswordController,
                    obscureText: !_showConfirmPassword,
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted: (_) => _submit(),
                    validator: (val) {
                      if (val!.isEmpty) return 'Obligatorio';
                      if (val != _newPasswordController.text) {
                        return 'Las contraseñas no coinciden';
                      }
                      return null;
                    },
                    enabled: state.status != RequestStatus.inProgress,
                    decoration: InputDecoration(
                      hintText: 'Confirmar contraseña',
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            _showConfirmPassword = !_showConfirmPassword;
                          });
                        },
                        child: Icon(
                          !_showConfirmPassword
                              ? UniconsLine.eye_slash
                              : UniconsLine.eye,
                        ),
                      ),
                    ),
                  ),
                  if (state.status == RequestStatus.failure)
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: WAlertContainer(
                        error: state.errorMessage,
                      ),
                    ),
                  const SizedBox(height: 32),
                  Row(
                    children: [
                      OutlinedButton(
                        onPressed: state.status == RequestStatus.inProgress
                            ? null
                            : () {
                                Navigator.of(context).pop();
                              },
                        child: const Icon(
                          UniconsLine.times,
                          color: WColors.textHighEmphasis,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: state.status == RequestStatus.inProgress
                              ? null
                              : () {
                                  _submit();
                                },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('ACTUALIZAR'),
                              if (state.status == RequestStatus.inProgress)
                                Container(
                                  width: 20,
                                  height: 20,
                                  margin: const EdgeInsets.only(left: 8),
                                  child: const CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
