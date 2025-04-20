import 'package:flutter/material.dart';

final navigatorKey = GlobalKey<NavigatorState>();

Future<T?> pushNamed<T extends Object?>(
  BuildContext context,
  String routeName, {
  Object? arguments,
}) async =>
    await Navigator.of(context).pushNamed<T>(routeName, arguments: arguments);

Future<void> pushReplacementNamed(
  BuildContext context,
  String routeName, {
  Object? arguments,
}) async =>
    await Navigator.pushReplacementNamed(context, routeName,
        arguments: arguments);

void pushNamedAndRemoveUntil(
  BuildContext context,
  String routeName, {
  String until = '/',
  Object? arguments,
}) =>
    Navigator.pushNamedAndRemoveUntil(
      context,
      routeName,
      (route) => route.settings.name == until,
      arguments: arguments,
    );

void popUntil(BuildContext context, [String routeName = '/']) {
  Navigator.popUntil(context, ModalRoute.withName(routeName));

  if (!Navigator.canPop(context)) {
    Navigator.pushNamedAndRemoveUntil(context, routeName, (route) => false);
  }
}

void pop<T extends Object?>(BuildContext context, [T? result]) =>
    Navigator.of(context).pop<T>(result);
