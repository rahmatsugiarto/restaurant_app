import 'package:restaurant_app/common/utils/view_data_state.dart';
import 'package:restaurant_app/data/model/restaurant.dart';

class FavoriteState {
  final ViewData<List<Restaurant>> favState;
  const FavoriteState({required this.favState});

  FavoriteState copyWith({
    ViewData<List<Restaurant>>? favState,
  }) {
    return FavoriteState(favState: favState ?? this.favState);
  }
}
