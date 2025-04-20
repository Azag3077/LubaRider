import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../components/dialogs.dart';
import '../../components/snackbar.dart';
import '../../core/constants/assets.dart';
import '../../core/routers/app_routes.dart';
import '../../network/api_services/auth.dart';
import '../successful/page.dart';

final resetPasswordPageProvider =
    AutoDisposeNotifierProvider<_Notifier, bool>(_Notifier.new);

class _Notifier extends AutoDisposeNotifier<bool> {
  String _password = '';

  @override
  bool build() => true;

  void onPasswordChanged(String value) => _password = value;

  void toggleObscureText() => state = !state;

  String password() => _password;

  Future<void> onCreateNewPassword(
    BuildContext context,
    GlobalKey<FormState> formKey,
  ) async {
    if (!formKey.currentState!.validate()) return;

    showLoadingDialog(context);

    final result = await AuthService.resetPassword(_password);

    if (!context.mounted) return;

    pop(context);

    if (result.data!) return _handleSuccess(context);

    showSnackbar(
      context: context,
      title: result.error!.title,
      subtitle: result.error!.message,
      type: SnackbarType.error,
    );
  }

  Future<void> _handleSuccess(BuildContext context) async {
    await pushReplacementNamed(
      context,
      SuccessfulPage.routeName,
      arguments: const SuccessfulPageArgs(
        icon: ImageAssetNames.successful,
        title: 'Verification Successful!',
        subtitle: 'Your account has been successfully verified. '
            "You're all set to start using the app.",
      ),
    );

    if (context.mounted) return;
  }
}
