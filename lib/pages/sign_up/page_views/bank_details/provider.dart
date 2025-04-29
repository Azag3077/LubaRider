import 'package:flutter_riverpod/flutter_riverpod.dart';

final bankDetailsPageViewProvider =
    NotifierProvider<_Notifier, _State>(_Notifier.new);

class _State {
  const _State({
    this.bankName,
    this.accountNumber = '',
    this.accountName = '',
  });

  final String? bankName;
  final String accountNumber;
  final String accountName;

  _State copyWith({
    String? bankName,
    String? accountNumber,
    String? accountName,
  }) {
    return _State(
      bankName: bankName ?? this.bankName,
      accountNumber: accountNumber ?? this.accountNumber,
      accountName: accountName ?? this.accountName,
    );
  }
}

class _Notifier extends Notifier<_State> {
  @override
  _State build() => const _State();

  void updateBankName(String? value) => state = state.copyWith(bankName: value);

  void updateAccountNumber(String value) =>
      state = state.copyWith(accountNumber: value);

  void updateAccountName(String value) =>
      state = state.copyWith(accountName: value);
}
