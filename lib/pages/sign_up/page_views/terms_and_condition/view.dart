import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../components/buttons.dart';
import '../../../../core/constants/colors.dart';
import 'provider.dart';

class TermsAndConditionPageView extends ConsumerWidget {
  const TermsAndConditionPageView({
    super.key,
    required this.formKey,
  });

  final GlobalKey<FormState> formKey;

  Widget _buildRowText(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Row(
        spacing: 8.0,
        children: <Widget>[
          const Icon(
            Icons.check,
            size: 20.0,
            color: AppColors.green500,
          ),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: AppColors.secText,
                fontSize: 13.0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isChecked = ref.watch(termsAndConditionPageViewProvider);
    final notifier = ref.read(termsAndConditionPageViewProvider.notifier);

    final textTheme = Theme.of(context).textTheme;

    return Column(
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Terms & Conditions Agreement',
                  style: textTheme.headlineMedium,
                ),
                const SizedBox(height: 10.0),
                const Text(
                  'Before proceeding, you must agree to our Terms of Service & Conduct Policy.',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: AppColors.secText,
                    fontSize: 14.0,
                  ),
                ),
                const SizedBox(height: 40.0),
                const Text(
                  'Key Terms & Conditions:',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 13.0,
                  ),
                ),
                const SizedBox(height: 10.0),
                _buildRowText('I agree to deliver food safely & on time'),
                _buildRowText(
                  'I will maintain a professional '
                  'attitude with customers & restaurants',
                ),
                _buildRowText(
                  'I understand that delays, order mishandling, or policy '
                  'violations can result in penalties or deactivation',
                ),
                _buildRowText(
                  'I confirm that all information '
                  'I provided is accurate and truthful',
                ),
                _buildRowText(
                  'I accept that I am an independent '
                  'contractor, not an employee of the company',
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Form(
            key: formKey,
            child: CheckboxTextButton(
              initialValue: isChecked,
              text: 'I have read and agree to the Terms & Conditions',
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 12.0,
              ),
              onSaved: notifier.updateState,
              validator: (value) {
                if (value == true) return null;
                return 'This field is required';
              },
            ),
          ),
        ),
      ],
    );
  }
}
