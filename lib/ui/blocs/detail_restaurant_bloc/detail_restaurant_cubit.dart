import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/common/res/strings.dart';
import 'package:restaurant_app/common/utils/view_data_state.dart';
import 'package:restaurant_app/data/api/api_service.dart';

import 'detail_restaurant_state.dart';

class DetailRestaurantCubit extends Cubit<DetailRestaurantState> {
  final ApiService apiService;

  DetailRestaurantCubit({required this.apiService})
      : super(
          DetailRestaurantState(
            detailState: ViewData.initial(),
            isFav: false,
            category: "",
            addReviewState: ViewData.initial(),
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

  void setIsFav() {
    emit(state.copyWith(isFav: !state.isFav));
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
}
