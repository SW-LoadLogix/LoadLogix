import 'package:flutter/material.dart';
import 'goodsdummy.dart';
// import 'package:flutter_naver_map/flutter_naver_map.dart';

class DeliverySimulationMapPage extends StatelessWidget {
  const DeliverySimulationMapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('배송 시뮬레이션 (맵)'), // 앱바 타이틀
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 70, left: 80, right: 80),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Placeholder(),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.only(left: 50, right: 10),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 10, // 행 사이의 수직 공간
                    mainAxisSpacing: 10, // 행 사이의 수평공간
                    crossAxisCount: 3, // 한 줄 카드 개수
                    childAspectRatio: 2 / 1.5, // 카드 가로 세로 비율
                  ),
                  itemCount: goodsList.length,
                  itemBuilder: (context, index) {
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Column(
                          children: [
                            Container(
                              color: Colors.blue,
                              width: double.infinity,
                              padding: EdgeInsets.all(8),
                              child: Text(
                                '${goodsList[index].goodsId}',
                                style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Expanded(
                              child: Container(
                                color: Colors.white,
                                width: double.infinity,
                                padding: EdgeInsets.all(8),
                                child: Text(
                                  '${goodsList[index].area}',
                                  style: TextStyle(fontSize: 20),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(home: DeliverySimulationMapPage()));
}


/**
import 'package:flutter/material.dart';

import '../components/nav_rail.dart';


class DeliverySimulationMapPage extends StatelessWidget {
  const DeliverySimulationMapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('맵 페이지'), // 앱바 타이틀
      ),
      body: Center(
        child: Text('맵 경로 페이지'), // 본문에 표시될 텍스트
      ),
    );
  }
}
**/
/**
class DeliverySimulationMapPage extends StatelessWidget {
  const DeliverySimulationMapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Flexible(
            child: MyNav(),
          ),
          Flexible(
              child: Center(
                child: Text('map'),
              ))
        ],
      ),
    );
  }
}

**/