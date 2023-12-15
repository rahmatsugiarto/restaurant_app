import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:restaurant_app/common/utils/view_data_state.dart';
import 'package:restaurant_app/ui/blocs/search_bloc/search_cubit.dart';
import 'package:restaurant_app/ui/blocs/search_bloc/search_state.dart';
import 'package:restaurant_app/ui/pages/search_page.dart';
import 'package:restaurant_app/ui/widgets/home_loading.dart';

import '../../data_dummy/model/data_dummy_model.dart';

class MockSearchCubit extends MockCubit<SearchState> implements SearchCubit {}

class FakeSearchState extends Fake implements SearchState {}

void main() {
  late MockSearchCubit mockSearchCubit;
  late SearchState searchState;

  setUp(() {
    registerFallbackValue(FakeSearchState());
    mockSearchCubit = MockSearchCubit();

    searchState = SearchState(
      searchState: ViewData.initial(),
    );
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<SearchCubit>.value(
      value: mockSearchCubit,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display HomeLoading when loading',
      (WidgetTester tester) async {
    when(() => mockSearchCubit.state).thenReturn(
      searchState.copyWith(
        searchState: ViewData.loading(),
      ),
    );

    final listLoadingFinder = find.byType(ListLoading);

    await tester.pumpWidget(makeTestableWidget(const SearchPage()));

    expect(listLoadingFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => mockSearchCubit.state).thenReturn(
      searchState.copyWith(
        searchState: ViewData.loaded(
          data: DataDummyModel.tSearchRestaurantResponse,
        ),
      ),
    );

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(makeTestableWidget(const SearchPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockSearchCubit.state).thenReturn(
      searchState.copyWith(
        searchState: ViewData.error(message: 'Error message'),
      ),
    );

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(makeTestableWidget(const SearchPage()));

    expect(textFinder, findsOneWidget);
  });
}
