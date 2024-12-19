import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/components/message_widget.dart';
import '../../../core/static/restaurant_detail_result_state.dart';
import '../../../providers/detail/favorite_icon_provider.dart';
import '../../../providers/detail/restaurant_detail_provider.dart';
import '../components/body_of_detail_widget.dart';
import '../components/favorite_icon_widget.dart';
import '../components/shimmer_detail_widget.dart';
import '/data/models/restaurant.dart';

class DetailPage extends StatefulWidget {
  final String restaurantId;

  const DetailPage({super.key, required this.restaurantId});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context
          .read<RestaurantDetailProvider>()
          .fetchRestaurantDetail(widget.restaurantId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          ChangeNotifierProvider(
            create: (context) => FavoriteIconProvider(),
            child: Consumer<RestaurantDetailProvider>(
              builder: (context, value, child) {
                return switch (value.resultState) {
                  RestaurantDetailLoadedState(data: var restaurant) =>
                    FavoriteIcon(
                      restaurant: Restaurant(
                        id: restaurant.id,
                        name: restaurant.name,
                        description: restaurant.description,
                        pictureId: restaurant.pictureId,
                        city: restaurant.city,
                        rating: restaurant.rating,
                      ),
                    ),
                  _ => const SizedBox(),
                };
              },
            ),
          ),
        ],
      ),
      body: Consumer<RestaurantDetailProvider>(
        builder: (context, value, child) {
          return switch (value.resultState) {
            RestaurantDetailLoadingState() => const ShimmerRestaurantDetail(),
            RestaurantDetailLoadedState(data: var restaurant) =>
              BodyOfDetailPage(restaurant: restaurant),
            RestaurantDetailErrorState() => const Message(
                title: 'Oops, something went wrong!',
                subtitle: 'Please check your internet connection',
              ),
            _ => const SizedBox(),
          };
        },
      ),
    );
  }
}
