import 'package:flutter/material.dart';
import 'package:restaurant_app/common/assets.dart';
import 'package:restaurant_app/common/strings.dart';

import 'home_page.dart';

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
      Navigator.pushReplacementNamed(context, HomePage.routeName);
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
