import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../core/constants/assets.dart';
import '../../core/constants/colors.dart';
import '../../core/constants/constants.dart';
import '../../core/extensions/duration.dart';
import 'provider.dart';

class VerifyOtpPage extends ConsumerWidget {
  const VerifyOtpPage(this.provider, {super.key});

  final String provider;

  static const routeName = '/verify-otp';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(verifyOtpPageProvider);
    final notifier = ref.read(verifyOtpPageProvider.notifier);

    final duration = Duration(seconds: state.countdown);

    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
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
              child: Text('Enter code', style: textTheme.headlineMedium),
            ),
            const SizedBox(height: 4.0),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text.rich(
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                ),
                TextSpan(
                  text: 'Check your email and input OTP',
                  // children: <InlineSpan>[
                  //   TextSpan(
                  //     text: provider,
                  //     style: const TextStyle(
                  //       fontWeight: FontWeight.w600,
                  //     ),
                  //   ),
                  // ],
                ),
              ),
            ),
            const SizedBox(height: 48.0),
            LayoutBuilder(
              builder: (context, constraints) {
                const length = 4;
                final maxWidth = constraints.maxWidth;
                final width = maxWidth / length - 8.0;

                return PinCodeTextField(
                  appContext: context,
                  length: length,
                  autoFocus: true,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  keyboardType: TextInputType.number,
                  enableActiveFill: true,
                  onChanged: notifier.updateCode,
                  cursorColor: AppColors.primary,
                  onCompleted: (code) => notifier.onCompleted(context, code),
                  pinTheme: PinTheme(
                    fieldWidth: width,
                    fieldHeight: 60.0,
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(kButtonRadius),
                    selectedColor: AppColors.primary,
                    selectedBorderWidth: 1.2,
                    activeColor: Colors.transparent,
                    inactiveColor: Colors.transparent,
                    activeFillColor: AppColors.black50,
                    selectedFillColor: AppColors.black50,
                    inactiveFillColor: AppColors.black50,
                    errorBorderColor: AppColors.red,
                  ),
                );
              },
            ),
            const SizedBox(height: 16.0),
            Center(
              child: TextButton(
                onPressed: state.countdown != 0
                    ? null
                    : () => notifier.resendCode(context),
                child: Text(
                  'Send code again '
                  '${state.countdown == 0 ? '' : duration.toStr()}',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24.0),
            FilledButton(
              onPressed: state.code.length != 4
                  ? null
                  : () => notifier.onContinue(context),
              child: const Center(child: Text('Continue')),
            ),
          ],
        ),
      ),
    );
  }
}
