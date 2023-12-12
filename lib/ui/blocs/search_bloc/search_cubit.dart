import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/common/res/strings.dart';
import 'package:restaurant_app/common/utils/view_data_state.dart';
import 'package:restaurant_app/data/api/api_service.dart';

import 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final ApiService apiService;

  SearchCubit({required this.apiService})
      : super(SearchState(searchState: ViewData.initial()));

  void searchRestaurant({required String query}) async {
    try {
      emit(
        state.copyWith(
          searchState: ViewData.loading(),
        ),
      );
      final result = await apiService.searchRestaurant(query: query);

      if (result.restaurants.isEmpty) {
        emit(
          state.copyWith(
            searchState: ViewData.noData(message: Strings.notFound),
          ),
        );
      } else {
        emit(
          state.copyWith(
            searchState: ViewData.loaded(data: result),
          ),
        );
      }
    } on SocketException catch (e) {
      debugPrint(e.toString());
      emit(
        state.copyWith(
          searchState: ViewData.error(message: Strings.errorNetwork),
        ),
      );
    } catch (e) {
      debugPrint(e.toString());
      emit(
        state.copyWith(
          searchState: ViewData.error(message: Strings.somethingSeemsWrong),
        ),
      );
    }
  }
}
