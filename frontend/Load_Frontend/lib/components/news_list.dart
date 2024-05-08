import 'package:flutter/material.dart';
import 'package:load_frontend/components/piechart.dart';
import 'package:load_frontend/constaints.dart';
import 'package:load_frontend/model.dart';
import 'package:load_frontend/widgets/news_item.dart';

final news = <News>[
  News(
    '택배개수 : 37개',
    '봉명동 447-6',
    'assets/images/1.png',
    '30%',
  ),
  News(
    '택배개수 : 22개',
    '덕명동 27-6',
    'assets/images/nav1.png',
    '25%',
  ),
  News(
    '택배개수 : 17개',
    '도안동 22',
    'assets/images/nav2.png',
    '8%',
  ),
  News(
    '택배개수 : 3개',
    '봉명동 22-5',
    'assets/images/nav3.png',
    '12%',
  ),
  News(
    '택배개수 : 7개',
    '갈마동 390-22',
    'assets/images/nav4.png',
    '26%',
  ),
  News(
    '5 minutes ago',
    'Lorem ipsum dolor sit amet, consectetur',
    'assets/images/shop.jpeg',
    'Lorem ipsum dolor sit amet, consectetur Lorem ipsum dolor sit amet, consectetur Lorem ipsum dolor sit amet, consectetur',
  ),
  News(
    '5 minutes ago',
    'Lorem ipsum dolor sit amet, consectetur',
    'assets/images/shop.jpeg',
    'Lorem ipsum dolor sit amet, consectetur Lorem ipsum dolor sit amet, consectetur Lorem ipsum dolor sit amet, consectetur',
  ),
  News(
    '5 minutes ago',
    'Lorem ipsum dolor sit amet, consectetur',
    'assets/images/shop.jpeg',
    'Lorem ipsum dolor sit amet, consectetur Lorem ipsum dolor sit amet, consectetur Lorem ipsum dolor sit amet, consectetur',
  ),
  News(
    '5 minutes ago',
    'Lorem ipsum dolor sit amet, consectetur',
    'assets/images/shop.jpeg',
    'Lorem ipsum dolor sit amet, consectetur Lorem ipsum dolor sit amet, consectetur Lorem ipsum dolor sit amet, consectetur',
  ),
];

class NewsList extends StatelessWidget {
  final bool showDesktop;
  const NewsList([this.showDesktop = false]);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: primaryLight.withAlpha(100),
      padding: EdgeInsets.symmetric(horizontal: componentPadding),
      child: Column(
        children: [
          Container(
            height: topBarHeight,
            child: Row(
              children: [
                this.showDesktop
                    ? SizedBox.shrink()
                    : IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                Expanded(
                    child: Center(
                  child: Text(
                    '배송 구역별 배송현황 관리',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ))
              ],
            ),
          ),
          Chart(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: news.map((e) => NewsItem(e)).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
