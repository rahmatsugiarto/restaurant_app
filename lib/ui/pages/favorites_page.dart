import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/common/utils/view_data_state.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/ui/blocs/favorite_bloc/favorite_cubit.dart';
import 'package:restaurant_app/ui/blocs/favorite_bloc/favorite_state.dart';
import 'package:restaurant_app/ui/pages/detail_restaurant_page.dart';
import 'package:restaurant_app/ui/widgets/home_loading.dart';
import 'package:restaurant_app/ui/widgets/item_restaurant.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  void initState() {
    super.initState();
    _getFavorites();
  }

  void _getFavorites() {
    context.read<FavoriteCubit>().getFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          "Favorites",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: BlocBuilder<FavoriteCubit, FavoriteState>(
        builder: (context, state) {
          final status = state.favState.status;

          if (status.isLoading) {
            return Container(
              margin: const EdgeInsets.only(
                top: 20,
                right: 20,
                left: 20,
              ),
              child: const ListLoading(),
            );
          } else if (status.isNoData || status.isError) {
            return Center(
              child: Text(
                key: const Key('error_message'),
                state.favState.message,
              ),
            );
          } else if (status.isHasData) {
            final restaurants = state.favState.data ?? <Restaurant>[];
            return ListView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.all(16),
              physics: const NeverScrollableScrollPhysics(),
              itemCount: restaurants.length,
              itemBuilder: (context, index) {
                return ItemRestaurant(
                  restaurant: restaurants[index],
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed(
                          DetailRestaurantPage.routeName,
                          arguments: restaurants[index],
                        )
                        .then((_) => _getFavorites());
                  },
                );
              },
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
