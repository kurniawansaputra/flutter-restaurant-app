import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/components/message_widget.dart';
import '../../../core/components/restaurant_card_widget.dart';
import '../../../core/components/search_widget.dart';
import '../../../core/components/shimmer_restaurant_card_widget.dart';
import '../../../core/components/title_restaurant_widget.dart';
import '../../../core/static/navigation_route.dart';
import '../../../core/static/restaurant_search_result_state.dart';
import '../../../providers/search/restaurant_search_provider.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<RestaurantSearchProvider>().searchRestaurant('');
    });

    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    final query = _searchController.text;

    if (query.isNotEmpty) {
      context.read<RestaurantSearchProvider>().searchRestaurant(query);
    }
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 24.0,
                left: 16.0,
                right: 16.0,
                bottom: 8.0,
              ),
              child: Search(
                controller: _searchController,
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 16.0,
                  ),
                  child: Consumer<RestaurantSearchProvider>(
                    builder: (context, value, child) {
                      final state = value.resultState;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AnimatedBuilder(
                            animation: _searchController,
                            builder: (context, child) {
                              final isSearching =
                                  _searchController.text.isNotEmpty;
                              return TitleRestaurant(
                                title: isSearching
                                    ? 'Results'
                                    : 'Recommended For You',
                              );
                            },
                          ),
                          const SizedBox(height: 12.0),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                            ),
                            child: _searchRestaurant(state),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _searchRestaurant(RestaurantSearchResultState state) {
    return switch (state) {
      RestaurantSearchLoadingState() => Column(
          children: List.generate(
            3,
            (index) => const ShimmerRestaurantCard(),
          ),
        ),
      RestaurantSearchLoadedState(
        data: var restaurantList,
      ) =>
        restaurantList.isNotEmpty
            ? ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: restaurantList.length,
                itemBuilder: (context, index) {
                  final restaurant = restaurantList[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
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
                  );
                },
              )
            : const Message(
                title: 'No restaurant found',
                subtitle: 'Please try another keyword',
              ),
      RestaurantSearchErrorState() => const Center(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Message(
              title: 'Oops, something went wrong!',
              subtitle: 'Please check your internet connection',
            ),
          ),
        ),
      _ => const SizedBox(),
    };
  }
}
