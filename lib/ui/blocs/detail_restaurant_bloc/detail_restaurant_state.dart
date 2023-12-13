import 'package:restaurant_app/common/utils/view_data_state.dart';
import 'package:restaurant_app/data/model/detail_restaurant_response.dart';

class DetailRestaurantState {
  final ViewData<DetailRestaurantResponse> detailState;
  final bool isFav;
  final String category;
  final ViewData<bool> addReviewState;
  final List<String> listRandomPict;
  final ViewData saveFavoriteState;

  const DetailRestaurantState({
    required this.detailState,
    required this.isFav,
    required this.category,
    required this.addReviewState,
    required this.listRandomPict,
    required this.saveFavoriteState,
  });

  DetailRestaurantState copyWith({
    ViewData<DetailRestaurantResponse>? detailState,
    bool? isFav,
    String? category,
    ViewData<bool>? addReviewState,
    List<String>? listRandomPict,
    ViewData? saveFavoriteState,
  }) {
    return DetailRestaurantState(
      detailState: detailState ?? this.detailState,
      isFav: isFav ?? this.isFav,
      category: category ?? this.category,
      addReviewState: addReviewState ?? this.addReviewState,
      listRandomPict: listRandomPict ?? this.listRandomPict,
      saveFavoriteState: saveFavoriteState ?? this.saveFavoriteState,
    );
  }
}
