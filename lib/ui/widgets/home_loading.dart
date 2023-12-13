import 'package:flutter/material.dart';
import 'package:restaurant_app/ui/widgets/skeleton.dart';

class HomeLoading extends StatelessWidget {
  const HomeLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 4,
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          child: const Row(
            children: [
              Skeleton(
                width: 100,
                height: 100,
              ),
              SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Skeleton(
                    height: 20,
                    width: 50,
                  ),
                  SizedBox(
                    height: 12.0,
                  ),
                  Skeleton(
                    height: 14,
                    width: 50,
                  ),
                  SizedBox(
                    height: 12.0,
                  ),
                  Skeleton(
                    height: 14,
                    width: 100,
                  ),
                ],
              ),
              Spacer(),
              Skeleton(
                height: 20,
                width: 50,
              ),
            ],
          ),
        );
      },
    );
  }
}
