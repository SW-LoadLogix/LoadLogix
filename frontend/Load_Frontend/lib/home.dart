import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('홈 페이지'), // 앱바 타이틀
      ),
      body: Center(
        child: Text('홈 설명 페이지'), // 본문에 표시될 텍스트
      ),
    );
  }
}