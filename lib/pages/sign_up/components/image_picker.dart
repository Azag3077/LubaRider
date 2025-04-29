import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../components/animated_widgets.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/constants.dart';

class ImagePickerContainer extends StatelessWidget {
  const ImagePickerContainer({
    super.key,
    required this.labelText,
    this.labelTextStyle,
    this.imagePath,
    this.height,
    this.validator,
    this.onSaved,
  });

  static bool _imagePickerIsActive = false;

  final String labelText;
  final TextStyle? labelTextStyle;
  final String? imagePath;
  final double? height;
  final FormFieldValidator<String>? validator;
  final FormFieldSetter<String>? onSaved;

  void _onTap(FormFieldState<String?> state) async {
    if (_imagePickerIsActive) return;

    _imagePickerIsActive = true;
    final result = await ImagePicker().pickImage(source: ImageSource.gallery);
    _imagePickerIsActive = false;

    if (result == null) return;

    state.didChange(result.path);
    if (state.isValid) state.validate();
    state.save();
  }

  @override
  Widget build(BuildContext context) {
    return FormField<String?>(
      initialValue: imagePath,
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
            CustomPaint(
              foregroundPainter: DottedBorderPainter(
                radius: kTextFieldRadius,
                color: AppColors.primary,
              ),
              child: SizedBox(
                height: height ?? 150.0,
                child: MaterialButton(
                  onPressed: () => _onTap(state),
                  elevation: 0,
                  highlightElevation: 0,
                  minWidth: double.infinity,
                  color: AppColors.textFieldBg,
                  padding: EdgeInsets.zero,
                  clipBehavior: Clip.hardEdge,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(kTextFieldRadius),
                  ),
                  child: Column(
                    spacing: 8.0,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      if (state.value == null) ...[
                        const Icon(Icons.add, color: AppColors.primary),
                        const Text(
                          'Upload Picture',
                          style: TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF667085),
                          ),
                        ),
                      ] else
                        Expanded(
                          child: Image.file(
                            File(state.value!),
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        ),
                    ],
                  ),
                ),
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

class DottedBorderPainter extends CustomPainter {
  DottedBorderPainter({
    required this.color,
    this.bgColor,
    required this.radius,
    this.strokeWidth = 1.5,
    this.dashWidth = 6.0,
    this.gap = 4.0,
    this.drawInside = true,
  });

  final Color color;
  final Color? bgColor;
  final double radius;
  final double strokeWidth;
  final double dashWidth;
  final double gap;
  final bool? drawInside;

  @override
  void paint(Canvas canvas, Size size) {
    RRect rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Radius.circular(radius),
    );

    if (drawInside == true) {
      rrect = rrect.deflate(strokeWidth / 2);
    } else if (drawInside == false) {
      rrect = rrect.inflate(strokeWidth / 2);
    }

    if (bgColor != null) {
      final paint = Paint()..color = bgColor!;
      final a = rrect.deflate(0);
      canvas.drawRRect(a, paint);
    }

    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final path = Path()..addRRect(rrect);

    final dashSpace = gap;
    double distance = 0.0;

    for (PathMetric pathMetric in path.computeMetrics()) {
      while (distance < pathMetric.length) {
        final path = pathMetric.extractPath(distance, distance + dashWidth);

        distance += dashWidth + dashSpace;
        canvas.drawPath(path, paint);
      }
    }
  }

  @override
  bool shouldRepaint(DottedBorderPainter oldDelegate) =>
      oldDelegate.color != color ||
      oldDelegate.radius != radius ||
      oldDelegate.strokeWidth != strokeWidth ||
      oldDelegate.gap != gap;
}
