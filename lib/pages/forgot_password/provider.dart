import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../components/snackbar.dart';
import '../../core/routers/app_routes.dart';
import '../reset_password/page.dart';
import '../verify_otp/page.dart';

final forgotPasswordPageProvider = Provider((_) => _Provider());

class _Provider {
  String _email = '';

  void onEmailChanged(String value) => _email = value;

  Future<void> onRecoverPassword(
    BuildContext context,
    GlobalKey<FormState> formKey,
  ) async {
    if (!formKey.currentState!.validate()) return;

    final result = await pushNamed(
      context,
      VerifyOtpPage.routeName,
      arguments: _email,
    );

    if (result != true || !context.mounted) return;

    pushReplacementNamed(context, ResetPasswordPage.routeName);
    showSnackbar(
      context: context,
      title: 'Successful',
      subtitle: 'Email verified successfully!!!',
      type: SnackbarType.success,
    );
  }
}
