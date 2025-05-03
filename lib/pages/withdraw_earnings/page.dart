import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../components/pin_code_input_field.dart';
import '../../components/textfields.dart';
import '../../core/constants/assets.dart';
import '../../core/constants/colors.dart';
import '../../core/validators.dart';
import '../../utils/utils.dart';
import 'provider.dart';

class WithdrawEarningsPage extends ConsumerStatefulWidget {
  const WithdrawEarningsPage({super.key});

  static const routeName = '/withdraw-earnings';

  @override
  ConsumerState<WithdrawEarningsPage> createState() =>
      _WithdrawEarningsPageState();
}

class _WithdrawEarningsPageState extends ConsumerState<WithdrawEarningsPage> {
  final _formKey = GlobalKey<FormState>();
  final _pinFieldKey = GlobalKey<FormFieldState<String?>>();

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(withdrawEarningsPageProvider);
    final notifier = ref.read(withdrawEarningsPageProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('Withdraw money')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          children: <Widget>[
            /// Amount to Withdraw
            CustomTextField(
              labelText: 'Amount to withdraw',
              hintText: 'Enter amount',
              initialValue: state.amount,
              suffixIcon: const Padding(
                padding: EdgeInsets.only(right: 12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'NGN',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14.0,
                      ),
                    ),
                  ],
                ),
              ),
              keyboardType: TextInputType.number,
              filled: false,
              inputFormatters: [NumberInputFormatter()],
              onChanged: notifier.updateAmount,
              margin: const EdgeInsets.only(bottom: 8.0),
              validator: Validator.amount,
            ),

            /// Helper Text
            const Text(
              'Amount will be sent to your bank account',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 12.0,
                color: Color(0xFF484848),
              ),
            ),
            const SizedBox(height: 24.0),

            /// Account Number Container
            const Padding(
              padding: EdgeInsets.only(left: 2.0, bottom: 6.0),
              child: Text(
                'To',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: AppColors.secText,
                  fontSize: 14.0,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(12.0, 16.0, 4.0, 16.0),
              decoration: BoxDecoration(
                color: AppColors.containerFg,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Row(
                spacing: 10.0,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(11.0),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.yellow50,
                    ),
                    child: Image.asset(ImageAssetNames.bank),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Text(
                          'Account number',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16.0,
                          ),
                        ),
                        Text(
                          maskPhoneNumber('0760562337'),
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            color: AppColors.secText,
                            fontSize: 13.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () => notifier.onEditBank(context),
                    child: const Text(
                      'Edit',
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8.0),

            /// Add New Bank TextButton
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton(
                onPressed: () => notifier.onAddNewBank(context),
                style: TextButton.styleFrom(
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 4.0,
                    horizontal: 8.0,
                  ),
                  minimumSize: Size.zero,
                ),
                child: const Text(
                  '+ Add new Bank',
                  style: TextStyle(
                    fontSize: 13.0,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32.0),

            /// The Pin Input Field
            CustomPinCodeTextField(
              fieldKey: _pinFieldKey,
              labelText: 'Set transaction pin',
              initialValue: state.pin,
              onSaved: notifier.updatePin,
              validator: notifier.pinValidator,
            ),
            const SizedBox(height: 94.0),

            /// The Withdraw Button
            FilledButton(
              onPressed: () =>
                  notifier.onWithdraw(context, _formKey, _pinFieldKey),
              child: const Text('Withdraw'),
            ),
          ],
        ),
      ),
    );
  }
}
