import 'package:flutter/material.dart';
import 'package:restaurant_app/common/assets.dart';
import 'package:restaurant_app/common/strings.dart';
import 'package:restaurant_app/model/restaurant_model.dart';
import 'package:restaurant_app/ui/widgets/item_restaurant.dart';

import 'search_page.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/home_page';

  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 40,
              ),
              ListTile(
                leading: const CircleAvatar(
                  backgroundImage: AssetImage(
                    Assets.avatar,
                  ),
                ),
                title: Text(
                  Strings.hiRahmat,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                trailing: const Icon(
                  Icons.notifications_none_outlined,
                  color: Colors.black,
                ),
              ),
              Container(
                margin: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        Strings.findTheBestRated,
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(
                              color: Colors.grey[700],
                            ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        right: 4,
                        left: 4,
                        top: 16,
                      ),
                      child: Card(
                        elevation: 5,
                        color: Colors.white,
                        surfaceTintColor: Colors.white,
                        child: ListTile(
                          leading: const Icon(
                            Icons.search,
                            color: Colors.grey,
                          ),
                          title: const Text(
                            Strings.searchRestaurant,
                            style: TextStyle(color: Colors.grey),
                          ),
                          onTap: () {
                            Navigator.pushNamed(context, SearchPage.routeName);
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        Strings.recommended,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ),
                    const SizedBox(height: 12),
                    FutureBuilder<String>(
                      /// Memakai Future.delayed untuk memperlihatkan efek loading saja.
                      future: Future.delayed(
                        const Duration(seconds: 1),
                        () {
                          return DefaultAssetBundle.of(context).loadString(
                            Assets.localRestaurantJson,
                          );
                        },
                      ),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState != ConnectionState.done) {
                          return Column(
                            children: [
                              SizedBox(
                                height: MediaQuery.sizeOf(context).height / 4,
                              ),
                              const Center(
                                child: CircularProgressIndicator(),
                              ),
                            ],
                          );
                        } else {
                          if (snapshot.hasData) {
                            final RestaurantModel restaurantModel =
                                restaurantModelFromJson(
                              snapshot.data.toString(),
                            );
                            return ListView.builder(
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: restaurantModel.restaurants.length,
                              itemBuilder: (context, index) {
                                return ItemRestaurant(
                                  restaurant:
                                      restaurantModel.restaurants[index],
                                );
                              },
                            );
                          } else if (snapshot.hasError) {
                            return Column(
                              children: [
                                SizedBox(
                                  height: MediaQuery.sizeOf(context).height / 4,
                                ),
                                Center(
                                  child: Text(snapshot.error.toString()),
                                ),
                              ],
                            );
                          } else {
                            return Column(
                              children: [
                                SizedBox(
                                  height: MediaQuery.sizeOf(context).height / 4,
                                ),
                                const Center(
                                  child: CircularProgressIndicator(),
                                ),
                              ],
                            );
                          }
                        }
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
