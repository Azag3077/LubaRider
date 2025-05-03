import 'package:flutter/material.dart';

import '../../../components/animated_widgets.dart';
import '../../../core/constants/assets.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/constants.dart';
import '../../../core/constants/enums.dart';
import '../../../core/extensions/string.dart';

class VehicleTypeSelector extends StatelessWidget {
  const VehicleTypeSelector({
    super.key,
    required this.labelText,
    this.type,
    this.validator,
    this.onSaved,
  });

  final String labelText;
  final VehicleType? type;
  final FormFieldValidator<VehicleType>? validator;
  final FormFieldSetter<VehicleType>? onSaved;

  Widget _buildContainer({
    required String icon,
    required VehicleType type,
    required FormFieldState<VehicleType?> state,
  }) {
    final selected = state.value == type;

    return Expanded(
      child: MaterialButton(
        onPressed: () => _onSelected(state, type),
        padding: const EdgeInsets.only(
          top: 18.0,
          bottom: 8.0,
        ),
        elevation: 0,
        highlightElevation: 0,
        color: selected ? AppColors.primary.withValues(alpha: .07) : null,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kTextFieldRadius),
          side: BorderSide(
            width: 1.6,
            color: selected ? AppColors.primary : AppColors.greyOutline,
          ),
        ),
        child: Column(
          spacing: 8.0,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(icon),
            Text(
              type.name.title,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 12.0,
                color: Color(0xFF667085),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onSelected(
    FormFieldState<VehicleType?> state,
    VehicleType type,
  ) async {
    state.didChange(type);
    if (state.isValid) state.validate();
    state.save();
  }

  @override
  Widget build(BuildContext context) {
    return FormField<VehicleType?>(
      initialValue: type,
      validator: validator,
      onSaved: onSaved,
      builder: (FormFieldState<VehicleType?> state) {
        final showError = state.hasError && state.errorText != null;

        return Column(
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
              spacing: 6.0,
              children: <Widget>[
                _buildContainer(
                  icon: ImageAssetNames.bicycle,
                  type: VehicleType.bicycle,
                  state: state,
                ),
                _buildContainer(
                  icon: ImageAssetNames.bike,
                  type: VehicleType.bike,
                  state: state,
                ),
                _buildContainer(
                  icon: ImageAssetNames.car,
                  type: VehicleType.car,
                  state: state,
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
        );
      },
    );
  }
}
