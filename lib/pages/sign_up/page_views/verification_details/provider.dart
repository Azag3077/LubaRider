import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/enums.dart';

final verificationDetailsPageViewProvider =
    NotifierProvider<_Notifier, _State>(_Notifier.new);

class _State {
  const _State({
    this.license,
    this.vehicleType,
    this.vehicleBrand,
    this.vehicleRegNum = '',
  });

  final String? license;
  final VehicleType? vehicleType;
  final String? vehicleBrand;
  final String vehicleRegNum;

  _State copyWith({
    String? license,
    VehicleType? vehicleType,
    String? vehicleBrand,
    String? vehicleRegNum,
    bool resetVehicleBrand = false,
  }) {
    return _State(
      license: license ?? this.license,
      vehicleType: vehicleType ?? this.vehicleType,
      vehicleBrand:
          resetVehicleBrand ? null : vehicleBrand ?? this.vehicleBrand,
      vehicleRegNum: vehicleRegNum ?? this.vehicleRegNum,
    );
  }
}

class _Notifier extends Notifier<_State> {
  @override
  _State build() => const _State();

  void updateLicense(String? value) => state = state.copyWith(license: value);

  void updateVehicleType(
    GlobalKey<FormFieldState<String?>> fieldKey,
    VehicleType? type,
  ) {
    final resetVehicleBrand = type != state.vehicleType;
    if (resetVehicleBrand) fieldKey.currentState?.didChange(null);

    state = state.copyWith(
      vehicleType: type,
      resetVehicleBrand: resetVehicleBrand,
    );
  }

  void updateVehicleBrand(String? brand) =>
      state = state.copyWith(vehicleBrand: brand);

  void updateVehicleRegNum(String value) =>
      state = state.copyWith(vehicleRegNum: value);
}
