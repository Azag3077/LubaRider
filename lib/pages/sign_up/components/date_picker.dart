import 'package:flutter/material.dart';

import '../../../components/animated_widgets.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/constants.dart';
import '../../../core/extensions/num_duration.dart';

class _DayMonthYearContainer extends StatelessWidget {
  const _DayMonthYearContainer({
    required this.label,
    required this.error,
    this.text,
  });

  final String label;
  final String? text;
  final bool error;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 50.0,
        width: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.textFieldBg,
          borderRadius: BorderRadius.circular(kTextFieldRadius),
          border: Border.all(
            color: error
                ? Theme.of(context).colorScheme.error
                : Colors.black.withValues(alpha: .05),
            width: 1.5,
          ),
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Center(
                child: text == null
                    ? Text(label)
                    : Text(
                        text!,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF667085),
                          fontSize: 13.0,
                        ),
                      ),
              ),
            ),
            const Icon(
              Icons.expand_more,
              size: 18.0,
              color: Color(0xFF667085),
            ),
            const SizedBox(width: 8.0)
          ],
        ),
      ),
    );
  }
}

class DatePickerContainer extends StatelessWidget {
  const DatePickerContainer({
    super.key,
    required this.labelText,
    this.datetime,
    this.validator,
    this.onSaved,
  });

  final String labelText;
  final DateTime? datetime;
  final FormFieldValidator<DateTime>? validator;
  final FormFieldSetter<DateTime>? onSaved;

  void _onTap(BuildContext context, FormFieldState<DateTime?> state) async {
    final result = await showDatePicker(
      context: context,
      initialDate: datetime,
      lastDate: DateTime.now().subtract(18.years),
      firstDate: DateTime.now().subtract(100.years),
      initialDatePickerMode: DatePickerMode.year,
    );

    if (result == null) return;

    state.didChange(result);
    if (state.isValid) state.validate();
    state.save();
  }

  @override
  Widget build(BuildContext context) {
    return FormField<DateTime?>(
      initialValue: datetime,
      validator: validator,
      onSaved: onSaved,
      builder: (FormFieldState<DateTime?> state) {
        final showError = state.hasError && state.errorText != null;

        return Column(
          children: <Widget>[
            GestureDetector(
              onTap: () => _onTap(context, state),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 2.0, bottom: 6.0),
                    child: Text(
                      labelText,
                      style: const TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                        color: AppColors.secText,
                      ),
                    ),
                  ),
                  Row(
                    spacing: 8.0,
                    children: <Widget>[
                      _DayMonthYearContainer(
                        label: 'Year',
                        text: datetime?.day.toString(),
                        error: showError,
                      ),
                      _DayMonthYearContainer(
                        label: 'Month',
                        text: datetime?.month.toString(),
                        error: showError,
                      ),
                      _DayMonthYearContainer(
                        label: 'Day',
                        text: datetime?.year.toString(),
                        error: showError,
                      ),
                    ],
                  ),
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
