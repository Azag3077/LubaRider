import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../components/dialogs.dart';
import '../../core/constants/assets.dart';
import '../../core/extensions/num_duration.dart';
import '../../core/routers/app_routes.dart';
import '../../models/earning.dart';
import '../add_bank/page.dart';
import '../successful/page.dart';

final withdrawEarningsPageProvider =
    AutoDisposeNotifierProvider<_Notifier, _State>(_Notifier.new);

class _State {
  const _State({
    this.amount,
    this.pin,
  });

  final String? amount;
  final String? pin;

  _State copyWith({
    String? amount,
    String? pin,
  }) {
    return _State(
      amount: amount ?? this.amount,
      pin: pin ?? this.pin,
    );
  }
}

class _Notifier extends AutoDisposeNotifier<_State> {
  bool _isIncorrectPin = false;

  @override
  _State build() => const _State();

  void updateAmount(String value) => state = state.copyWith(amount: value);

  void updatePin(String? value) => state = state.copyWith(pin: value);

  String? pinValidator(value) {
    if (value == null) return 'This field is required';
    if (value.length != 5) return 'Incomplete pin';
    if (_isIncorrectPin) return 'Incorrect pin';
    return null;
  }

  void onEditBank(BuildContext context) =>
      pushNamed(context, AddBankPage.routeName);

  void onAddNewBank(BuildContext context) =>
      pushNamed(context, AddBankPage.routeName);

  Future<void> onWithdraw(
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

    if (state.pin != '12345') {
      _isIncorrectPin = true;
      fieldKey.currentState?.validate();
      _isIncorrectPin = false;
      return;
    }

    pushReplacementNamed(
      context,
      SuccessfulPage.routeName,
      arguments: const SuccessfulPageArgs(
        icon: ImageAssetNames.doubleCheckmark,
        title: 'Withdrawal request submitted successfully!',
        subtitle: 'You will receive a notification once processed.',
        actionButtonText: 'Okay!',
      ),
    );
  }

  void onViewEarning(BuildContext context, Earning earning) {}
}
