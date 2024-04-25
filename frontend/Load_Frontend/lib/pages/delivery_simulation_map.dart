import 'package:flutter/material.dart';

class DeliverySimulationMapPage extends StatelessWidget {
  const DeliverySimulationMapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('배송 시뮬레이션 (맵)'), // 앱바 타이틀
      ),
      body: Center(
        child: Text('배송 시뮬레이션 (맵)'), // 본문에 표시될 텍스트
      ),
    );
  }
}