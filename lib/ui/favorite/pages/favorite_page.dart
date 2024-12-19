import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/components/message_widget.dart';
import '../../../core/components/restaurant_card_widget.dart';
import '../../../core/static/navigation_route.dart';
import '../../../providers/favorite/local_database_provider.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<LocalDatabaseProvider>().loadAllRestaurantValue();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite'),
      ),
      body: Consumer<LocalDatabaseProvider>(
        builder: (context, value, child) {
          final restaurantList = value.restaurantList ?? [];

          if (restaurantList.isEmpty) {
            return const Center(
              child: Message(
                imagePath: 'assets/images/empty_box.png',
                title: 'No favorite restaurant',
                subtitle: 'You don\'t have any favorite restaurant yet',
              ),
            );
          }

          return ListView.builder(
            itemCount: restaurantList.length,
            itemBuilder: (context, index) {
              final restaurant = restaurantList[index];

              final topMargin = index == 0 ? 16.0 : 4.0;
              final bottomMargin =
                  index == restaurantList.length - 1 ? 20.0 : 4.0;

              return Padding(
                padding: EdgeInsets.only(
                  top: topMargin,
                  left: 16.0,
                  right: 16.0,
                  bottom: bottomMargin,
                ),
                child: RestaurantCard(
                  restaurant: restaurant,
                  onTap: (restaurantId) {
                    Navigator.pushNamed(
                      context,
                      NavigationRoute.detailRoute.name,
                      arguments: restaurantId,
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
