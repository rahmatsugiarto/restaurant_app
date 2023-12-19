import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:restaurant_app/common/utils/view_data_state.dart';
import 'package:restaurant_app/ui/blocs/home_bloc/home_cubit.dart';
import 'package:restaurant_app/ui/blocs/home_bloc/home_state.dart';
import 'package:restaurant_app/ui/pages/home_page.dart';
import 'package:restaurant_app/ui/widgets/home_loading.dart';

import '../../data_dummy/model/data_dummy_model.dart';

class MockHomeCubit extends MockCubit<HomeState> implements HomeCubit {}

class FakeHomeState extends Fake implements HomeState {}

void main() {
  late MockHomeCubit mockHomeCubit;
  late HomeState homeState;

  setUp(() {
    registerFallbackValue(FakeHomeState());
    mockHomeCubit = MockHomeCubit();

    homeState = HomeState(
      homeState: ViewData.initial(),
    );
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<HomeCubit>.value(
      value: mockHomeCubit,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display HomeLoading when loading',
      (WidgetTester tester) async {
    when(() => mockHomeCubit.state).thenReturn(
      homeState.copyWith(
        homeState: ViewData.loading(),
      ),
    );

    final listLoadingFinder = find.byType(ListLoading);

    await tester.pumpWidget(makeTestableWidget(const HomePage()));

    expect(listLoadingFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => mockHomeCubit.state).thenReturn(
      homeState.copyWith(
        homeState:
            ViewData.loaded(data: DataDummyModel.tListRestaurantResponse),
      ),
    );

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(makeTestableWidget(const HomePage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockHomeCubit.state).thenReturn(
      homeState.copyWith(
        homeState: ViewData.error(message: 'Error message'),
      ),
    );

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(makeTestableWidget(const HomePage()));

    expect(textFinder, findsOneWidget);
  });
}
