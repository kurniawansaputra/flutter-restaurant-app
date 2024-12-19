import 'package:flutter/material.dart';

class CategoryRestaurant extends StatelessWidget {
  final List<String> categories;

  const CategoryRestaurant({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    String categoryString = categories.join(' | ');
    return Text(
      categoryString,
      style: TextStyle(
        color: Colors.grey[600],
        fontSize: 12.0,
      ),
    );
  }
}
