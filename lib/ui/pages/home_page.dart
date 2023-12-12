import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/common/res/assets.dart';
import 'package:restaurant_app/common/res/strings.dart';
import 'package:restaurant_app/common/utils/view_data_state.dart';
import 'package:restaurant_app/data/model/list_restaurant_response.dart';
import 'package:restaurant_app/ui/blocs/home_bloc/home_cubit.dart';
import 'package:restaurant_app/ui/blocs/home_bloc/home_state.dart';
import 'package:restaurant_app/ui/widgets/home_loading.dart';
import 'package:restaurant_app/ui/widgets/item_restaurant.dart';

import 'search_page.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home_page';

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().getListRestaurant();
  }

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
                      style:
                          Theme.of(context).textTheme.headlineMedium?.copyWith(
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
                  BlocBuilder<HomeCubit, HomeState>(
                    builder: (context, state) {
                      final status = state.homeState.status;

                      if (status.isLoading) {
                        return const HomeLoading();
                      } else if (status.isNoData || status.isError) {
                        return Column(
                          children: [
                            SizedBox(
                              height: MediaQuery.sizeOf(context).height / 4,
                            ),
                            Center(
                              child: Text(state.homeState.message),
                            ),
                          ],
                        );
                      } else if (status.isHasData) {
                        final restaurants =
                            state.homeState.data?.restaurants ?? <Restaurant>[];
                        return ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: restaurants.length,
                          itemBuilder: (context, index) {
                            return ItemRestaurant(
                              restaurant: restaurants[index],
                            );
                          },
                        );
                      } else {
                        return const SizedBox.shrink();
                      }
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
