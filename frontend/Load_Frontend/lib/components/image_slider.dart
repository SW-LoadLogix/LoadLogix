// import 'package:flutter/material.dart';
// import 'package:carousel_slider/carousel_slider.dart';
//
// import '../constaints.dart';
//
// class ImageSliderLegends {
//   final String imageUrl;
//   final String title;
//   final String description;
//   ImageSliderLegends({required this.imageUrl, required this.title, required this.description});
// }
//
// class ImageSlider extends StatelessWidget {
//   final List<ImageSliderLegends> legends;
//
//   ImageSlider({required this.legends});
//
//   @override
//   Widget build(BuildContext context) {
//     return CarouselSlider(
//       options: CarouselOptions(
//         height: MediaQuery.of(context).size.height * 0.75,
//         autoPlay: true,
//         enlargeCenterPage: false,
//         aspectRatio: 16 / 9,
//         autoPlayInterval: Duration(seconds: 3),
//         autoPlayAnimationDuration: Duration(milliseconds: 800),
//         autoPlayCurve: Curves.fastOutSlowIn,
//         pauseAutoPlayOnTouch: true,
//         viewportFraction: 1,
//       ),
//       items: legends.map((legend) {
//         bool isNetwork = legend.imageUrl.startsWith('http');
//
//         return Builder(
//           builder: (BuildContext context) {
//             return Container(
//               width: MediaQuery.of(context).size.width,
//               margin: EdgeInsets.symmetric(horizontal: 0.0),
//               decoration: BoxDecoration(
//                 color: primary,
//               ),
//               child: Stack(
//                 children: [
//                   isNetwork
//                       ? Image.network(legend.imageUrl, fit: BoxFit.cover, width: double.infinity, height: double.infinity)
//                       : Image.asset(legend.imageUrl, fit: BoxFit.cover, width: double.infinity, height: double.infinity),
//                   Positioned(
//                     top: MediaQuery.of(context).size.height * 0.5,
//                     left: MediaQuery.of(context).size.width * 0.5,
//                     bottom: 20,
//                     right: 20,
//                     child: Container(
//                       color: Colors.black54,
//                       padding: const EdgeInsets.all(10.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             legend.title,
//                             style: TextStyle(
//                               fontSize: 24,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.white,
//                             ),
//                           ),
//                           SizedBox(height: 10),
//                           Text(
//                             legend.description,
//                             style: TextStyle(
//                               fontSize: 16,
//                               color: Colors.white,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           },
//         );
//       }).toList(),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../constaints.dart';

class ImageSliderLegends {
  final String imageUrl;
  final String title;
  final String description;
  ImageSliderLegends({required this.imageUrl, required this.title, required this.description});
}

class ImageSlider extends StatefulWidget {
  final List<ImageSliderLegends> legends;

  ImageSlider({required this.legends});

  @override
  _ImageSliderState createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Precache images
    for (var legend in widget.legends) {
      if (legend.imageUrl.startsWith('http')) {
        precacheImage(NetworkImage(legend.imageUrl), context);
      } else {
        precacheImage(AssetImage(legend.imageUrl), context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: MediaQuery.of(context).size.height * 0.75,
        autoPlay: true,
        enlargeCenterPage: false,
        aspectRatio: 16 / 9,
        autoPlayInterval: Duration(seconds: 3),
        autoPlayAnimationDuration: Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        pauseAutoPlayOnTouch: true,
        viewportFraction: 1,
      ),
      items: widget.legends.map((legend) {
        bool isNetwork = legend.imageUrl.startsWith('http');

        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 0.0),
              decoration: BoxDecoration(
                color: primary,
              ),
              child: Stack(
                children: [
                  isNetwork
                      ? Image.network(legend.imageUrl, fit: BoxFit.cover, width: double.infinity, height: double.infinity)
                      : Image.asset(legend.imageUrl, fit: BoxFit.cover, width: double.infinity, height: double.infinity),
                  Positioned(
                    top: MediaQuery.of(context).size.height * 0.5,
                    left: MediaQuery.of(context).size.width * 0.5,
                    bottom: 20,
                    right: 20,
                    child: Container(
                      color: Colors.black54,
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            child: Text(
                              legend.title,
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                          SizedBox(height: 10),
                          Flexible(
                            child: Text(
                              legend.description,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                              overflow: TextOverflow.ellipsis,
                              //maxLines: 3,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      }).toList(),
    );
  }
}