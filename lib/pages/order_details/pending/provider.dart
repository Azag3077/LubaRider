import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/routers/router.dart';
import '../../../models/order.dart';
import '../../home/ongoing/provider.dart';
import '../../home/provider.dart';

final pendingBottomSheetProvider = Provider((ref) => _Provider(ref));

class _Provider {
  _Provider(this._ref);

  final Ref _ref;

  void onCancel(BuildContext context, Order order) {
    _ref.read(homePageProvider.notifier).onCancel(context, order);
    pop(context);
  }

  void onAccept(BuildContext context, Order order) {
    _ref.read(homePageProvider.notifier).onAccept(context, order);
    _ref.read(uselessProvider.notifier).state = true;
    pop(context);
  }
}
