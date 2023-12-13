import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:restaurant_app/common/constant/app_constant.dart';
import 'package:restaurant_app/data/model/detail_restaurant_response.dart';
import 'package:restaurant_app/data/model/list_restaurant_response.dart';
import 'package:restaurant_app/data/model/search_restaurant_response.dart';

class ApiService {
  Future<ListRestaurantResponse> getListRestaurant() async {
    const url = AppConstant.baseUrlAPI + AppConstant.listRestaurantEndPoint;

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return restaurantsResponseFromJson(response.body);
    } else {
      throw Exception('Failed to load list restaurant');
    }
  }

  Future<DetailRestaurantResponse> getDetailRestaurant({
    required String id,
  }) async {
    final url =
        AppConstant.baseUrlAPI + AppConstant.detailRestaurantEndPoint + id;

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return detailRestaurantResponseFromJson(response.body);
    } else {
      throw Exception('Failed to load detail restaurant');
    }
  }

  Future<SearchRestaurantResponse> searchRestaurant({
    required String query,
  }) async {
    const url = AppConstant.baseUrlAPI + AppConstant.searchEndPoint;

    final response = await http.get(
      Uri.parse(url).replace(
        queryParameters: {
          'q': query,
        },
      ),
    );
    if (response.statusCode == 200) {
      debugPrint(response.body);
      return searchRestaurantResponseFromJson(response.body);
    } else {
      throw Exception('Failed to load search restaurant');
    }
  }

  Future<bool> addReview({
    required String idRestaurant,
    required String review,
  }) async {
    const url = AppConstant.baseUrlAPI + AppConstant.reviewEndPoint;
    Map data = {
      "id": idRestaurant,
      "name": "Rahmat",
      "review": review,
    };
    var body = json.encode(data);

    final response = await http.post(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: body,
    );

    if (response.statusCode == 201) {
      debugPrint(response.body);

      return true;
    } else {
      throw Exception('Failed to add review restaurant');
    }
  }
}
