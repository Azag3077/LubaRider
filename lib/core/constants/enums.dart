enum Gender { male, female }

enum VehicleType {
  bicycle,
  bike,
  car;

  List<String> get brands {
    switch (this) {
      case VehicleType.bicycle:
        return BicycleBrand.values.map((value) => value.label).toList();
      case VehicleType.bike:
        return BikeBrand.values.map((value) => value.label).toList();
      case VehicleType.car:
        return CarBrand.values.map((value) => value.label).toList();
    }
  }
}

enum BicycleBrand {
  trek('Trek'),
  giant('Giant'),
  specialized('Specialized'),
  cannondale(r'Cannondale'),
  scott('Scott'),
  bianchi('Bianchi'),
  santaCruz('Santa Cruz'),
  merida('Merida'),
  polygon('Polygon'),
  schwinn('Schwinn');

  final String label;

  const BicycleBrand(this.label);
}

enum BikeBrand {
  yamaha('Yamaha'),
  honda('Honda'),
  suzuki('Suzuki'),
  kawasaki('Kawasaki'),
  bmw('BMW'),
  ducati(r'Ducati'),
  harleyDavidson('Harley-Davidson'),
  ktm('KTM'),
  royalEnfield('Royal Enfield'),
  bajaj('Bajaj');

  final String label;

  const BikeBrand(this.label);
}

enum CarBrand {
  toyota('Toyota'),
  honda('Honda'),
  ford('Ford'),
  bmw('BMW'),
  mercedesBenz('Mercedes-Benz'),
  nissan('Nissan'),
  hyundai('Hyundai'),
  kia('Kia'),
  chevrolet('Chevrolet'),
  volkswagen('Volkswagen');

  final String label;

  const CarBrand(this.label);
}
