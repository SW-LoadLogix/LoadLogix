import 'package:flutter/material.dart';

import '../components/nav_rail.dart';

class BoxSimulation3dPage extends StatelessWidget {
  const BoxSimulation3dPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('3D 시뮬레이션 페이지'), // 앱바 타이틀
      ),
      body: Center(
        child: Text('3D 시뮬레이션 '), // 본문에 표시될 텍스트
      ),
    );
  }
}