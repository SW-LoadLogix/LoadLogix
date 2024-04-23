import 'package:flutter/material.dart';

class SetTruckSpecificationPage extends StatelessWidget {
  const SetTruckSpecificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('트럭 사이즈 설정'), // 앱바 타이틀
      ),
      body: Center(
        child: Text('트럭 사이즈 설정'), // 본문에 표시될 텍스트
      ),
    );
  }
}