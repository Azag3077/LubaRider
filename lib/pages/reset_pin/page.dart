import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../components/pin_code_input_field.dart';
import 'provider.dart';

class ResetPinPage extends ConsumerWidget {
  const ResetPinPage({super.key});

  static const routeName = '/reset-pin';
  static final _formKey = GlobalKey<FormState>();
  static final _pin1FieldKey = GlobalKey<FormFieldState<String?>>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(resetPinPageProvider);
    final notifier = ref.read(resetPinPageProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('Reset Pin')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          children: <Widget>[
            const SizedBox(height: 16.0),
            const Text(
              'Transaction pin',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 14.0),

            /// The 1st Pin Input Field
            CustomPinCodeTextField(
              fieldKey: _pin1FieldKey,
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
            const SizedBox(height: 56.0),
            FilledButton(
              onPressed: () =>
                  notifier.onResetPin(context, _formKey, _pin1FieldKey),
              child: const Center(child: Text('Save')),
            ),
          ],
        ),
      ),
    );
  }
}
