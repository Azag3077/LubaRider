import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../components/buttons.dart';
import '../../../../../components/phone_number_field_prefix_button.dart';
import '../../../../../components/textfields.dart';
import '../../../../../core/constants/enums.dart';
import '../../../../../core/extensions/string.dart';
import '../../../../../core/validators.dart';
import '../../components/date_picker.dart';
import 'provider.dart';

class PersonalDetailsPageView extends ConsumerWidget {
  const PersonalDetailsPageView({
    super.key,
    required this.formKey,
  });

  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(personalDetailsPageViewProvider);
    final notifier = ref.read(personalDetailsPageViewProvider.notifier);

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
                'Personal Details',
                style: textTheme.headlineMedium,
              ),
              const SizedBox(height: 24.0),
              CustomTextField(
                labelText: 'First name',
                initialValue: state.firstname,
                onChanged: notifier.updateFirstname,
                hintText: 'Enter name',
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
                validator: Validator.name,
                autofillHints: const [AutofillHints.givenName],
              ),
              CustomTextField(
                labelText: 'Last name',
                initialValue: state.lastname,
                onChanged: notifier.updateLastname,
                hintText: 'Last name',
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
                validator: Validator.name,
                autofillHints: const [AutofillHints.familyName],
              ),
              SelectionButton<Gender>(
                labelText: 'Gender',
                hintText: 'Select gender',
                initialValue: state.gender,
                bottomSheetItems: Gender.values,
                textBuilder: (gender) => gender?.name.title,
                validator: (gender) => Validator.name(gender?.name.title),
                onSaved: notifier.updateGender,
              ),
              CustomTextField(
                labelText: 'Phone Number',
                initialValue: state.phone,
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
              CustomTextField(
                labelText: 'Email',
                initialValue: state.email,
                onChanged: notifier.onEmailChanged,
                hintText: 'Enter your email',
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                validator: Validator.email,
              ),
              DatePickerContainer(
                datetime: state.dob,
                labelText: 'Date of birth',
                validator: (value) {
                  if (value != null) return null;
                  return 'This field is required';
                },
                onSaved: notifier.updateDOB,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
