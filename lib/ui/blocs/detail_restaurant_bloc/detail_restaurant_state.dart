import 'package:restaurant_app/common/utils/view_data_state.dart';
import 'package:restaurant_app/data/model/detail_restaurant_response.dart';

class DetailRestaurantState {
  final ViewData<DetailRestaurantResponse> detailState;
  final bool isFav;
  final String category;

  const DetailRestaurantState({
    required this.detailState,
    required this.isFav,
    required this.category,
  });

  DetailRestaurantState copyWith({
    ViewData<DetailRestaurantResponse>? detailState,
    bool? isFav,
    String? category,
  }) {
    return DetailRestaurantState(
      detailState: detailState ?? this.detailState,
      isFav: isFav ?? this.isFav,
      category: category ?? this.category,
    );
  }
}
