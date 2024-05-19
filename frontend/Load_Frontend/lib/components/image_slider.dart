import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../constaints.dart';

class ImageSlider extends StatelessWidget {
  final List<String> imageUrls;

  ImageSlider({required this.imageUrls});

  @override
  Widget build(BuildContext context) {

    //child: Image.network(imageUrl, width: MediaQuery.of(context).size.width * 0.4),
    return CarouselSlider(
      options: CarouselOptions(
        height: MediaQuery.of(context).size.height * 0.75,
        autoPlay: true,
        enlargeCenterPage: false, // 이미지가 작아지지 않도록 설정
        aspectRatio: 16 / 9,
        autoPlayInterval: Duration(seconds: 3),
        autoPlayAnimationDuration: Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        pauseAutoPlayOnTouch: true,
        viewportFraction: 1,
      ),
      items: imageUrls.map((imageUrl) {
        bool isNetwork = imageUrl.startsWith('http');

        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 0.0),
              decoration: BoxDecoration(
                color: primary,
              ),
              child: isNetwork ?
              Image.network(imageUrl, fit: BoxFit.cover) :
              Image.asset(imageUrl, fit: BoxFit.cover)
            );
          },
        );
      }).toList(),
    );
  }
}
