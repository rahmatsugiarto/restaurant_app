import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/common/res/strings.dart';
import 'package:restaurant_app/common/utils/view_data_state.dart';
import 'package:restaurant_app/data/api/api_service.dart';

import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final ApiService apiService;

  HomeCubit({required this.apiService})
      : super(HomeState(homeState: ViewData.initial()));

  void getListRestaurant() async {
    try {
      emit(
        state.copyWith(
          homeState: ViewData.loading(),
        ),
      );
      final result = await apiService.getListRestaurant();

      if (result.restaurants.isEmpty) {
        emit(
          state.copyWith(
            homeState: ViewData.noData(message: Strings.noDataRestaurant),
          ),
        );
      } else {
        emit(
          state.copyWith(
            homeState: ViewData.loaded(data: result),
          ),
        );
      }
    } on SocketException catch (e) {
      debugPrint(e.toString());
      emit(
        state.copyWith(
          homeState: ViewData.error(message: Strings.errorNetwork),
        ),
      );
    } catch (e) {
      debugPrint(e.toString());
      emit(
        state.copyWith(
          homeState: ViewData.error(message: Strings.somethingSeemsWrong),
        ),
      );
    }
  }
}
