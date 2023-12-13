import 'package:restaurant_app/common/utils/view_data_state.dart';
import 'package:restaurant_app/data/model/search_restaurant_response.dart';

class SearchState {
  final ViewData<SearchRestaurantResponse> searchState;
  const SearchState({
    required this.searchState,
  });

  SearchState copyWith({
    ViewData<SearchRestaurantResponse>? searchState,
  }) {
    return SearchState(
      searchState: searchState ?? this.searchState,
    );
  }
}
