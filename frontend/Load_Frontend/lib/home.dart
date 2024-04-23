import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({required Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('홈 페이지'), // 앱바 타이틀
      ),
      body:
      Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              children: <Widget>[
                ListTile(title: Text("여긴 그냥 소개하는 페이지에요.")),
                ListTile(title: Text("나중에 바뀔겁니다.")),
                ElevatedButton(
                  onPressed: (){
                    Navigator.pushNamed(context, '/sign-in-up');
                  },
                  child: const Text('로그인 페이지로 이동'),
                ),
                ElevatedButton(
                  onPressed: (){
                    Navigator.pushNamed(context, '/delivery-list');
                  },
                  child: const Text('적재 전 배송리스트 페이지로 이동'),
                ),
                ElevatedButton(
                  onPressed: (){
                    Navigator.pushNamed(context, '/set-truck-specifications');
                  },
                  child: const Text('트럭 사이즈 설정 페이지로 이동'),
                ),
                ElevatedButton(
                  onPressed: (){
                    Navigator.pushNamed(context, '/box-simulation');
                  },
                  child: const Text('박스 시뮬레이션 페이지로 이동'),
                ),
                ElevatedButton(
                  onPressed: (){
                    Navigator.pushNamed(context, '/delivery-simulation');
                  },
                  child: const Text('배송 시뮬레이션 (맵) 페이지로 이동'),
                ),
              ],
            ),
          ),
        ],
      )
    );
  }
}