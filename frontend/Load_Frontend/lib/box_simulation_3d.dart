import 'package:flutter/material.dart';

class BoxSimulation3dPage extends StatelessWidget {
  const BoxSimulation3dPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('박스 3d 시뮬레이션 페이지'), // 앱바 타이틀
      ),
      body: Center(
        child: Text('박스 3d 시뮬레이션 페이지'), // 본문에 표시될 텍스트
      ),
    );
  }
}