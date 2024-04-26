import 'package:flutter/material.dart';
import '../components/nav_rail.dart';

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
        title: const Text('Logistic Optimize Algorithm Dive'), // 앱바 타이틀
      ),
      body: MyNav()
    );
  }
}
class MyNav extends StatelessWidget {
  const MyNav({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        alignment: Alignment.centerLeft,
        child: SidebarComponent(
          onDestinationSelected: (index) {
            switch (index) {
                  case 0:
                    Navigator.pushNamed(context, '/delivery-list');
                    break;
                  case 1:
                    Navigator.pushNamed(context, '/set-truck-specifications');
                    break;
                  case 2:
                    Navigator.pushNamed(context, '/box-simulation');
                    break;
                  case 3:
                    Navigator.pushNamed(context, '/delivery-simulation');
                    break;
                }
            // Handle selection logic
            },
            selectedIndex: 0, // Provide the selected index
        ),
      ),
    );
  }
}