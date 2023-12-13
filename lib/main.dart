import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:restaurant_app/common/res/strings.dart';
import 'package:restaurant_app/common/res/styles.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/db/database_helper.dart';
import 'package:restaurant_app/ui/blocs/detail_restaurant_bloc/detail_restaurant_cubit.dart';
import 'package:restaurant_app/ui/blocs/search_bloc/search_cubit.dart';
import 'package:restaurant_app/ui/pages/detail_restaurant_page.dart';
import 'package:restaurant_app/ui/pages/main_bottom_bar_nav.dart';
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
          color: secondaryColor,
        ),
        scaffoldBackgroundColor: secondaryColor,
        textTheme: myTextTheme,
        colorScheme: Theme.of(context).colorScheme.copyWith(
              primary: primaryColor,
              onPrimary: Colors.black,
              secondary: secondaryColor,
            ),
      ),
      builder: EasyLoading.init(),
      home: const SplashPage(),
      routes: {
        MainBottomBarNav.routeName: (context) => const MainBottomBarNav(),
        SearchPage.routeName: (context) => BlocProvider(
              create: (context) => SearchCubit(apiService: ApiService()),
              child: const SearchPage(),
            ),
        DetailRestaurantPage.routeName: (context) => BlocProvider(
              create: (context) => DetailRestaurantCubit(
                apiService: ApiService(),
                db: DatabaseHelper(),
              ),
              child: DetailRestaurantPage(
                restaurant:
                    ModalRoute.of(context)?.settings.arguments as Restaurant,
              ),
            ),
      },
    );
  }
}
