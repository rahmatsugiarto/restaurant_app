import 'package:restaurant_app/data/model/category.dart';
import 'package:restaurant_app/data/model/customer_review.dart';
import 'package:restaurant_app/data/model/detail_restaurant_response.dart';
import 'package:restaurant_app/data/model/list_restaurant_response.dart';
import 'package:restaurant_app/data/model/menus.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/data/model/restaurant_detail.dart';
import 'package:restaurant_app/data/model/search_restaurant_response.dart';

class DataDummyModel {
  static const tCategory = Category(name: "Italia");

  static const tFood = Category(name: "Paket rosemary");

  static const tDrink = Category(name: "Es krim");

  static const tCustomerReview = CustomerReview(
    name: "Ahmad",
    review: "Tidak rekomendasi untuk pelajar!",
    date: "13 November 2019",
  );

  static const tMenus = Menus(
    foods: [tFood],
    drinks: [tDrink],
  );

  static const tRestaurantDetail = RestaurantDetail(
    id: "rqdv5juczeskfw1e867",
    name: "Melting Pot",
    description: "description",
    city: "Medan",
    address: "Jln. Pandeglang no 19",
    pictureId: "14",
    categories: [tCategory],
    menus: tMenus,
    rating: 4.2,
    customerReviews: [tCustomerReview],
  );

  static const tRestaurant = Restaurant(
    id: "rqdv5juczeskfw1e867",
    name: "Melting Pot",
    description: "description",
    city: "Medan",
    pictureId: "14",
    rating: 4.2,
  );

  static const tDetailRestaurantResponse = DetailRestaurantResponse(
    error: false,
    message: "success",
    restaurant: tRestaurantDetail,
  );

  static const tListRestaurantResponse = ListRestaurantResponse(
    error: false,
    message: "success",
    count: 20,
    restaurants: [tRestaurant],
  );

  static const tListRestaurantEmptyResponse = ListRestaurantResponse(
    error: false,
    message: "success",
    count: 20,
    restaurants: [],
  );

  static const tSearchRestaurantResponse = SearchRestaurantResponse(
    error: false,
    founded: 1,
    restaurants: [tRestaurant],
  );
}
