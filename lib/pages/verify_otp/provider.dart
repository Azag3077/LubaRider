import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../components/dialogs.dart';
import '../../components/snackbar.dart';
import '../../core/routers/router.dart';
import '../../network/api_services/auth.dart';

final verifyOtpPageProvider =
    AutoDisposeNotifierProvider<_Notifier, _State>(_Notifier.new);

class _State {
  const _State({
    this.countdown = 30,
    this.code = '',
  });

  final int countdown;
  final String code;

  _State copyWith({
    int? countdown,
    String? code,
  }) {
    return _State(
      countdown: countdown ?? this.countdown,
      code: code ?? this.code,
    );
  }
}

class _Notifier extends AutoDisposeNotifier<_State> {
  Timer? _timer;

  @override
  _State build() {
    Future.delayed(1.seconds, _startTimer);
    return const _State();
  }

  void _startTimer() {
    _timer?.cancel();
    state = state.copyWith(countdown: 30);
    _timer = Timer.periodic(1.seconds, _timerCallback);
  }

  void _timerCallback(Timer timer) {
    if (state.countdown == 0) return timer.cancel();

    state = state.copyWith(countdown: state.countdown - 1);
  }

  Future<void> resendCode(BuildContext context) async {
    showLoadingDialog(context);

    final result = await AuthService.resendCode();

    if (!context.mounted) return;

    pop(context);

    if (!context.mounted) return;

    if (result.data!) {
      _startTimer();
      return showSnackbar(
        context: context,
        title: 'Successful',
        subtitle: 'Verification code sent successfully!!!',
        type: SnackbarType.success,
      );
    }

    showSnackbar(
      context: context,
      title: result.error!.title,
      subtitle: result.error!.message,
      type: SnackbarType.error,
    );
  }

  void updateCode(String text) => state = state.copyWith(code: text);

  void onCompleted(BuildContext context, String text) {
    updateCode(text);
    onContinue(context);
  }

  Future<void> onContinue(BuildContext context) async {
    showLoadingDialog(context);

    final result = await AuthService.verifyCode(state.code);

    if (!context.mounted) return;

    pop(context);

    if (!context.mounted) return;

    if (result.data!) return pop(context, true);

    showSnackbar(
      context: context,
      title: result.error!.title,
      subtitle: result.error!.message,
      type: SnackbarType.error,
    );
  }
}
