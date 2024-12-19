import 'package:flutter/material.dart';

import '../../data/models/restaurant.dart';
import '../constans/variables.dart';
import 'image_restaurant_widget.dart';
import 'rating_widget.dart';

class RestaurantCard extends StatelessWidget {
  final Restaurant restaurant;
  final void Function(String) onTap;

  const RestaurantCard({
    super.key,
    required this.restaurant,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(restaurant.id),
      child: Card.filled(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Column(
          children: [
            ImageRestaurant(
              tag: restaurant.id,
              imageUrl: "${Variables.imageUrl}${restaurant.pictureId}",
            ),
            ListTile(
              title: Text(
                restaurant.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                restaurant.city,
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.grey[600],
                ),
              ),
              trailing: Rating(
                rating: restaurant.rating,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
