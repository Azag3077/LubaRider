import 'package:flutter_riverpod/flutter_riverpod.dart';

final termsAndConditionPageViewProvider =
    NotifierProvider<_Notifier, bool>(_Notifier.new);

class _Notifier extends Notifier<bool> {
  @override
  bool build() => false;

  void updateState(bool? value) => state = value!;
}
