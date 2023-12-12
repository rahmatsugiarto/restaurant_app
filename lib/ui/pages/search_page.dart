import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/common/res/strings.dart';
import 'package:restaurant_app/common/res/styles.dart';
import 'package:restaurant_app/common/utils/debouncer.dart';
import 'package:restaurant_app/common/utils/view_data_state.dart';
import 'package:restaurant_app/ui/blocs/search_bloc/search_cubit.dart';
import 'package:restaurant_app/ui/blocs/search_bloc/search_state.dart';
import 'package:restaurant_app/ui/widgets/home_loading.dart';
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

  @override
  void initState() {
    super.initState();
    _search("");
  }

  @override
  void dispose() {
    controllerSearch.dispose();
    super.dispose();
  }

  void _search(String query) {
    context.read<SearchCubit>().searchRestaurant(query: query);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryColor,
      appBar: AppBar(
        elevation: 2,
        backgroundColor: Colors.grey[100],
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
                  color: primaryColor,
                ),
              ),
              Expanded(
                child: TextFormField(
                  controller: controllerSearch,
                  autofocus: true,
                  keyboardType: TextInputType.text,
                  style: Theme.of(context).textTheme.bodyMedium,
                  onChanged: (value) {
                    debouncer.run(() {
                      _search(value);
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
                      borderSide: BorderSide(
                        color: Colors.grey.shade100,
                        width: 1,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: Colors.grey.shade100,
                        width: 1,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: Colors.grey.shade100,
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
      body: BlocBuilder<SearchCubit, SearchState>(
        builder: (context, state) {
          final status = state.searchState.status;

          if (status.isLoading) {
            return Container(
              margin: const EdgeInsets.only(
                top: 20,
                right: 20,
                left: 20,
              ),
              child: const HomeLoading(),
            );
          } else if (status.isNoData || status.isError) {
            return Center(
              child: Text(
                state.searchState.message,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            );
          } else if (status.isHasData) {
            final resultSearch = state.searchState.data?.restaurants ?? [];

            return ListView.builder(
              itemCount: resultSearch.length,
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              itemBuilder: (context, index) {
                return ItemRestaurant(
                  restaurant: resultSearch[index],
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
