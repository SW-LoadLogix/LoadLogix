import 'package:flutter/material.dart';

import '../components/side_nav_bar.dart';

class dummyData{
  String ?type;
  int ?a;
  int ?b;
  int ?c;
  dummyData({this.type, this.a, this.b, this.c});
}

class HomePage extends StatelessWidget {
  const HomePage({required Key key}) : super(key: key);

  void testDummyData(){
    late List<dummyData> dummyExample = [
      dummyData(type: "A", a: 1, b: 2, c: 3),
      dummyData(type: "B", a: 4, b: 5, c: 6),
      dummyData(type: "C", a: 7, b: 8, c: 9),
    ];

    for(int i = 0; i < dummyExample.length; i++){
      print("type: ${dummyExample[i].type}, a: ${dummyExample[i].a}, b: ${dummyExample[i].b}, c: ${dummyExample[i].c}");
    }
  }


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
      ),
      bottomNavigationBar: CustomNavigationBar(),// 네비게이션 바 import
    );
  }
}