import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../components/dialogs.dart';
import '../../components/snackbar.dart';
import '../../core/extensions/num_duration.dart';
import '../../core/routers/app_routes.dart';
import '../settings/page.dart';

final resetPinPageProvider =
    AutoDisposeNotifierProvider<_Notifier, _State>(_Notifier.new);

class _State {
  const _State({
    this.pin1,
    this.pin2,
  });

  final String? pin1;
  final String? pin2;

  _State copyWith({
    String? pin1,
    String? pin2,
  }) {
    return _State(
      pin1: pin1 ?? this.pin1,
      pin2: pin2 ?? this.pin2,
    );
  }
}

class _Notifier extends AutoDisposeNotifier<_State> {
  bool _isIncorrectPin = false;

  @override
  _State build() => const _State();

  void updatePin1(String? value) => state = state.copyWith(pin1: value);

  void updatePin2(String? value) => state = state.copyWith(pin2: value);

  String? pin1Validator(value) {
    if (value == null) return 'This field is required';
    if (value.length != 5) return 'Incomplete pin';
    if (_isIncorrectPin) return 'Incorrect pin';
    return null;
  }

  String? pin2Validator(value) {
    if (value == null) return 'This field is required';
    if (value.length != 5) return 'Incomplete pin';
    if (value != state.pin1) return 'Pin mismatch';
    return null;
  }

  void onSettings(BuildContext context) =>
      pushNamed(context, SettingsPage.routeName);

  Future<void> onResetPin(
    BuildContext context,
    GlobalKey<FormState> formKey,
    GlobalKey<FormFieldState<String?>> fieldKey,
  ) async {
    formKey.currentState?.reset();
    await 200.ms.delayed;
    if (!formKey.currentState!.validate()) return;

    if (!context.mounted) return;

    showLoadingDialog(context);
    await 1.5.seconds.delayed;
    if (!context.mounted) return;
    pop(context);

    if (state.pin1 != '12345') {
      _isIncorrectPin = true;
      fieldKey.currentState?.validate();
      _isIncorrectPin = false;
      return;
    }

    pop(context);

    showSnackbar(
      context: context,
      title: 'Successful!!!',
      subtitle: 'Pin reset was successful.',
      type: SnackbarType.success,
    );
  }
}
