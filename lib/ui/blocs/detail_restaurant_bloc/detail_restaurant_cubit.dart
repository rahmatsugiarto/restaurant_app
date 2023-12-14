import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/common/res/strings.dart';
import 'package:restaurant_app/common/utils/random_pict.dart';
import 'package:restaurant_app/common/utils/view_data_state.dart';
import 'package:restaurant_app/data/remote/api_service.dart';
import 'package:restaurant_app/data/local/database_helper.dart';
import 'package:restaurant_app/data/model/list_restaurant_response.dart';

import 'detail_restaurant_state.dart';

class DetailRestaurantCubit extends Cubit<DetailRestaurantState> {
  final ApiService apiService;
  final DatabaseHelper db;

  DetailRestaurantCubit({required this.apiService, required this.db})
      : super(
          DetailRestaurantState(
            detailState: ViewData.initial(),
            isFav: false,
            category: "",
            addReviewState: ViewData.initial(),
            listRandomPict: [],
            saveFavoriteState: ViewData.initial(),
          ),
        );

  void getDetailRestaurant({required String id}) async {
    try {
      emit(state.copyWith(
        addReviewState: ViewData.initial(),
        detailState: ViewData.loading(),
      ));

      final result = await apiService.getDetailRestaurant(id: id);

      emit(state.copyWith(detailState: ViewData.loaded(data: result)));
      loadListRandomPict(
        reviewsLength: result.restaurant.customerReviews.length,
      );
    } on SocketException catch (e) {
      debugPrint(e.toString());
      emit(
        state.copyWith(
          detailState: ViewData.error(
            message: Strings.errorNetwork,
          ),
        ),
      );
    } catch (e) {
      debugPrint(e.toString());
      emit(
        state.copyWith(
          detailState: ViewData.error(
            message: Strings.somethingSeemsWrong,
          ),
        ),
      );
    }
  }

  void addReview({
    required String idRestaurant,
    required String review,
  }) async {
    try {
      emit(state.copyWith(
        detailState: ViewData.initial(),
        addReviewState: ViewData.loading(),
      ));

      final result = await apiService.addReview(
        idRestaurant: idRestaurant,
        review: review,
      );

      emit(state.copyWith(addReviewState: ViewData.loaded(data: result)));
      getDetailRestaurant(id: idRestaurant);
    } on SocketException catch (e) {
      debugPrint(e.toString());
      emit(
        state.copyWith(
          detailState: ViewData.error(
            message: Strings.errorNetwork,
          ),
        ),
      );
    } catch (e) {
      debugPrint("e.toString() : ${e.toString()}");
      emit(
        state.copyWith(
          detailState: ViewData.error(
            message: Strings.somethingSeemsWrong,
          ),
        ),
      );
    }
  }

  void loadListRandomPict({required int reviewsLength}) {
    final List<String> listRandomPict = [];
    for (int i = 1; i <= reviewsLength; i++) {
      final randomPict = getRandomPict();
      listRandomPict.add(randomPict);
    }

    emit(state.copyWith(listRandomPict: listRandomPict));
  }

  void saveFavorite(Restaurant restaurant) async {
    try {
      emit(state.copyWith(saveFavoriteState: ViewData.initial()));

      final bookmarkedArticle = await db.getFavoriteById(restaurant.id);
      final isFav = bookmarkedArticle.isNotEmpty;

      if (isFav) {
        await db.removeFavorite(restaurant.id);
      } else {
        await db.insertFavorite(restaurant);
      }

      checkFavorited(restaurant.id);
    } catch (e) {
      emit(state.copyWith(
          saveFavoriteState: ViewData.error(
        message: Strings.somethingSeemsWrong,
      )));
    }
  }

  Future<void> checkFavorited(String id) async {
    final bookmarkedArticle = await db.getFavoriteById(id);
    final isFav = bookmarkedArticle.isNotEmpty;

    if (state.detailState.status.isError) {
      emit(state.copyWith(
        isFav: isFav,
        detailState: ViewData.initial(),
      ));
    } else if (state.addReviewState.status.isError) {
      emit(state.copyWith(
        isFav: isFav,
        addReviewState: ViewData.initial(),
      ));
    } else {
      emit(state.copyWith(isFav: isFav));
    }
  }
}
