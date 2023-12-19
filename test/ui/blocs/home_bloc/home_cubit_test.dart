import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:restaurant_app/common/utils/view_data_state.dart';
import 'package:restaurant_app/data/remote/api_service.dart';
import 'package:restaurant_app/ui/blocs/home_bloc/home_cubit.dart';
import 'package:restaurant_app/ui/blocs/home_bloc/home_state.dart';

import '../../../data_dummy/model/data_dummy_model.dart';

class MockApiService extends Mock implements ApiService {}

void main() {
  late HomeCubit homeCubit;
  late HomeState homeState;
  late MockApiService mockApiService;

  setUp(() {
    mockApiService = MockApiService();
    homeCubit = HomeCubit(apiService: mockApiService);
    homeState = HomeState(homeState: ViewData.initial());
  });

  group("initial state", () {
    test('should have the default value in the init state', () {
      expect(
        homeCubit.state,
        homeState,
      );
    });
  });

  group("get list restaurant", () {
    blocTest<HomeCubit, HomeState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(() => mockApiService.getListRestaurant()).thenAnswer(
          (_) async => DataDummyModel.tListRestaurantResponse,
        );
        return homeCubit;
      },
      act: (cubit) => cubit.getListRestaurant(),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        homeState.copyWith(homeState: ViewData.loading()),
        homeState.copyWith(
          homeState:
              ViewData.loaded(data: DataDummyModel.tListRestaurantResponse),
        )
      ],
      verify: (bloc) {
        verify(() => mockApiService.getListRestaurant());
      },
    );

    blocTest<HomeCubit, HomeState>(
      'Should emit [Loading, Error] when get list restaurant is unsuccessful',
      build: () {
        when(() => mockApiService.getListRestaurant()).thenAnswer(
          (_) async => throw Exception('Something seems wrong'),
        );
        return homeCubit;
      },
      act: (cubit) => cubit.getListRestaurant(),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        homeState.copyWith(homeState: ViewData.loading()),
        homeState.copyWith(
          homeState: ViewData.error(message: "Something seems wrong"),
        )
      ],
      verify: (bloc) {
        verify(() => mockApiService.getListRestaurant());
      },
    );
  });
}
