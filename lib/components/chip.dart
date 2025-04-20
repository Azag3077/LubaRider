import 'package:flutter/material.dart';

class CustomChip extends StatelessWidget {
  const CustomChip({
    super.key,
    required this.onPressed,
    required this.text,
    required this.iconData,
  });

  final VoidCallback onPressed;
  final String text;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0,
        vertical: 12.0,
      ),
      labelPadding: const EdgeInsets.only(left: 6.0, right: 4.0),
      visualDensity: const VisualDensity(
        vertical: -4,
        horizontal: -4,
      ),
      avatar: Icon(iconData),
      backgroundColor: Colors.white,
      label: Text(text),
      labelStyle: const TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 11.0,
      ),
      onPressed: onPressed,
    );
  }
}
