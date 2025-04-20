import 'package:country_state_city/models/country.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/colors.dart';

class PhoneNumberFieldPrefixButton extends StatelessWidget {
  const PhoneNumberFieldPrefixButton({
    super.key,
    this.country,
    this.isFocused = false,
    required this.onCodeTap,
  });

  final Country? country;
  final bool isFocused;
  final VoidCallback onCodeTap;

  String? get phoneCode {
    if (country == null) return null;
    if (country!.phoneCode.startsWith('+')) {
      return country!.phoneCode;
    }
    return '+${country!.phoneCode}';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 4.0),
      child: MaterialButton(
        minWidth: 0.0,
        padding: EdgeInsets.zero,
        onPressed: onCodeTap,
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 2.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              if (country == null) ...[
                Icon(
                  Icons.flag,
                  size: 18.0,
                  color: Colors.blueGrey.shade600,
                ),
                const SizedBox(width: 2.0),
                const Text('+'),
                const SizedBox(width: 2.0),
                ...List.generate(3, (_) {
                  return Icon(
                    Icons.emergency,
                    size: 12.0,
                    color: Colors.blueGrey.shade400,
                  );
                }),
              ] else ...[
                Text(
                  country!.flag,
                  style: const TextStyle(
                    fontSize: 18.0,
                  ),
                ),
                const SizedBox(width: 4.0),
                Text(
                  phoneCode!,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    color: AppColors.text,
                    fontSize: 16.0,
                  ),
                ),
              ],
              const Icon(
                Icons.expand_more,
                color: AppColors.text,
              ),
              const SizedBox(
                height: 34.0,
                child: VerticalDivider(width: 0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
