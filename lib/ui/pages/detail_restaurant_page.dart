import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:getwidget/colors/gf_color.dart';
import 'package:getwidget/components/rating/gf_rating.dart';
import 'package:restaurant_app/common/constant/app_constant.dart';
import 'package:restaurant_app/common/res/assets.dart';
import 'package:restaurant_app/common/res/strings.dart';
import 'package:restaurant_app/common/res/styles.dart';
import 'package:restaurant_app/common/utils/extention.dart';
import 'package:restaurant_app/common/utils/view_data_state.dart';
import 'package:restaurant_app/data/model/detail_restaurant_response.dart';
import 'package:restaurant_app/data/model/list_restaurant_response.dart';
import 'package:restaurant_app/ui/blocs/detail_restaurant_bloc/detail_restaurant_cubit.dart';
import 'package:restaurant_app/ui/blocs/detail_restaurant_bloc/detail_restaurant_state.dart';
import 'package:restaurant_app/ui/widgets/bottom_sheet_add_review.dart';
import 'package:restaurant_app/ui/widgets/custom_refresh_indicator.dart';
import 'package:restaurant_app/ui/widgets/detail_restaurant_loading.dart';
import 'package:restaurant_app/ui/widgets/skeleton.dart';

class DetailRestaurantPage extends StatefulWidget {
  static const routeName = '/restaurant_detail';
  final Restaurant restaurant;

  const DetailRestaurantPage({Key? key, required this.restaurant})
      : super(key: key);

  @override
  State<DetailRestaurantPage> createState() => _DetailRestaurantPageState();
}

class _DetailRestaurantPageState extends State<DetailRestaurantPage> {
  final TextEditingController _controllerAddReview = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Future.microtask(() {
    isBookmarked();

    _getDetailRestaurant();

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
    );
    // });
  }

  @override
  void dispose() {
    _controllerAddReview.dispose();
    super.dispose();
  }

  void _getDetailRestaurant() {
    context
        .read<DetailRestaurantCubit>()
        .getDetailRestaurant(id: widget.restaurant.id);
  }

  void _addReview({required String review}) {
    context.read<DetailRestaurantCubit>().addReview(
          idRestaurant: widget.restaurant.id,
          review: review,
        );
  }

