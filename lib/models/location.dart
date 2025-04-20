import 'package:google_maps_flutter/google_maps_flutter.dart';
export 'package:google_maps_flutter/google_maps_flutter.dart';

class Location {
  const Location({
    required this.city,
    required this.address,
    required this.latlng,
  });

  final String city;
  final String address;
  final LatLng latlng;
}
