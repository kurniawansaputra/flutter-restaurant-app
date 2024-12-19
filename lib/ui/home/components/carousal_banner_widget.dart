import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CarousalBanner extends StatefulWidget {
  const CarousalBanner({super.key});

  @override
  State<CarousalBanner> createState() => _CarousalBannerState();
}

class _CarousalBannerState extends State<CarousalBanner> {
  int _current = 0;
  final _controller = CarouselSliderController();

  final List<String> imgList = [
    'assets/images/banner_1.png',
    'assets/images/banner_2.png',
    'assets/images/banner_3.png',
  ];

  List<Widget> get imageSliders => imgList
      .map((item) => ClipRRect(
            borderRadius: BorderRadius.circular(16.0),
            child: Image.asset(
              item,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ))
      .toList();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          items: imageSliders,
          carouselController: _controller,
          options: CarouselOptions(
            autoPlay: true,
            enlargeCenterPage: true,
            aspectRatio: 290 / 120,
            viewportFraction: 0.9,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: imgList.asMap().entries.map(
            (entry) {
              return GestureDetector(
                onTap: () => _controller.animateToPage(entry.key),
                child: Container(
                  width: 7.0,
                  height: 7.0,
                  margin: const EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 4.0,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                    color: Theme.of(context)
                        .colorScheme
                        .primary
                        .withOpacity(_current == entry.key ? 0.9 : 0.4),
                  ),
                ),
              );
            },
          ).toList(),
        ),
      ],
    );
  }
}
