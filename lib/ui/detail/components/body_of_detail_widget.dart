import 'package:flutter/material.dart';

import '../../../core/components/image_restaurant_widget.dart';
import '../../../core/components/rating_widget.dart';
import '../../../core/components/title_restaurant_widget.dart';
import '../../../core/constans/variables.dart';
import '../../../data/models/restaurant_detail_response.dart';
import 'category_restaurant_widget.dart';
import 'menu_chip_widget.dart';
import 'review_card_widget.dart';

class BodyOfDetailPage extends StatelessWidget {
  const BodyOfDetailPage({
    super.key,
    required this.restaurant,
  });

  final Restaurant restaurant;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ImageRestaurant(
              tag: restaurant.id,
              imageUrl: '${Variables.imageUrl}${restaurant.pictureId}',
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    restaurant.name,
                    style: const TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Rating(
                  rating: restaurant.rating,
                )
              ],
            ),
          ),
          const SizedBox(
            height: 8.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
            ),
            child: Text(
              "${restaurant.address}, ${restaurant.city}",
              style: TextStyle(
                fontSize: 12.0,
                color: Colors.grey[600],
              ),
            ),
          ),
          const SizedBox(
            height: 8.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
            ),
            child: CategoryRestaurant(
                categories: restaurant.categories
                    .map((category) => category.name)
                    .toList()),
          ),
          const SizedBox(
            height: 16.0,
          ),
          const TitleRestaurant(
            title: 'Description',
          ),
          const SizedBox(
            height: 8.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
            ),
            child: Text(
              restaurant.description,
              style: const TextStyle(
                fontSize: 12.0,
              ),
            ),
          ),
          const SizedBox(
            height: 24.0,
          ),
          const TitleRestaurant(
            title: 'Foods',
          ),
          const SizedBox(
            height: 8.0,
          ),
          MenuChip(
            items: restaurant.menus.foods
                .map(
                  (food) => food.name,
                )
                .toList(),
          ),
          const SizedBox(
            height: 24.0,
          ),
          const TitleRestaurant(
            title: 'Drinks',
          ),
          const SizedBox(
            height: 8.0,
          ),
          MenuChip(
            items: restaurant.menus.drinks
                .map(
                  (drink) => drink.name,
                )
                .toList(),
          ),
          const SizedBox(
            height: 24.0,
          ),
          const TitleRestaurant(
            title: 'Reviews',
          ),
          const SizedBox(
            height: 8.0,
          ),
          ReviewCard(
            customerReviews: restaurant.customerReviews,
          ),
          const SizedBox(
            height: 24.0,
          ),
        ],
      ),
    );
  }
}
