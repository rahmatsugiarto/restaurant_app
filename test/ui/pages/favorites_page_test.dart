import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:restaurant_app/common/utils/view_data_state.dart';
import 'package:restaurant_app/ui/blocs/favorite_bloc/favorite_cubit.dart';
import 'package:restaurant_app/ui/blocs/favorite_bloc/favorite_state.dart';
import 'package:restaurant_app/ui/pages/favorites_page.dart';
import 'package:restaurant_app/ui/widgets/home_loading.dart';

import '../../data_dummy/model/data_dummy_model.dart';

class MockFavoriteCubit extends MockCubit<FavoriteState>
    implements FavoriteCubit {}

class FakeFavoriteState extends Fake implements FavoriteState {}

void main() {
  late MockFavoriteCubit mockFavoriteCubit;
  late FavoriteState favoriteState;

  setUp(() {
    registerFallbackValue(FakeFavoriteState());
    mockFavoriteCubit = MockFavoriteCubit();

    favoriteState = FavoriteState(
      favState: ViewData.initial(),
    );
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<FavoriteCubit>.value(
      value: mockFavoriteCubit,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockFavoriteCubit.state).thenReturn(
      favoriteState.copyWith(
        favState: ViewData.loading(),
      ),
    );
    final listLoadingFinder = find.byType(ListLoading);

    await tester.pumpWidget(makeTestableWidget(const FavoritesPage()));

    expect(listLoadingFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => mockFavoriteCubit.state).thenReturn(
      favoriteState.copyWith(
        favState: ViewData.loaded(data: DataDummyModel.tListRestaurant),
      ),
    );

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(makeTestableWidget(const FavoritesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockFavoriteCubit.state).thenReturn(
      favoriteState.copyWith(
        favState: ViewData.error(message: 'Error message'),
      ),
    );

    final textFinder = find.byKey(const Key('error_message'));
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(makeTestableWidget(const FavoritesPage()));

    expect(centerFinder, findsOneWidget);
    expect(textFinder, findsOneWidget);
  });
}
