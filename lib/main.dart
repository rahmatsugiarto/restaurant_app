import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/common/res/strings.dart';
import 'package:restaurant_app/common/res/styles.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/ui/blocs/detail_restaurant_bloc/detail_restaurant_cubit.dart';
import 'package:restaurant_app/ui/blocs/home_bloc/home_cubit.dart';
import 'package:restaurant_app/ui/pages/detail_restaurant_page.dart';
import 'package:restaurant_app/ui/pages/home_page.dart';
import 'package:restaurant_app/ui/pages/search_page.dart';
import 'package:restaurant_app/ui/pages/splash_page.dart';

import 'data/model/list_restaurant_response.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Strings.restaurantApp,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          elevation: 0,
        ),
        textTheme: myTextTheme,
        colorScheme: Theme.of(context).colorScheme.copyWith(
              primary: primaryColor,
              onPrimary: Colors.black,
              secondary: secondaryColor,
            ),
      ),
      home: const SplashPage(),
      routes: {
        HomePage.routeName: (context) => BlocProvider(
              create: (context) => HomeCubit(
                apiService: ApiService(),
              ),
              child: const HomePage(),
            ),
        SearchPage.routeName: (context) => const SearchPage(),
        DetailRestaurantPage.routeName: (context) => BlocProvider(
              create: (context) =>
                  DetailRestaurantCubit(apiService: ApiService()),
              child: DetailRestaurantPage(
                restaurant:
                    ModalRoute.of(context)?.settings.arguments as Restaurant,
              ),
            ),
      },
    );
  }
}
