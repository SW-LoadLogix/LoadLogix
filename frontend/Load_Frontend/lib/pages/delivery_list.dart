import 'package:flutter/material.dart';
import 'package:load_frontend/components/nav_rail.dart';

class DeliveryListPage extends StatelessWidget {
  const DeliveryListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Row(
        children: [
          Flexible(
            child: MyNav(),
          ),
          Flexible(
              child: Center(
                child: Text('적재 전 배송리스트'),
              ))
        ],
       ),
    );
  }
}
/** 기존 코드
class DeliveryListPage extends StatelessWidget {
  const DeliveryListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('적재 전 배송리스트'), // 앱바 타이틀
      ),
      body: Center(
        child: Text('적재 전 배송리스트'), // 본문에 표시될 텍스트
      ),
    );
  }
}
**/