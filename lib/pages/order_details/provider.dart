import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geocoding/geocoding.dart' hide Location;
import 'package:geolocator/geolocator.dart';

import '../../models/location.dart';

final orderDetailsPageProvider =
    AutoDisposeNotifierProvider<_Notifier, _State>(_Notifier.new);

class _State {
  const _State({
    this.isLoading = true,
    this.isError = false,
    this.errorMessage = '',
    this.placemark,
  });

  final Placemark? placemark;
  final bool isLoading;
  final bool isError;
  final String errorMessage;

  _State copyWith({
    Location? location,
    bool? isLoading,
    bool? isError,
    String? errorMessage,
    Placemark? placemark,
  }) {
    return _State(
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
      errorMessage: errorMessage ?? this.errorMessage,
      placemark: placemark ?? this.placemark,
    );
  }
}

class _Notifier extends AutoDisposeNotifier<_State> {
  final _controller = Completer<GoogleMapController>();
  final _tilt = 59.0;
  final _zoom = 15.0;

  bool _initialized = false;
  CameraPosition? _cameraPosition;

  @override
  _State build() {
    goToCurrentLocation();
    return const _State();
  }

  void onMapCreated(GoogleMapController controller) =>
      _controller.complete(controller);

  Future<void> updateCameraPosition() async {
    if (_cameraPosition == null) return;

    final controller = await _controller.future;

    final cameraUpdate = CameraUpdate.newCameraPosition(_cameraPosition!);
    await controller.animateCamera(cameraUpdate);
    _getAddressFromLatLng();
  }

  Future<void> _getAddressFromLatLng() async {
    state = state.copyWith(isLoading: true, isError: false);

    try {
      final placemarks = await placemarkFromCoordinates(
        _cameraPosition!.target.latitude,
        _cameraPosition!.target.longitude,
      );

      if (placemarks.isEmpty) {
        state = state.copyWith(
          isError: true,
          errorMessage: 'No address found',
        );
      } else {
        state = state.copyWith(placemark: placemarks.first);
      }
    } on SocketException catch (_) {
      state = state.copyWith(
        isError: true,
        errorMessage: 'Connection Error',
      );
    } catch (e) {
      state = state.copyWith(
        isError: true,
        errorMessage: 'Not a residential area',
      );
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> goToCurrentLocation() async {
    Position? position = await Geolocator.getLastKnownPosition();

    if (position != null) {
      _cameraPosition = CameraPosition(
        target: LatLng(position.latitude, position.longitude),
        tilt: _tilt,
        zoom: _zoom,
      );
      updateCameraPosition();
    }

    _initialized = true;
    await Geolocator.getCurrentPosition();
  }

  Future<void> goToLocation(LatLng latLng) async {
    final controller = await _controller.future;
    final getZoomLevel = await controller.getZoomLevel();

    _cameraPosition = CameraPosition(
      target: latLng,
      zoom: getZoomLevel,
    );
    updateCameraPosition();
  }

  void onCameraMove(CameraPosition cameraPosition) {
    if (!_initialized) return;
    _cameraPosition = cameraPosition;
  }

  void onCameraIdle() => _getAddressFromLatLng();

  Future<void> onConfirmLocation(BuildContext context) async {
    if (state.isError || state.isLoading) return;

    final controller = await _controller.future;

    final imageBytes = await controller.takeSnapshot();

    if (!context.mounted) return;

    // pushNamed(
    //   context,
    //   AddAddressPage.routeName,
    //   arguments: AddAddressPageArgs(
    //     placemark: state.placemark!,
    //     imageBytes: imageBytes,
    //   ),
    // );
  }
}
