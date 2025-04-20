import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../components/textfields.dart';
import '../../core/constants/assets.dart';
import '../../core/validators.dart';
import 'provider.dart';

class ForgotPasswordPage extends ConsumerWidget {
  ForgotPasswordPage({super.key});

  static const routeName = '/forgot-password';
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(forgotPasswordPageProvider);

    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            const SizedBox(height: 72.0),
            Image.asset(
              ImageAssetNames.appLogisticsLogo,
              width: 100.0,
              height: 34.0,
            ),
            const SizedBox(height: 48.0),
            Align(
              alignment: Alignment.centerLeft,
              child: Text('Forgot Password', style: textTheme.headlineMedium),
            ),
            const SizedBox(height: 4.0),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Input your email address to recover password',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 32.0),
            Form(
              key: _formKey,
              child: AutofillGroup(
                child: CustomTextField(
                  labelText: 'Email',
                  onChanged: notifier.onEmailChanged,
                  hintText: 'Enter your email',
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  validator: Validator.email,
                  autofillHints: const [AutofillHints.email],
                ),
              ),
            ),
            const SizedBox(height: 32.0),
            FilledButton(
              onPressed: () => notifier.onRecoverPassword(context, _formKey),
              child: const Center(child: Text('Recover Password')),
            ),
          ],
        ),
      ),
    );
  }
}
