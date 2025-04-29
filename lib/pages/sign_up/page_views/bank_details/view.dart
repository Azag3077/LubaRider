import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../components/buttons.dart';
import '../../../../../components/textfields.dart';
import '../../../../../core/validators.dart';
import 'provider.dart';

class BankDetailsPageView extends ConsumerWidget {
  const BankDetailsPageView({
    super.key,
    required this.formKey,
  });

  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(bankDetailsPageViewProvider);
    final notifier = ref.read(bankDetailsPageViewProvider.notifier);

    final textTheme = Theme.of(context).textTheme;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: AutofillGroup(
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Bank Details',
                style: textTheme.headlineMedium,
              ),
              const SizedBox(height: 24.0),
              SelectionButton<String>(
                labelText: 'What Bank?',
                hintText: 'Select bank',
                initialValue: state.bankName,
                bottomSheetItems:
                    List.generate(23, (i) => 'Bank of America $i'),
                textBuilder: (bank) => bank,
                validator: Validator.name,
                onSaved: notifier.updateBankName,
              ),
              CustomTextField(
                labelText: 'Account Number',
                initialValue: state.accountNumber,
                onChanged: notifier.updateAccountNumber,
                hintText: 'Enter your account number',
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                textInputAction: TextInputAction.next,
                maxLength: 11,
                validator: Validator.validateAccountNumber,
              ),
              CustomTextField(
                labelText: 'Name on Account',
                initialValue: state.accountName,
                onChanged: notifier.updateAccountName,
                hintText: 'Enter name on account',
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
                validator: Validator.name,
                autofillHints: const [AutofillHints.name],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
