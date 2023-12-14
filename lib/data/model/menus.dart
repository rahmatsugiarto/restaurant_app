import 'package:equatable/equatable.dart';
import 'package:restaurant_app/data/model/category.dart';

class Menus extends Equatable {
  final List<Category> foods;
  final List<Category> drinks;

  const Menus({required this.foods, required this.drinks});

  factory Menus.fromJson(Map<String, dynamic> json) => Menus(
        foods:
            List<Category>.from(json["foods"].map((x) => Category.fromJson(x))),
        drinks: List<Category>.from(
            json["drinks"].map((x) => Category.fromJson(x))),
      );

  @override
  List<Object?> get props => [foods, drinks];
}
