import 'package:flutter/material.dart';
import 'package:restaurant_app/common/assets.dart';
import 'package:restaurant_app/common/debouncer.dart';
import 'package:restaurant_app/common/strings.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/model/restaurant_model.dart';
import 'package:restaurant_app/ui/widgets/item_restaurant.dart';

class SearchPage extends StatefulWidget {
  static const routeName = '/search_page';

  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController controllerSearch = TextEditingController();

  final debouncer = Debouncer(milliseconds: 500);
  List<Restaurant> listRestaurant = [];
  List<Restaurant> listRestaurantSearch = [];

  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      final loadRestaurants = await DefaultAssetBundle.of(context).loadString(
        Assets.localRestaurantJson,
      );
      setState(() {
        listRestaurant = restaurantModelFromJson(loadRestaurants).restaurants;
        listRestaurantSearch = listRestaurant;
      });
    });
  }

  @override
  void dispose() {
    controllerSearch.dispose();
    super.dispose();
  }

  void search(String query) {
    setState(() {
      listRestaurantSearch = listRestaurant
          .where(
            (map) => map.name.toLowerCase().contains(
                  query.toLowerCase(),
                ),
          )
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryColor,
      appBar: AppBar(
        elevation: 2,
        backgroundColor: primaryColor,
        automaticallyImplyLeading: false,
        flexibleSpace: SafeArea(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: secondaryColor,
                ),
              ),
              Expanded(
                child: TextFormField(
                  controller: controllerSearch,
                  autofocus: true,
                  keyboardType: TextInputType.text,
                  onChanged: (value) {
                    debouncer.run(() {
                      search(value);
                    });
                  },
                  onTapOutside: (_) {
                    FocusScope.of(context).unfocus();
                  },
                  decoration: InputDecoration(
                    fillColor: Colors.grey[50],
                    filled: true,
                    hintStyle: Theme.of(context).textTheme.bodyLarge,
                    hintText: Strings.searchRestaurant,
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 12.0,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                        width: 1,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                        width: 1,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                        width: 1,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 20.0,
              ),
            ],
          ),
        ),
      ),
      body: Builder(builder: (context) {
        if (listRestaurantSearch.isNotEmpty) {
          return ListView.builder(
            itemCount: listRestaurantSearch.length,
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            itemBuilder: (context, index) {
              return ItemRestaurant(
                restaurant: listRestaurantSearch[index],
              );
            },
          );
        } else {
          return Center(
            child: Text(
              Strings.notFound,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          );
        }
      }),
    );
  }
}
