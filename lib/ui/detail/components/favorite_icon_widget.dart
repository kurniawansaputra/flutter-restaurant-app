import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../data/models/restaurant.dart';
import '../../../providers/detail/favorite_icon_provider.dart';
import '../../../providers/favorite/local_database_provider.dart';

class FavoriteIcon extends StatefulWidget {
  final Restaurant restaurant;

  const FavoriteIcon({
    super.key,
    required this.restaurant,
  });

  @override
  State<FavoriteIcon> createState() => _FavoriteIconState();
}

class _FavoriteIconState extends State<FavoriteIcon> {
  @override
  void initState() {
    super.initState();

    final localDatabaseProvider = context.read<LocalDatabaseProvider>();
    final favoriteIconProvider = context.read<FavoriteIconProvider>();

    Future.microtask(() async {
      await localDatabaseProvider.loadRestaurantValueById(widget.restaurant.id);
      final value = localDatabaseProvider.restaurant == null
          ? false
          : localDatabaseProvider.restaurant!.id == widget.restaurant.id;
      favoriteIconProvider.isFavorited = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: SvgPicture.asset(
        context.watch<FavoriteIconProvider>().isFavorited
            ? 'assets/icons/ic_favorite_selected.svg'
            : 'assets/icons/ic_favorite_unselected.svg',
        colorFilter: const ColorFilter.mode(
          Colors.red,
          BlendMode.srcIn,
        ),
        width: 19.0,
        height: 19.0,
      ),
      onPressed: () async {
        final localDatabaseProvider = context.read<LocalDatabaseProvider>();
        final favoriteIconProvider = context.read<FavoriteIconProvider>();
        final isFavorited = favoriteIconProvider.isFavorited;

        if (isFavorited) {
          await localDatabaseProvider
              .removeRestaurantValueById(widget.restaurant.id);
        } else {
          await localDatabaseProvider.saveRestaurantValue(widget.restaurant);
        }
        favoriteIconProvider.isFavorited = !isFavorited;

        localDatabaseProvider.loadAllRestaurantValue();
      },
    );
  }
}
