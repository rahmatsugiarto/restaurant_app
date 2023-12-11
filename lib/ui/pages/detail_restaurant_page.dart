import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:getwidget/colors/gf_color.dart';
import 'package:getwidget/components/rating/gf_rating.dart';
import 'package:restaurant_app/common/assets.dart';
import 'package:restaurant_app/common/strings.dart';
import 'package:restaurant_app/model/restaurant_model.dart';

class DetailRestaurantPage extends StatefulWidget {
  static const routeName = '/restaurant_detail';
  final Restaurant restaurants;

  const DetailRestaurantPage({Key? key, required this.restaurants})
      : super(key: key);

  @override
  State<DetailRestaurantPage> createState() => _DetailRestaurantPageState();
}

class _DetailRestaurantPageState extends State<DetailRestaurantPage> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
    );

    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Hero(
                  tag: widget.restaurants.pictureId,
                  child: CachedNetworkImage(
                    imageUrl: widget.restaurants.pictureId,
                    imageBuilder: (_, imageProvider) {
                      return Container(
                        height: 400,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                    placeholder: (context, url) {
                      return Container(
                        height: 400,
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                        ),
                      );
                    },
                    errorWidget: (context, url, error) {
                      return Container(
                        height: 400,
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.error,
                            color: Colors.grey,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.fromLTRB(
                    16,
                    8,
                    0,
                    0,
                  ),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          widget.restaurants.name,
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Icon(
                                Icons.location_on_outlined,
                                color: Colors.grey,
                                size: 15,
                              ),
                              Text(
                                widget.restaurants.city,
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            ],
                          ),
                          Container(
                            margin: const EdgeInsets.only(right: 16),
                            child: Row(
                              children: [
                                GFRating(
                                  color: GFColors.WARNING,
                                  borderColor: GFColors.WARNING,
                                  filledIcon: const Icon(
                                    Icons.star,
                                    color: GFColors.WARNING,
                                    size: 20,
                                  ),
                                  size: 20,
                                  value: widget.restaurants.rating,
                                  onChanged: (double rating) {},
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  widget.restaurants.rating.toString(),
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Container(
                        margin: const EdgeInsets.only(right: 16),
                        child: Text(
                          widget.restaurants.description,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Container(
                        margin: const EdgeInsets.only(right: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              Strings.foods,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            Text(
                              Strings.seeAll,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                      _buildListFoods(),
                      const SizedBox(height: 12),
                      Container(
                        margin: const EdgeInsets.only(right: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              Strings.drinks,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            Text(
                              Strings.seeAll,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                      _buildListDrinks(),
                    ],
                  ),
                ),
              ],
            ),
          ),
          _buildPopAndFav(context, isFavorite),
        ],
      ),
    );
  }

  Container _buildListFoods() {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.restaurants.menus.foods.length,
        itemBuilder: (context, index) {
          Menu food = widget.restaurants.menus.foods[index];
          return SizedBox(
            width: 150,
            child: Column(
              children: [
                Container(
                  height: 150,
                  width: 150,
                  margin: const EdgeInsets.only(right: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: const DecorationImage(
                      image: AssetImage(Assets.foods),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  food.name,
                  style: Theme.of(context).textTheme.bodyLarge,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Container _buildListDrinks() {
    return Container(
      margin: const EdgeInsets.only(top: 12, bottom: 50),
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.restaurants.menus.drinks.length,
        itemBuilder: (context, index) {
          Menu menuDrinks = widget.restaurants.menus.drinks[index];
          return SizedBox(
            width: 150,
            child: Column(
              children: [
                Container(
                  height: 150,
                  width: 150,
                  margin: const EdgeInsets.only(right: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: const DecorationImage(
                      image: AssetImage(Assets.assets),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  menuDrinks.name,
                  style: Theme.of(context).textTheme.bodyLarge,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  SafeArea _buildPopAndFav(BuildContext context, bool isFav) {
    return SafeArea(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Card(
            margin: const EdgeInsets.only(left: 16),
            elevation: 5,
            color: Colors.white,
            surfaceTintColor: Colors.white,
            child: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          Card(
            margin: const EdgeInsets.only(right: 16),
            elevation: 5,
            color: Colors.white,
            surfaceTintColor: Colors.white,
            child: IconButton(
              icon: !isFav
                  ? const Icon(Icons.favorite_border)
                  : const Icon(
                      Icons.favorite,
                      color: Colors.red,
                    ),
              onPressed: () {
                setState(() {
                  isFavorite = !isFavorite;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
