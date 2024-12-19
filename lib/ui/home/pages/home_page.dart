import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/components/message_widget.dart';
import '../../../core/components/restaurant_card_widget.dart';
import '../../../core/components/search_widget.dart';
import '../../../core/components/shimmer_restaurant_card_widget.dart';
import '../../../core/components/title_restaurant_widget.dart';
import '../../../core/static/navigation_route.dart';
import '../../../core/static/restaurant_list_result_state.dart';
import '../../../providers/home/restaurant_list_provider.dart';
import '../../../providers/main/index_nav_provider.dart';
import '../components/carousal_banner_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FocusNode _searchFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<RestaurantListProvider>().fetchRestaurantList();
    });

    _searchFocusNode.addListener(() {
      if (_searchFocusNode.hasFocus) {
        context.read<IndexNavProvider>().indexBottomNavBar = 1;
        _searchFocusNode.unfocus();
      }
    });
  }

  @override
  void dispose() {
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
            ),
            child: Image.asset(
              'assets/images/avatar.png',
              width: 36.0,
            ),
          ),
        ],
      ),
      body: Consumer<RestaurantListProvider>(
        builder: (context, value, child) {
          return SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 16.0,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'What are you going\nto eat today?',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 24.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                    ),
                    child: Search(
                      focusNode: _searchFocusNode,
                    ),
                  ),
                  const SizedBox(
                    height: 24.0,
                  ),
                  const CarousalBanner(),
                  const SizedBox(
                    height: 16.0,
                  ),
                  const TitleRestaurant(
                    title: 'Popular Restaurants',
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      right: 16.0,
                      left: 16.0,
                      top: 12.0,
                    ),
                    child: _getRestaurant(value, context),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  RenderObjectWidget _getRestaurant(
      RestaurantListProvider value, BuildContext context) {
    return switch (value.resultState) {
      RestaurantListLoadingState() => Column(
          children: List.generate(
            3,
            (index) => const ShimmerRestaurantCard(),
          ),
        ),
      RestaurantListLoadedState(data: var restaurantList) =>
        restaurantList.isNotEmpty
            ? Column(
                children: restaurantList
                    .map(
                      (restaurant) => Container(
                        margin: const EdgeInsets.symmetric(
                          vertical: 4.0,
                        ),
                        child: RestaurantCard(
                          restaurant: restaurant,
                          onTap: (id) {
                            Navigator.pushNamed(
                              context,
                              NavigationRoute.detailRoute.name,
                              arguments: restaurant.id,
                            );
                          },
                        ),
                      ),
                    )
                    .toList(),
              )
            : const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.0,
                ),
                child: Text(
                  'No restaurants found. Please check back later!',
                  textAlign: TextAlign.center,
                ),
              ),
      RestaurantListErrorState(error: var message) => Padding(
          padding: EdgeInsets.all(16.0),
          child: Message(
            title: 'Oops, something went wrong!',
            subtitle: message,
          ),
        ),
      _ => const SizedBox(),
    };
  }
}
