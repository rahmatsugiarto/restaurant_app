import 'package:flutter/material.dart';
import 'package:restaurant_app/ui/widgets/skeleton.dart';

class DetailRestaurantLoading extends StatelessWidget {
  const DetailRestaurantLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Skeleton(
              height: 20,
              width: 60,
            ),
            Skeleton(
              height: 14,
              width: 60,
            ),
          ],
        ),
        Container(
          margin: const EdgeInsets.only(top: 12),
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 3,
            itemBuilder: (context, index) {
              return const Column(
                children: [
                  Skeleton(
                    height: 150,
                    width: 150,
                    margin: EdgeInsets.only(right: 8),
                  ),
                  SizedBox(height: 8),
                  Skeleton(
                    height: 14,
                    width: 100,
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
