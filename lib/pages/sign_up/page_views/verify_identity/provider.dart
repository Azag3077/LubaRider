import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../provider.dart';

final verificationDetailsPageViewProvider =
    NotifierProvider<_Notifier, String?>(_Notifier.new);

class _Notifier extends Notifier<String?> {
  @override
  String? build() => null;

  void onFinishRegistration(BuildContext context) {
    ref.read(signUpPageProvider.notifier).onContinue(context);
  }

  void onRetakePhoto(BuildContext context) {}
}
