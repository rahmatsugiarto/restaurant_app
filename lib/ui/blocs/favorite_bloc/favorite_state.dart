import 'package:restaurant_app/common/utils/view_data_state.dart';
import 'package:restaurant_app/data/model/list_restaurant_response.dart';

class FavoriteState {
  final ViewData<List<Restaurant>> favState;
  const FavoriteState({required this.favState});

  FavoriteState copyWith({
    ViewData<List<Restaurant>>? favState,
  }) {
    return FavoriteState(favState: favState ?? this.favState);
  }
}
