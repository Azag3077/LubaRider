import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../components/animated_widgets.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/constants.dart';

class CustomPinCodeTextField extends StatelessWidget {
  const CustomPinCodeTextField({
    super.key,
    this.fieldKey,
    required this.labelText,
    this.labelTextStyle,
    this.initialValue,
    this.validator,
    this.onSaved,
    this.spacing = 6.0,
    this.length = 5,
  });

  final String labelText;
  final double spacing;
  final int length;
  final TextStyle? labelTextStyle;
  final String? initialValue;
  final FormFieldValidator<String>? validator;
  final FormFieldSetter<String>? onSaved;
  final GlobalKey<FormFieldState<String?>>? fieldKey;

  void _onChanged(FormFieldState<String?> state, String value) async {
    state.didChange(value);
    if (state.isValid) state.validate();
    state.save();
  }

  @override
  Widget build(BuildContext context) {
    return FormField<String?>(
      key: fieldKey,
      initialValue: initialValue,
      validator: validator,
      onSaved: onSaved,
      builder: (FormFieldState<String?> state) {
        final showError = state.hasError && state.errorText != null;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 2.0, bottom: 6.0),
              child: Text(
                labelText,
                style: labelTextStyle ??
                    const TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500,
                      color: AppColors.secText,
                    ),
              ),
            ),
            LayoutBuilder(
              builder: (context, constraints) {
                final maxWidth = constraints.maxWidth;
                final width = maxWidth / length - spacing;

                return PinCodeTextField(
                  length: length,
                  appContext: context,
                  cursorColor: AppColors.primary,
                  keyboardType: TextInputType.number,
                  onChanged: (value) => _onChanged(state, value),
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  errorTextSpace: 0,
                  pinTheme: PinTheme(
                    fieldWidth: width,
                    fieldHeight: 50.0,
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(kButtonRadius * .8),
                    selectedColor: AppColors.primary,
                    activeColor: AppColors.borderColor,
                    inactiveColor: AppColors.borderColor,
                    activeFillColor: Colors.transparent,
                    selectedFillColor: Colors.transparent,
                    inactiveFillColor: Colors.transparent,
                    errorBorderColor: AppColors.red,
                    activeBorderWidth: 1.8,
                    selectedBorderWidth: 1.8,
                    inactiveBorderWidth: 1.8,
                    disabledBorderWidth: 1.8,
                    errorBorderWidth: 1.8,
                  ),
                );
              },
            ),
            CustomAnimatedSwitcher(
              value: showError,
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 8.0),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.error,
                      size: 16.0,
                      color: Theme.of(context).colorScheme.error,
                    ),
                    const SizedBox(width: 4.0),
                    Expanded(
                      child: Text(
                        state.errorText ?? '',
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Theme.of(context).colorScheme.error,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
