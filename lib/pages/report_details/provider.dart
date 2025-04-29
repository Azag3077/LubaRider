import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/routers/app_routes.dart';
import '../report_submitted/page.dart';

final reportDetailsPageProvider =
    AutoDisposeNotifierProvider<_Notifier, _State>(_Notifier.new);

class _State {
  const _State({
    this.choice,
    this.details,
    this.photo,
  });

  final String? choice;
  final String? details;
  final String? photo;

  _State copyWith({
    String? choice,
    String? details,
    String? photo,
  }) {
    return _State(
      choice: choice ?? this.choice,
      details: details ?? this.details,
      photo: photo ?? this.photo,
    );
  }
}

class _Notifier extends AutoDisposeNotifier<_State> {
  @override
  _State build() => const _State();

  void updateChoice(String value) => state = state.copyWith(choice: value);

  void updateDetails(String value) => state = state.copyWith(details: value);

  void updatePhoto(String? value) => state = state.copyWith(photo: value);

  Future<void> onProceed(BuildContext context) =>
      pushNamed(context, ReportSubmittedPage.routeName);
}
