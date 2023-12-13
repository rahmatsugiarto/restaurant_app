

import 'package:restaurant_app/common/utils/view_data_state.dart';
import 'package:restaurant_app/data/model/list_restaurant_response.dart';

class HomeState {
  final ViewData<ListRestaurantResponse> homeState;
  const HomeState({
    required this.homeState,
  });

  HomeState copyWith({
    ViewData<ListRestaurantResponse>? homeState,
  }) {
    return HomeState(
      homeState: homeState ?? this.homeState,
    );
  }
}
