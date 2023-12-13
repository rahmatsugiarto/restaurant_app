import 'package:flutter/material.dart';
import 'package:restaurant_app/common/res/styles.dart';


class CustomRefreshIndicator extends StatelessWidget {
  final Widget child;
  final bool noData;
  final Future<void> Function() onRefresh;

  const CustomRefreshIndicator({
    super.key,
    required this.child,
    required this.onRefresh,
    this.noData = false,
  });

  @override
  Widget build(BuildContext context) {
    if (noData) {
      return Stack(
        children: [
          child,
          RefreshIndicator(
            color: primaryColor,
            backgroundColor: secondaryColor,
            onRefresh: onRefresh,
            child: CustomScrollView(
              slivers: [
                SliverFillRemaining(child: Container()),
              ],
            ),
          ),
        ],
      );
    } else {
      return RefreshIndicator(
        color: primaryColor,
        backgroundColor: secondaryColor,
        onRefresh: onRefresh,
        child: child,
      );
    }
  }
}