  void isBookmarked() {
    context.read<DetailRestaurantCubit>().checkFavorited(widget.restaurant.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        child: const Icon(
          Icons.comment,
          color: secondaryColor,
        ),
        onPressed: () {
          BottomSheetAddReview.show(
            context: context,
            textController: _controllerAddReview,
            onSendReview: () {
              _addReview(review: _controllerAddReview.text.trim());
            },
          );
        },
      ),
      body: Stack(
        children: [
          CustomRefreshIndicator(
            onRefresh: () async {
              _getDetailRestaurant();
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  Hero(
                    tag: widget.restaurant.pictureId,
                    child: CachedNetworkImage(
                      imageUrl:
                          AppConstant.imageUrl + widget.restaurant.pictureId,
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
                            widget.restaurant.name,
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(top: 2),
                                    child: Icon(
                                      Icons.location_on_outlined,
                                      color: Colors.grey,
                                      size: 15,
                                    ),
                                  ),
                                  Expanded(
                                    child: BlocBuilder<DetailRestaurantCubit,
                                        DetailRestaurantState>(
                                      builder: (context, state) {
                                        final status = state.detailState.status;

                                        if (status.isLoading) {
                                          return const Skeleton(
                                            height: 14,
                                            width: 100,
                                          );
                                        } else if (status.isHasData) {
                                          final address = state.detailState.data
                                              ?.restaurant.address;
                                          return Text(
                                            "$address, ${widget.restaurant.city}",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium,
                                          );
                                        } else {
                                          return Text(
                                            widget.restaurant.city,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium,
                                          );
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 10.0,
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
                                    value: widget.restaurant.rating,
                                    onChanged: (double rating) {},
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    widget.restaurant.rating.toString(),
                                    style:
                                        Theme.of(context).textTheme.titleSmall,
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
                            widget.restaurant.description,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                        const SizedBox(height: 24),
                        BlocConsumer<DetailRestaurantCubit,
                            DetailRestaurantState>(
                          listener: (context, state) {
                            final statusAddReview = state.addReviewState.status;
                            final statusDetail = state.detailState.status;

                            if (statusDetail.isError) {
                              var snackBar = SnackBar(
                                content: Text(state.detailState.message),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                              EasyLoading.dismiss();
                            }

                            if (statusAddReview.isLoading) {
                              EasyLoading.show(
                                status: Strings.loading,
                                maskType: EasyLoadingMaskType.black,
                              );
                            }

                            if (statusAddReview.isError) {
                              var snackBar = SnackBar(
                                content: Text(state.addReviewState.message),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                              EasyLoading.dismiss();
                            }

                            if (statusAddReview.isHasData) {
                              EasyLoading.dismiss();
                            }
                          },
                          builder: (context, state) {
                            final status = state.detailState.status;
                            if (status.isLoading) {
                              return const DetailRestaurantLoading();
                            } else if (status.isHasData) {
                              final data = state.detailState.data;
                              final category = data?.restaurant.categories
                                  .joinCategoryNames();
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildCategory(context, category),
                                  const SizedBox(height: 12.0),
                                  _buildListFoods(data?.restaurant),
                                  const SizedBox(height: 12),
                                  _buildListDrinks(data?.restaurant),
                                  const SizedBox(
                                    height: 12.0,
                                  ),
                                  _buildReviews(data, state.listRandomPict),
                                  const SizedBox(
                                    height: 50.0,
                                  ),
                                ],
                              );
                            } else {
                              return const SizedBox.shrink();
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          _buildPopAndFav(context),
        ],
      ),
    );
  }

  Widget _buildReviews(
      DetailRestaurantResponse? data, List<String> listRandomPict) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          Strings.reviews,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: data?.restaurant.customerReviews.length,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(vertical: 12),
          itemBuilder: (context, index) {
            final review = data?.restaurant.customerReviews[index];
            final randomPict = listRandomPict[index];
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 45,
                        height: 45,
                        child: CircleAvatar(
                          backgroundImage: AssetImage(
                            randomPict,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 8.0,
                      ),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              review?.name ?? "",
                              style: Theme.of(context).textTheme.bodySmall,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              review?.date ?? "",
                              style: Theme.of(context).textTheme.bodySmall,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    review?.review ?? "",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildCategory(BuildContext context, String? category) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          Strings.category,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        Expanded(
          child: Text(
            category ?? "",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }

  Widget _buildListFoods(RestaurantDetail? data) {
    return Column(
      children: [
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
        Container(
          margin: const EdgeInsets.only(top: 12),
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: data?.menus.foods.length,
            itemBuilder: (context, index) {
              final food = data?.menus.foods[index];
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
                      food?.name ?? "",
                      style: Theme.of(context).textTheme.bodyMedium,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildListDrinks(RestaurantDetail? data) {
    return Column(
      children: [
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
        Container(
          height: 200,
          margin: const EdgeInsets.only(top: 12),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: data?.menus.drinks.length,
            itemBuilder: (context, index) {
              final menuDrinks = data?.menus.drinks[index];
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
                          image: AssetImage(Assets.drink),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      menuDrinks?.name ?? "",
                      style: Theme.of(context).textTheme.bodyMedium,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildPopAndFav(BuildContext context) {
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
          BlocBuilder<DetailRestaurantCubit, DetailRestaurantState>(
            builder: (context, state) {
              final isFav = state.isFav;

              return Card(
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
                    context
                        .read<DetailRestaurantCubit>()
                        .saveFavorite(widget.restaurant);
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
