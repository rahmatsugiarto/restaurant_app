import 'dart:convert';

RestaurantModel restaurantModelFromJson(String str) =>
    RestaurantModel.fromJson(json.decode(str));

class RestaurantModel {
  List<Restaurant> restaurants;

  RestaurantModel({required this.restaurants});

  factory RestaurantModel.fromJson(Map<String, dynamic> json) =>
      RestaurantModel(
        restaurants: List<Restaurant>.from(
          json["restaurants"].map(
            (x) => Restaurant.fromJson(x),
          ),
        ),
      );
}

class Restaurant {
  String id;
  String name;
  String description;
  String pictureId;
  String city;
  double rating;
  Menus menus;

  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
    required this.menus,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        pictureId: json["pictureId"],
        city: json["city"],
        rating: json["rating"]?.toDouble(),
        menus: Menus.fromJson(json["menus"]),
      );
}

class Menus {
  List<Menu> foods;
  List<Menu> drinks;

  Menus({required this.foods, required this.drinks});

  factory Menus.fromJson(Map<String, dynamic> json) => Menus(
        foods: List<Menu>.from(json["foods"].map((x) => Menu.fromJson(x))),
        drinks: List<Menu>.from(json["drinks"].map((x) => Menu.fromJson(x))),
      );
}

class Menu {
  String name;

  Menu({required this.name});

  factory Menu.fromJson(Map<String, dynamic> json) => Menu(name: json["name"]);
}
