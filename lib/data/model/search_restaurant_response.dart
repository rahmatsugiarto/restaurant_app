import 'dart:convert';

import 'package:restaurant_app/data/model/list_restaurant_response.dart';

SearchRestaurantResponse searchRestaurantResponseFromJson(String str) =>
    SearchRestaurantResponse.fromJson(json.decode(str));

class SearchRestaurantResponse {
  bool error;
  int founded;
  List<Restaurant> restaurants;

  SearchRestaurantResponse({
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
}
