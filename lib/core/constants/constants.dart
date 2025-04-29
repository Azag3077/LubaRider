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

final deliveryIssues = <Map<String, dynamic>>[
  {
    'title': 'Order Delayed (Time update)',
    'subIssues': [
      'Traffic Congestion',
      'Rider Took Longer Route',
      'Vendor Took Longer to Prepare Order',
      'Waiting at Pickup Location',
      'Unexpected Stop (e.g., security check)',
      'Others'
    ]
  },
  {
    'title': 'Bike Issue',
    'subIssues': [
      'Flat Tire',
      "Engine Won't Start",
      'Brake Issues',
      'Battery/Charging Problem',
      'Chain/Sprocket Issues',
      'Fuel Problems',
      'Others'
    ]
  },
  {
    'title': 'Possible Duplicate',
    'subIssues': [
      'Duplicate Order by Customer',
      'Vendor Entered Order Twice',
      'System Error (App Glitch)',
      'Payment Made Twice',
      'Miscommunication with Customer',
      'Others'
    ]
  },
  {
    'title': 'Can’t locate vendor',
    'subIssues': [
      'Wrong Vendor Address',
      'Vendor Moved Without Updating Location',
      'GPS/Map Error',
      'Vendor Closed Shop Temporarily',
      'Contact Number Not Working',
      'Others'
    ]
  },
  {
    'title': 'Bridge Crossing',
    'subIssues': [
      'Bridge Closed for Maintenance',
      'Traffic Jam on Bridge',
      'Detour Needed (Alternate Route)',
      'Long Waiting Time at Bridge',
      'Police/Checkpoints Delays',
      'Others'
    ]
  },
  {
    'title': 'Customer is Changing location',
    'subIssues': [
      'Customer Requested New Address',
      'Customer Moving Midway (in transit)',
      'Customer Unreachable After Change',
      'New Location is Out of Service Area',
      'Multiple Location Changes',
      'Others'
    ]
  },
  {
    'title': 'Vendor not reachable',
    'subIssues': [
      "Vendor's Phone Switched Off",
      'Vendor Busy (Not Picking Up)',
      'Vendor Number Incorrect',
      'Vendor Business Closed',
      'Vendor Unresponsive on Chat/Call',
      'Others'
    ]
  },
  {
    'title': 'Delay due to Rain',
    'subIssues': [
      'Heavy Rain Making Roads Unusable',
      'Visibility Very Poor',
      'Bike Safety Concerns (Slippery Roads)',
      'Traffic Slow Due to Weather',
      'Waiting for Rain to Subside',
      'Rider Safety Instructions (Wait)',
      'Others'
    ]
  }
];
