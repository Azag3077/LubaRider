import 'location.dart';

class Restaurant {
  const Restaurant({
    required this.id,
    required this.imageUrl,
    required this.name,
    required this.lowestPrice,
    required this.rating,
    required this.totalReview,
    required this.location,
  });

  final String id;
  final String imageUrl;
  final String name;
  final num lowestPrice;
  final double rating;
  final int totalReview;
  final Location location;
}

class RestaurantFood {
  const RestaurantFood({
    required this.id,
    required this.imageUrl,
    required this.name,
    required this.description,
    required this.price,
    required this.foods,
  });

  final String id;
  final String imageUrl;
  final String name;
  final String description;
  final num price;
  final List<Food> foods;
}

class Food {
  const Food({
    required this.id,
    required this.name,
    required this.price,
  });

  final String id;
  final String name;
  final num price;
}
