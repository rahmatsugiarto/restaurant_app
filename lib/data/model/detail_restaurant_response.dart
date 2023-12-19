import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:restaurant_app/data/model/restaurant_detail.dart';

DetailRestaurantResponse detailRestaurantResponseFromJson(String str) =>
    DetailRestaurantResponse.fromJson(json.decode(str));

class DetailRestaurantResponse extends Equatable {
  final bool error;
  final String message;
  final RestaurantDetail restaurant;

  const DetailRestaurantResponse({
    required this.error,
    required this.message,
    required this.restaurant,
  });

  factory DetailRestaurantResponse.fromJson(Map<String, dynamic> json) =>
      DetailRestaurantResponse(
        error: json["error"],
        message: json["message"],
        restaurant: RestaurantDetail.fromJson(json["restaurant"]),
      );

  @override
  List<Object?> get props => [error, message, restaurant];
}
