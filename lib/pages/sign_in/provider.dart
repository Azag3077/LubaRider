import 'package:country_state_city/models/country.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../components/country_bottom_sheet.dart';
import '../../components/dialogs.dart';
import '../../components/snackbar.dart';
import '../../core/constants/constants.dart';
import '../../core/extensions/num_duration.dart';
import '../../core/routers/app_routes.dart';
import '../../network/api_services/auth.dart';
import '../dashboard/page.dart';
import '../get_started/provider.dart';
import '../verify_otp/page.dart';

final signInPageProvider =
    AutoDisposeNotifierProvider<_Notifier, _State>(_Notifier.new);

class _State {
  const _State({
    this.obscureText = true,
    this.country,
  });

  final bool obscureText;
  final Country? country;

  _State copyWith({
    bool? obscureText,
    Country? country,
  }) {
    return _State(
      obscureText: obscureText ?? this.obscureText,
      country: country ?? this.country,
    );
  }
}

class _Notifier extends AutoDisposeNotifier<_State> {
  String _phone = '';

  @override
  _State build() => _State(country: kDefaultCountry);

  void onPhoneChanged(String value) => _phone = value;

  void onCodeTap(BuildContext context) {
    showModalBottomSheet(
      context: context,
      clipBehavior: Clip.hardEdge,
      isScrollControlled: true,
      sheetAnimationStyle: AnimationStyle(
        duration: 700.ms,
      ),
      builder: (_) {
        return CountryBottomSheet(
          selectedCountry: state.country,
          onSelected: (country) => state = state.copyWith(country: country),
        );
      },
    );
  }

  String _getPhoneNumberWithCountryCode() {
    if (state.country!.phoneCode.startsWith('+')) {
      return '${state.country!.phoneCode} $_phone';
    }
    return '+${state.country!.phoneCode} $_phone';
  }

  Future<void> onSignIn(
    BuildContext context,
    GlobalKey<FormState> formKey,
  ) async {
    if (!formKey.currentState!.validate()) return;

    showLoadingDialog(context);

    final phone = _getPhoneNumberWithCountryCode();
    final loginResult = await AuthService.loginUser(phone);

    if (!context.mounted) return;

    pop(context);

    if (loginResult.data!) return _handleLoginSuccess(context, phone);

    showSnackbar(
      context: context,
      title: loginResult.error!.title,
      subtitle: loginResult.error!.message,
      type: SnackbarType.error,
    );
  }

  Future<void> _handleLoginSuccess(BuildContext context, String phone) async {
    final verifyResult = await pushNamed(
      context,
      VerifyOtpPage.routeName,
      arguments: phone,
    );

    if (verifyResult != true || !context.mounted) return;

    pushReplacementNamed(context, DashboardPage.routeName);
  }

  void onSignUp(BuildContext context) =>
      ref.read(getStartedProvider).onSignUpAsANewRider(context);
}
