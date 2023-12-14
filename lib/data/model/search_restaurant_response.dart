import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:restaurant_app/data/model/restaurant.dart';

SearchRestaurantResponse searchRestaurantResponseFromJson(String str) =>
    SearchRestaurantResponse.fromJson(json.decode(str));

class SearchRestaurantResponse extends Equatable {
  final bool error;
  final int founded;
  final List<Restaurant> restaurants;

  const SearchRestaurantResponse({
    required this.error,
    required this.founded,
    required this.restaurants,
  });

  factory SearchRestaurantResponse.fromJson(Map<String, dynamic> json) =>
      SearchRestaurantResponse(
        error: json["error"],
        founded: json["founded"],
        restaurants: List<Restaurant>.from(
            json["restaurants"].map((x) => Restaurant.fromJson(x))),
      );

  @override
  List<Object?> get props => [error, founded, restaurants];
}
