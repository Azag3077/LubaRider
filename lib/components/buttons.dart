import 'package:flutter/material.dart';

import '../core/constants/colors.dart';
import '../core/constants/constants.dart';

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

class CheckBoxTextButton extends StatelessWidget {
  const CheckBoxTextButton({
    super.key,
    required this.value,
    required this.text,
    required this.onToggle,
  });

  final bool value;
  final String text;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onToggle,
      padding: const EdgeInsets.fromLTRB(4.0, 4.0, 8.0, 4.0),
      child: Row(
        spacing: 4.0,
        children: <Widget>[
          IgnorePointer(
            child: Checkbox(
              value: value,
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
          Text(text),
        ],
      ),
    );
  }
}
