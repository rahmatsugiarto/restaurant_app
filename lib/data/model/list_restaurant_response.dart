import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:restaurant_app/data/model/restaurant.dart';

ListRestaurantResponse restaurantsResponseFromJson(String str) =>
    ListRestaurantResponse.fromJson(json.decode(str));

class ListRestaurantResponse extends Equatable {
  final bool error;
  final String message;
  final int count;
  final List<Restaurant> restaurants;

  const ListRestaurantResponse({
    required this.error,
    required this.message,
    required this.count,
    required this.restaurants,
  });

  factory ListRestaurantResponse.fromJson(Map<String, dynamic> json) =>
      ListRestaurantResponse(
        error: json["error"],
        message: json["message"],
        count: json["count"],
        restaurants: List<Restaurant>.from(
            json["restaurants"].map((x) => Restaurant.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "count": count,
        "restaurants": List<dynamic>.from(restaurants.map((x) => x.toJson())),
      };

  @override
  List<Object?> get props => [error, message, count, restaurants];
}
