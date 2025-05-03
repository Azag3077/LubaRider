import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../components/pin_code_input_field.dart';
import '../../components/textfields.dart';
import '../../core/validators.dart';
import 'provider.dart';

class AddBankPage extends ConsumerStatefulWidget {
  const AddBankPage({super.key});

  static const routeName = '/add-bank';

  @override
  ConsumerState<AddBankPage> createState() => _AddBankPageState();
}

class _AddBankPageState extends ConsumerState<AddBankPage> {
  final _formKey = GlobalKey<FormState>();
  final _pin1FieldKey = GlobalKey<FormFieldState<String?>>();

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(withdrawEarningsPageProvider);
    final notifier = ref.read(withdrawEarningsPageProvider.notifier);

    const titleTextStyle = TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w600,
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Add bank')),
      body: Column(
        children: <Widget>[
          Expanded(
            child: AutofillGroup(
              child: Form(
                key: _formKey,
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  children: <Widget>[
                    const Text('Bank details', style: titleTextStyle),
                    const SizedBox(height: 14.0),

                    /// Select bank
                    CustomTextField(
                      labelText: 'Select bank',
                      hintText: 'Enter bank name',
                      initialValue: state.bankName,
                      filled: false,
                      textInputAction: TextInputAction.next,
                      onChanged: notifier.updateBankName,
                      validator: Validator.name,
                    ),

                    /// Account Number
                    CustomTextField(
                      labelText: 'Account Number',
                      hintText: 'Enter account number',
                      initialValue: state.accountNumber,
                      keyboardType: TextInputType.number,
                      filled: false,
                      maxLength: 11,
                      textInputAction: TextInputAction.next,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      onChanged: notifier.updateAccountNumber,
                      validator: Validator.validateAccountNumber,
                    ),

                    /// Account Name
                    CustomTextField(
                      labelText: 'Account Name',
                      hintText: 'Enter account name',
                      initialValue: state.accountName,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      filled: false,
                      autofillHints: const [AutofillHints.name],
                      textCapitalization: TextCapitalization.words,
                      onChanged: notifier.updateAccountName,
                      validator: Validator.name,
                    ),

                    ///
                    const SizedBox(height: 16.0),
                    const Text('Transaction pin', style: titleTextStyle),
                    const SizedBox(height: 14.0),

                    /// The 1st Pin Input Field
                    CustomPinCodeTextField(
                      labelText: 'Set transaction pin',
                      initialValue: state.pin1,
                      onSaved: notifier.updatePin1,
                      validator: notifier.pin1Validator,
                    ),
                    const SizedBox(height: 16.0),

                    /// The 2nd Pin Input Field
                    CustomPinCodeTextField(
                      labelText: 'Confirm transaction pin',
                      initialValue: state.pin2,
                      onSaved: notifier.updatePin2,
                      validator: notifier.pin2Validator,
                    ),
                    const SizedBox(height: 32.0),
                  ],
                ),
              ),
            ),
          ),

          /// The Withdraw Button
          const SizedBox(height: 6.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: FilledButton(
              onPressed: () =>
                  notifier.onSave(context, _formKey, _pin1FieldKey),
              child: const Center(child: Text('Save')),
            ),
          ),
          const SizedBox(height: 20.0),
        ],
      ),
    );
  }
}
