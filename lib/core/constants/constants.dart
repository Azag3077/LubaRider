import 'package:country_state_city/models/country.dart';
import 'package:flutter/cupertino.dart';

const kButtonRadius = 8.0;
const kTextFieldRadius = 8.0;
const kHSpace = 16.0;
const kVSpace = 8.0;
const kHPagePadding = EdgeInsets.symmetric(horizontal: kHSpace);
const kVPagePadding = EdgeInsets.symmetric(vertical: kVSpace);
final kPagePadding = kHPagePadding + kVPagePadding;

final kDefaultCountry = Country(
  name: 'Nigeria',
  isoCode: 'NG',
  phoneCode: '234',
  currency: 'NGN',
  flag: '🇳🇬',
  latitude: '10.00000000',
  longitude: '8.00000000',
);
