import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_app/data/model/list_restaurant_response.dart';

import '../../data_dummy/model/data_dummy_model.dart';
import '../../utils/json_reader.dart';

void main() {
  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap = json
          .decode(readJson('data_dummy/json/list_restaurant_response.json'));
      // act
      final result = ListRestaurantResponse.fromJson(jsonMap);
      // assert
      expect(result, DataDummyModel.tListRestaurantResponse);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      final result = DataDummyModel.tListRestaurantResponse.toJson();

      final expectedJsonMap = {
        "error": false,
        "message": "success",
        "count": 20,
        "restaurants": [
          {
            "id": "rqdv5juczeskfw1e867",
            "name": "Melting Pot",
            "description": "description",
            "pictureId": "14",
            "city": "Medan",
            "rating": 4.2
          }
        ]
      };

      expect(result, expectedJsonMap);
    });
  });
}
