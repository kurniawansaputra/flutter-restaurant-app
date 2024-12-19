import 'package:flutter/material.dart';

class Search extends StatelessWidget {
  final FocusNode? focusNode;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;

  const Search({
    super.key,
    this.focusNode,
    this.controller,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: focusNode,
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        filled: true,
        fillColor:
            Theme.of(context).colorScheme.secondaryFixedDim.withOpacity(0.4),
        hintText: 'Search restaurant..',
        hintStyle: const TextStyle(
          color: Colors.grey,
          fontSize: 14.0,
        ),
        prefixIcon: const Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
          borderSide: BorderSide.none,
        ),
      ),
      style: const TextStyle(
        fontSize: 14.0,
      ),
    );
  }
}
