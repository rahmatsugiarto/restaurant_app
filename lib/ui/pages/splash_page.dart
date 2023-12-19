import 'package:flutter/material.dart';
import 'package:restaurant_app/common/res/assets.dart';
import 'package:restaurant_app/common/res/strings.dart';
import 'package:restaurant_app/ui/pages/main_bottom_bar_nav.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final durationDelayToHomePage = const Duration(milliseconds: 2000);

  @override
  void initState() {
    super.initState();
    Future.delayed(durationDelayToHomePage, () {
      Navigator.pushReplacementNamed(context, MainBottomBarNav.routeName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              Assets.restaurantLogo,
              height: 100,
              width: 100,
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              Strings.restaurantApp,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ],
        ),
      ),
    );
  }
}
