import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_app/data/model/restaurant.dart';

import '../../data_dummy/model/data_dummy_model.dart';
import '../../utils/json_reader.dart';

void main() {
  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('data_dummy/json/restaurant.json'));
      // act
      final result = Restaurant.fromJson(jsonMap);
      // assert
      expect(result, DataDummyModel.tRestaurant);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      final result = DataDummyModel.tRestaurant.toJson();

      final expectedJsonMap = {
        "id": "rqdv5juczeskfw1e867",
        "name": "Melting Pot",
        "description": "description",
        "pictureId": "14",
        "city": "Medan",
        "rating": 4.2
      };

      expect(result, expectedJsonMap);
    });
  });
}
