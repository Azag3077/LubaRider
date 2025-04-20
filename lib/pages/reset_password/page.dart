import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../components/textfields.dart';
import '../../core/constants/assets.dart';
import '../../core/validators.dart';
import 'provider.dart';

class ResetPasswordPage extends ConsumerWidget {
  ResetPasswordPage({super.key});

  static const routeName = '/reset-password';
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final obscureText = ref.watch(resetPasswordPageProvider);
    final notifier = ref.read(resetPasswordPageProvider.notifier);

    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
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
                      child: Text(
                        'OTP Correct',
                        style: textTheme.headlineMedium,
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Create a new password',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ),
                    const SizedBox(height: 32.0),
                    CustomTextField(
                      labelText: 'Create Password',
                      hintText: 'Password',
                      onChanged: notifier.onPasswordChanged,
                      obscureText: obscureText,
                      textInputAction: TextInputAction.next,
                      enableSuggestions: false,
                      validator: Validator.password1,
                      suffixIcon: IconButton(
                        onPressed: notifier.toggleObscureText,
                        icon: Icon(
                          obscureText
                              ? CupertinoIcons.eye_slash
                              : CupertinoIcons.eye,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    CustomTextField(
                      labelText: 'Confirm Password',
                      hintText: 'Password',
                      obscureText: obscureText,
                      textInputAction: TextInputAction.next,
                      enableSuggestions: false,
                      validator: (value) =>
                          Validator.password2(value, notifier.password()),
                      suffixIcon: IconButton(
                        onPressed: notifier.toggleObscureText,
                        icon: Icon(
                          obscureText
                              ? CupertinoIcons.eye_slash
                              : CupertinoIcons.eye,
                          color: Colors.grey,
                        ),
                      ),
                      margin: const EdgeInsets.only(bottom: 4.0),
                    ),
                    const SizedBox(height: 32.0),
                    FilledButton(
                      onPressed: () =>
                          notifier.onCreateNewPassword(context, _formKey),
                      child: const Center(child: Text('Create New Password')),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
