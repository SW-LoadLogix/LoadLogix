
import 'package:flutter/material.dart';

class DeliveryList extends StatelessWidget {
  const DeliveryList({super.key});

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