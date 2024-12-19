import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerRestaurantDetail extends StatelessWidget {
  const ShimmerRestaurantDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 8.0,
      ),
      child: Shimmer.fromColors(
        baseColor:
            Theme.of(context).colorScheme.secondaryFixedDim.withOpacity(0.3),
        highlightColor:
            Theme.of(context).colorScheme.secondaryFixedDim.withOpacity(0.6),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(16.0),
              ),
              width: double.infinity,
              height: 160.0,
            ),
            const SizedBox(
              height: 16.0,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(16.0),
              ),
              width: double.infinity,
              height: 42.0,
            ),
            const SizedBox(
              height: 8.0,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(16.0),
              ),
              width: double.infinity,
              height: 24.0,
            ),
          ],
        ),
      ),
    );
  }
}
