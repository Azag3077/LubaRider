import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final deliveryIssuesPageProvider =
    NotifierProvider<_Notifier, int>(_Notifier.new);

class _Notifier extends Notifier<int> {
  @override
  int build() => 0;

  void onTap(BuildContext context) {}
}
