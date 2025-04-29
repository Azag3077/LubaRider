import 'package:flutter/material.dart';

import '../core/constants/colors.dart';
import '../core/constants/constants.dart';
import 'animated_widgets.dart';
import 'bottom_sheet.dart';

class SocialButton extends StatelessWidget {
  const SocialButton({
    super.key,
    required this.icon,
    required this.text,
    required this.onPressed,
  });

  final String icon;
  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      padding: const EdgeInsets.all(10.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(kButtonRadius),
        side: const BorderSide(color: AppColors.borderColor),
      ),
      child: Row(
        spacing: 8.0,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(icon),
          Text(
            text,
            style: const TextStyle(
              fontSize: 13.0,
              color: AppColors.grey,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class CheckboxTextButton extends StatelessWidget {
  const CheckboxTextButton({
    super.key,
    required this.initialValue,
    required this.text,
    this.style,
    this.onSaved,
    this.validator,
    this.fieldKey,
  });

  final bool initialValue;
  final String text;
  final TextStyle? style;
  final FormFieldValidator<bool>? validator;
  final FormFieldSetter<bool>? onSaved;
  final GlobalKey<FormFieldState<bool>>? fieldKey;

  @override
  Widget build(BuildContext context) {
    return FormField<bool>(
      key: fieldKey,
      onSaved: onSaved,
      validator: validator,
      initialValue: initialValue,
      builder: (FormFieldState<bool> state) {
        final showError = state.hasError && state.errorText != null;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            MaterialButton(
              onPressed: () {
                state.didChange(!(state.value ?? initialValue));
                if (state.isValid) state.validate();
                state.save();
              },
              padding: const EdgeInsets.fromLTRB(4.0, 4.0, 8.0, 4.0),
              child: Row(
                spacing: 4.0,
                children: <Widget>[
                  IgnorePointer(
                    child: Checkbox(
                      value: state.value,
                      onChanged: (_) {},
                      visualDensity: const VisualDensity(
                        horizontal: -4.0,
                        vertical: -4.0,
                      ),
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      side: const BorderSide(
                        width: 1.5,
                        color: AppColors.checkboxBorderColor,
                      ),
                    ),
                  ),
                  Flexible(child: Text(text, style: style)),
                ],
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
    );
  }
}

class SelectionButton<T> extends StatelessWidget {
  const SelectionButton({
    super.key,
    this.fieldKey,
    this.labelText,
    this.hintText,
    this.initialValue,
    this.bottomSheetTitle,
    required this.bottomSheetItems,
    this.textBuilder,
    this.onSaved,
    this.margin = const EdgeInsets.only(bottom: 16.0),
    this.validator,
  });

  final GlobalKey<FormFieldState<T>>? fieldKey;
  final String? labelText;
  final String? hintText;
  final T? initialValue;
  final String? bottomSheetTitle;
  final List<T> bottomSheetItems;
  final String? Function(T?)? textBuilder;
  final EdgeInsets margin;
  final FormFieldValidator<T>? validator;
  final FormFieldSetter<T>? onSaved;

  void _showGenderBottomSheet(BuildContext context, FormFieldState<T> state) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return CustomBottomSheet<T>(
          title: bottomSheetTitle ?? hintText ?? labelText ?? '',
          items: bottomSheetItems,
          selected: initialValue,
          isLoading: false,
          buildText: textBuilder,
          onSelected: (gender) {
            state.didChange(gender);
            if (state.isValid) state.validate();
            state.save();
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = TextStyle(
      fontSize: 15.0,
      fontWeight: FontWeight.normal,
      color: Colors.black.withValues(alpha: .79),
    );

    if (initialValue == null) {
      textStyle = textStyle.copyWith(
        fontSize: 14.0,
        color: Theme.of(context).hintColor,
        fontWeight: FontWeight.normal,
      );
    }

    return FormField<T>(
      key: fieldKey,
      onSaved: onSaved,
      validator: validator,
      initialValue: initialValue,
      builder: (FormFieldState<T> state) {
        final showError = state.hasError && state.errorText != null;

        return Padding(
          padding: margin,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Column(
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
                  MaterialButton(
                    onPressed: () => _showGenderBottomSheet(context, state),
                    elevation: 0,
                    highlightElevation: 0,
                    color: AppColors.textFieldBg,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 12.0,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      side: BorderSide(
                        width: 1.5,
                        color: showError
                            ? Theme.of(context).colorScheme.error
                            : Colors.black.withValues(alpha: .05),
                      ),
                    ),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            textBuilder?.call(state.value) ?? hintText ?? '',
                            style: textStyle,
                          ),
                        ),
                        Icon(
                          Icons.expand_more,
                          color: Theme.of(context).hintColor,
                        ),
                      ],
                    ),
                  ),
                ],
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
          ),
        );
      },
    );
  }
}

class RadioButton extends StatelessWidget {
  const RadioButton({
    super.key,
    required this.text,
    required this.isSelected,
    required this.onPressed,
    this.showBorder = true,
    this.height = 56.0,
    this.padding = const EdgeInsets.all(12.0),
  });

  final String text;
  final bool isSelected;
  final EdgeInsets? padding;
  final bool showBorder;
  final double height;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      height: height,
      elevation: 0,
      highlightElevation: 0,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      padding: padding,
      shape: showBorder
          ? RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6.0),
              side: const BorderSide(
                color: AppColors.greyOutline,
                width: 1.2,
              ),
            )
          : null,
      child: Row(
        spacing: 8.0,
        children: <Widget>[
          IgnorePointer(
            child: Radio(
              value: isSelected,
              groupValue: true,
              onChanged: (_) {},
              visualDensity: const VisualDensity(
                horizontal: -4.0,
                vertical: -4.0,
              ),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              fillColor: WidgetStatePropertyAll(
                isSelected
                    ? Theme.of(context).primaryColor
                    : AppColors.hintColor,
              ),
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: AppColors.secText,
                fontSize: 13.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
