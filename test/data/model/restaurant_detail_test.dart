import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_app/data/model/restaurant_detail.dart';

import '../../data_dummy/model/data_dummy_model.dart';
import '../../utils/json_reader.dart';

void main() {
  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('data_dummy/json/restaurant_detail.json'));
      // act
      final result = RestaurantDetail.fromJson(jsonMap);
      // assert
      expect(result, DataDummyModel.tRestaurantDetail);
    });
  });
}
