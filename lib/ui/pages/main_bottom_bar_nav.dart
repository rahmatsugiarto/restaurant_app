import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/common/res/styles.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/db/database_helper.dart';
import 'package:restaurant_app/ui/blocs/favorite_bloc/favorite_cubit.dart';
import 'package:restaurant_app/ui/blocs/home_bloc/home_cubit.dart';
import 'package:restaurant_app/ui/pages/favorites_page.dart';
import 'package:restaurant_app/ui/pages/home_page.dart';
import 'package:restaurant_app/ui/pages/setting_page.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class MainBottomBarNav extends StatefulWidget {
  static const routeName = '/main_bottom_nav_bar';
  const MainBottomBarNav({super.key});

  @override
  State<MainBottomBarNav> createState() => _MainBottomBarNavState();
}

class _MainBottomBarNavState extends State<MainBottomBarNav> {
  var currentIndex = 0;

  final listPage = [
    BlocProvider(
      create: (context) => HomeCubit(apiService: ApiService()),
      child: const HomePage(),
    ),
    BlocProvider(
      create: (context) => FavoriteCubit(db: DatabaseHelper()),
      child: const FavoritesPage(),
    ),
    const SettingPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: listPage[currentIndex],
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: currentIndex,
        onTap: (i) => setState(() => currentIndex = i),
        items: [
          SalomonBottomBarItem(
            icon: const Icon(Icons.home),
            title: Text(
              "Home",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            selectedColor: primaryColor,
          ),
          SalomonBottomBarItem(
            icon: const Icon(Icons.favorite_border),
            title: Text(
              "Favorite",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            selectedColor: Colors.pink,
          ),
          SalomonBottomBarItem(
            icon: const Icon(Icons.settings),
            title: Text(
              "Setting",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            selectedColor: primaryColor,
          ),
        ],
      ),
    );
  }
}
