import 'package:country_state_city/models/country.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../components/country_bottom_sheet.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/constants/enums.dart';
import '../../../../core/extensions/num_duration.dart';

final personalDetailsPageViewProvider =
    NotifierProvider<_Notifier, _State>(_Notifier.new);

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

class _Notifier extends Notifier<_State> {
  @override
  _State build() => _State(country: kDefaultCountry);

  void updateFirstname(String value) =>
      state = state.copyWith(firstname: value);

  void updateLastname(String value) => state = state.copyWith(lastname: value);

  void updateGender(Gender? gender) => state = state.copyWith(gender: gender);

  void onPhoneChanged(String value) => state = state.copyWith(phone: value);

  void onEmailChanged(String value) => state = state.copyWith(email: value);

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
}
