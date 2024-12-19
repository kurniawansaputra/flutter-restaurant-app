import 'package:flutter/material.dart';

class MenuChip extends StatelessWidget {
  final List<String> items;

  const MenuChip({
    super.key,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 4.0,
            runSpacing: -8.0,
            children: items
                .map(
                  (item) => Chip(
                    label: Text(
                      item,
                      style: const TextStyle(
                        fontSize: 12.0,
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
