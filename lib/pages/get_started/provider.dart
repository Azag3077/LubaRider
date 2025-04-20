import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/routers/app_routes.dart';
import '../sign_up/page.dart';
import '../sign_in/page.dart';

final getStartedProvider = Provider((_) => _Provider());

class _Provider {
  void onSignUpAsANewRider(BuildContext context) =>
      pushNamed(context, SignUpPage.routeName);

  void onSignUpAsPartner(BuildContext context) =>
      pushNamed(context, SignUpPage.routeName);

  void onLogIn(BuildContext context) =>
      pushNamed(context, SignInPage.routeName);
}
