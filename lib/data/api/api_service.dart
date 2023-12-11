import 'package:http/http.dart' as http;
import 'package:restaurant_app/common/constant/app_constant.dart';
import 'package:restaurant_app/data/model/detail_restaurant_response.dart';
import 'package:restaurant_app/data/model/list_restaurant_response.dart';

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
}
