import 'package:flutter/material.dart';

class ImageRestaurant extends StatelessWidget {
  final String tag;
  final String imageUrl;

  const ImageRestaurant({
    super.key,
    required this.tag,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: tag,
      child: ClipRRect(
        borderRadius: const BorderRadius.all(
          Radius.circular(16.0),
        ),
        child: Image.network(
          imageUrl,
          width: double.infinity,
          height: 160.0,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
