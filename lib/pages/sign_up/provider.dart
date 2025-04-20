import 'package:country_state_city/models/country.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../components/dialogs.dart';
import '../../components/snackbar.dart';
import '../../core/constants/assets.dart';
import '../../core/constants/constants.dart';
import '../../core/constants/enums.dart';
import '../../core/extensions/num_duration.dart';
import '../../core/routers/app_routes.dart';
import '../../network/api_services/auth.dart';
import '../sign_in/page.dart';
import '../successful/page.dart';
import '../verify_otp/page.dart';
import 'components/country_bottom_sheet.dart';

final signUpPageProvider =
    AutoDisposeNotifierProvider<_Notifier, _State>(_Notifier.new);

class _State {
  const _State({
    this.gender,
    this.dob,
    this.country,
    this.firstname = '',
    this.lastname = '',
    this.phone = '',
    this.email = '',
  });

  final Gender? gender;
  final DateTime? dob;
  final Country? country;
  final String firstname;
  final String lastname;
  final String phone;
  final String email;

  _State copyWith({
    Gender? gender,
    DateTime? dob,
    Country? country,
    String? firstname,
    String? lastname,
    String? phone,
    String? email,
  }) {
    return _State(
      dob: dob ?? this.dob,
      gender: gender ?? this.gender,
      country: country ?? this.country,
      firstname: firstname ?? this.firstname,
      lastname: lastname ?? this.lastname,
      phone: phone ?? this.phone,
      email: email ?? this.email,
    );
  }
}

class _Notifier extends AutoDisposeNotifier<_State> {
  @override
  _State build() => _State(country: kDefaultCountry);

  void onFirstnameChanged(String value) =>
      state = state.copyWith(firstname: value);

  void onLastnameChanged(String value) =>
      state = state.copyWith(lastname: value);

  void onEmailChanged(String value) => state = state.copyWith(email: value);

  void onPhoneChanged(String value) => state = state.copyWith(phone: value);

  void updateDOB(DateTime? dob) => state = state.copyWith(dob: dob);

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

  Future<void> onSignUp(
    BuildContext context,
    GlobalKey<FormState> formKey,
  ) async {
    formKey.currentState!.reset();
    await 200.ms.delayed;
    if (!formKey.currentState!.validate() || !context.mounted) return;

    showLoadingDialog(context);

    final result = await AuthService.registerUser(
      email: state.email,
      phone: state.phone,
      country: state.country!.name,
      password: '_password',
    );

    if (!context.mounted) return;

    pop(context);

    if (result.data!) return _handleSuccess(context);

    showSnackbar(
      context: context,
      title: result.error!.title,
      subtitle: result.error!.message,
      type: SnackbarType.error,
    );
  }

  String? get _getPhoneNumberWithCountryCode {
    if (state.country!.phoneCode.startsWith('+')) {
      return '${state.country!.phoneCode} ${state.phone}';
    }
    return '+${state.country!.phoneCode} ${state.phone}';
  }

  Future<void> _handleSuccess(BuildContext context) async {
    showSnackbar(
      context: context,
      title: 'Successful',
      subtitle: 'Registration successful!!!',
      type: SnackbarType.success,
    );

    final result = await pushNamed(
      context,
      VerifyOtpPage.routeName,
      arguments: _getPhoneNumberWithCountryCode,
    );

    if (result != true || !context.mounted) return;

    await pushNamed(
      context,
      SuccessfulPage.routeName,
      arguments: const SuccessfulPageArgs(
        icon: ImageAssetNames.successful,
        title: 'Verification Successful!',
        subtitle: 'Your account has been successfully verified. '
            "You're all set to start using the app.",
      ),
    );

    if (!context.mounted) return;

    // pushReplacementNamed(context, GrantLocationPermissionPage.routeName);
    // pushNamed(context, GrantLocationPermissionPage.routeName);
  }

  void onSignIn(BuildContext context) =>
      pushReplacementNamed(context, SignInPage.routeName);
}
