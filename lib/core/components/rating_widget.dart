import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Rating extends StatelessWidget {
  final double rating;

  const Rating({
    super.key,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(
          'assets/icons/ic_star.svg',
          colorFilter: const ColorFilter.mode(
            Colors.amber,
            BlendMode.srcIn,
          ),
          width: 16.0,
          height: 16.0,
        ),
        const SizedBox(width: 4.0),
        Text(
          rating.toString(),
          style: const TextStyle(
            fontSize: 14.0,
          ),
        ),
      ],
    );
  }
}
