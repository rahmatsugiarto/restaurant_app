import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/common/utils/view_data_state.dart';
import 'package:restaurant_app/data/db/database_helper.dart';

import 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  final DatabaseHelper db;

  FavoriteCubit({required this.db})
      : super(FavoriteState(favState: ViewData.initial()));

  void getFavorites() async {
    emit(state.copyWith(favState: ViewData.loading()));
    final result = await db.getFavorites();
    if (result.isNotEmpty) {
      emit(state.copyWith(favState: ViewData.loaded(data: result)));
    } else {
      emit(state.copyWith(
          favState: ViewData.noData(
        message: "You don't have a favorite yet",
      )));
    }
  }
}
