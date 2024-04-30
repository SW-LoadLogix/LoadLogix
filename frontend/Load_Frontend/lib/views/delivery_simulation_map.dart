import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

import '../components/nav_rail.dart';

@RoutePage()
class DeliverySimulationMapPage extends StatelessWidget {
  const DeliverySimulationMapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('맵 페이지'), // 앱바 타이틀
      ),
      body: Row(
          children: [
            MyNav(),
            Expanded(
                child: Center(
                  child: Text('맵 경로 페이지'), // 본문에 표시될 텍스트
                )
            )
          ]
      ),
    );
  }
}

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
