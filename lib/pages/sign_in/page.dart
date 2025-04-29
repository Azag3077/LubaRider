import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../components/phone_number_field_prefix_button.dart';
import '../../components/textfields.dart';
import '../../core/constants/assets.dart';
import '../../core/constants/colors.dart';
import '../../core/validators.dart';
import 'provider.dart';

class SignInPage extends ConsumerWidget {
  SignInPage({super.key});

  static const routeName = '/sign-in';
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(signInPageProvider);
    final notifier = ref.read(signInPageProvider.notifier);

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
              child: Text('Hi, Welcome', style: textTheme.headlineMedium),
            ),
            const SizedBox(height: 32.0),
            Form(
              key: _formKey,
              child: CustomTextField(
                labelText: 'Phone Number',
                onChanged: notifier.onPhoneChanged,
                hintText: 'Enter your phone number',
                keyboardType: TextInputType.phone,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                textInputAction: TextInputAction.next,
                validator: Validator.validatePhoneNumber,
                prefixIcon: PhoneNumberFieldPrefixButton(
                  country: state.country,
                  onCodeTap: () => notifier.onCodeTap(context),
                ),
              ),
            ),
            const SizedBox(height: 32.0),
            FilledButton(
              onPressed: () => notifier.onSignIn(context, _formKey),
              child: const Center(child: Text('Sign in')),
            ),
            const SizedBox(height: 8.0),
            TextButton(
              onPressed: () => notifier.onSignUp(context),
              child: const Text(
                'Sign Up as a New Rider',
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
