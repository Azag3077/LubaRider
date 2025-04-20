import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../core/constants/colors.dart';
import '../core/constants/constants.dart';
import 'animated_widgets.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.controller,
    this.initialValue,
    this.keyboardType,
    this.textInputAction,
    this.labelText,
    this.hintText,
    this.errorText,
    this.inputFormatters,
    this.validator,
    this.onChanged,
    this.onSubmitted,
    EdgeInsets? margin,
    this.prefixIcon,
    this.prefixIconData,
    this.suffixIcon,
    this.obscureText = false,
    this.validateOnSubmit = true,
    this.obscuringCharacter = '•',
    this.textCapitalization = TextCapitalization.none,
    this.isValidated = false,
    bool readOnly = false,
    this.onTap,
    this.radius = kTextFieldRadius,
    this.canRequestFocus = true,
    this.filled = true,
    this.enableSuggestions = true,
    this.maxLength,
    this.maxLines = 1,
    this.focusNode,
    this.fillColor,
    this.autofillHints = const <String>[],
  }) : margin = margin ?? const EdgeInsets.only(bottom: 16.0);
  final TextEditingController? controller;
  final String? initialValue;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final String? labelText;
  final String? hintText;
  final String? errorText;
  final List<TextInputFormatter>? inputFormatters;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final EdgeInsets margin;
  final bool obscureText;
  final bool validateOnSubmit;
  final String obscuringCharacter;
  final TextCapitalization textCapitalization;
  final bool isValidated;
  final GestureTapCallback? onTap;
  final double radius;
  final bool canRequestFocus;
  final bool filled;
  final Color? fillColor;
  final Widget? prefixIcon;
  final IconData? prefixIconData;
  final Widget? suffixIcon;
  final int? maxLength;
  final int? maxLines;
  final bool enableSuggestions;
  final FocusNode? focusNode;
  final Iterable<String>? autofillHints;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin,
      child: FormField<String>(
        validator: validator,
        initialValue: controller?.text ?? initialValue,
        // onSaved: (value) { return '';},
        builder: (FormFieldState<String> state) {
          final showError = state.hasError && state.errorText != null;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              if (labelText != null)
                Padding(
                  padding: const EdgeInsets.only(left: 2.0, bottom: 6.0),
                  child: Text(
                    labelText!,
                    style: const TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500,
                      color: AppColors.secText,
                    ),
                  ),
                ),
              TextFormField(
                initialValue: initialValue,
                focusNode: focusNode,
                controller: controller,
                keyboardType: keyboardType,
                textInputAction: textInputAction,
                inputFormatters: inputFormatters,
                obscureText: obscureText,
                obscuringCharacter: obscuringCharacter,
                textCapitalization: textCapitalization,
                canRequestFocus: canRequestFocus,
                maxLength: maxLength,
                maxLines: maxLines,
                autofillHints: autofillHints,
                enableSuggestions: enableSuggestions,
                onChanged: (value) => _onChanged(value, state),
                onFieldSubmitted: (value) => _onSubmitted(state, value),
                onTapOutside: (_) => _onTapOutside(),
                onTap: onTap,
                style: const TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.w500,
                  color: AppColors.secText,
                ),
                decoration: InputDecoration(
                  hintText: hintText,
                  filled: filled,
                  fillColor: fillColor ?? AppColors.textFieldBg,
                  hintStyle: const TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.normal,
                  ),
                  error: showError ? const SizedBox.shrink() : null,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(radius),
                    borderSide: BorderSide(
                      color: Colors.black.withValues(alpha: .05),
                      width: 1.5,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(radius),
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                      width: 2.0,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(radius),
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.error,
                      width: 1.5,
                    ),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(radius),
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.error,
                      width: 1.5,
                    ),
                  ),
                  prefixIcon: prefixIconData != null
                      ? Icon(
                          prefixIconData,
                          // color: AppColors.soft,
                        )
                      : prefixIcon,
                  suffixIcon: suffixIcon,
                  contentPadding: kPagePadding,
                ),
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
      ),
    );
  }

  void _onChanged(String value, FormFieldState<String> state) {
    state.didChange(value);
    onChanged?.call(value);
    state.save();

    if (state.hasError) {
      state.validate();
    }
  }

  void _onSubmitted(FormFieldState<String> state, String value) {
    if (validateOnSubmit) state.validate();
    onSubmitted?.call(value);
  }

  void _onTapOutside() => FocusManager.instance.primaryFocus?.unfocus();
}
