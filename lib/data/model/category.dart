import 'package:equatable/equatable.dart';

class Category extends Equatable {
  final String name;

  const Category({required this.name});

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        name: json["name"],
      );

  @override
  List<Object?> get props => [name];
}
