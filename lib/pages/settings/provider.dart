import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/routers/app_routes.dart';
import '../privacy_policy/page.dart';
import '../reset_pin/page.dart';

final settingsPageProvider = Provider((_) => _Provider());

class _Provider {
  void onRiderHandbook(BuildContext context) =>
      pushNamed(context, BlankPage.routeName);

  void onResetPIN(BuildContext context) =>
      pushNamed(context, ResetPinPage.routeName);

  void onPrivacyPolicy(BuildContext context) =>
      pushNamed(context, PrivacyPolicyPage.routeName);

  void onTermsConditions(BuildContext context) =>
      pushNamed(context, BlankPage.routeName);

  void onLogout(BuildContext context) {}

  void onDeleteAccount(BuildContext context) {}
}
