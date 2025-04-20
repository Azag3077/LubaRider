import 'package:flutter_riverpod/flutter_riverpod.dart';

final dashboardPageProvider =
    AutoDisposeNotifierProvider<_Notifier, int>(_Notifier.new);

class _Notifier extends AutoDisposeNotifier<int> {
  @override
  int build() => 0;

  void updatePageIndex(int value) => state = value;
}
