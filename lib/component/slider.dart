import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

final List<String> imgList = [
  'assets/sliderimages/im1.jpg',
  'assets/sliderimages/im2.jpg',
  'assets/sliderimages/im3.jpg',
  'assets/sliderimages/im4.jpg',
  'assets/sliderimages/im1.jpg',
  'assets/sliderimages/im2.jpg'
];

class ImageSliderDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: CarouselSlider(
        options: CarouselOptions(
          autoPlay: true,
        ),
        items: imgList
            .map((item) => Container(
                  child: Center(
                      child: Image.asset(item,
                          fit: BoxFit.cover, width: 1000)),
                ))
            .toList(),
      ),
    );
  }
}
