import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../components/dialogs.dart';
import '../../components/snackbar.dart';
import '../../core/extensions/num_duration.dart';
import '../../core/routers/app_routes.dart';
import '../../models/earning.dart';
import '../add_bank/page.dart';
import '../withdraw_earnings/page.dart';

final withdrawEarningsPageProvider =
    AutoDisposeNotifierProvider<_Notifier, _State>(_Notifier.new);

class _State {
  const _State({
    this.pin1,
    this.pin2,
    this.bankName = '',
    this.accountNumber = '',
    this.accountName = '',
  });

  final String? pin1;
  final String? pin2;
  final String bankName;
  final String accountNumber;
  final String accountName;

  _State copyWith({
    String? pin1,
    String? pin2,
    String? bankName,
    String? accountNumber,
    String? accountName,
  }) {
    return _State(
      pin1: pin1 ?? this.pin1,
      pin2: pin2 ?? this.pin2,
      bankName: bankName ?? this.bankName,
      accountNumber: accountNumber ?? this.accountNumber,
      accountName: accountName ?? this.accountName,
    );
  }
}

class _Notifier extends AutoDisposeNotifier<_State> {
  bool _isIncorrectPin = false;

  @override
  _State build() => const _State();

  void updatePin1(String? value) => state = state.copyWith(pin1: value);

  void updatePin2(String? value) => state = state.copyWith(pin2: value);

  void updateBankName(String value) => state = state.copyWith(bankName: value);

  void updateAccountNumber(String value) =>
      state = state.copyWith(accountNumber: value);

  void updateAccountName(String value) =>
      state = state.copyWith(accountName: value);

  void onEditBank(BuildContext context) =>
      pushNamed(context, AddBankPage.routeName);

  void onAddNewBank(BuildContext context) =>
      pushNamed(context, AddBankPage.routeName);

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

  Future<void> onSave(
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
      subtitle: 'Bank added successfully.',
      type: SnackbarType.success,
    );

    pushNamed(context, WithdrawEarningsPage.routeName);
  }

  void onViewEarning(BuildContext context, Earning earning) {}
}
