import 'package:flutter/material.dart';

class CustomNavigationDrawer extends StatelessWidget {
  final Function(int) onDestinationSelected;
  final int selectedIndex;

  const CustomNavigationDrawer({
    required this.onDestinationSelected,
    required this.selectedIndex,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFF3AB9FF),
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Color(0xFF3AB9FF),
              image: DecorationImage(
                image: AssetImage('assets/images/logo3.png'),
              )
            ),
            child: Text(
              'LOAD',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          Material(
          color: Colors.transparent, // Material 위젯의 색을 투명하게 설정
          child: InkWell(
            onTap: () {
              onDestinationSelected(0);
              Navigator.pop(context);
            },
            splashColor: Colors.blue,
            child: ListTile(
              selected: selectedIndex == 0,
              contentPadding: EdgeInsets.zero,
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 40, // 이미지의 높이와 ListTile의 높이 조절
                    child: Image.asset(
                      'assets/images/nav1.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(height: 8), // 이미지와 제목 사이 간격 조절
                  const Text(
                    '배송 리스트',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    ), // 제목 폰트 크기 조절
                  ),
                ],
              ),
            ),
          ),
          ),
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                onDestinationSelected(1);
                Navigator.pop(context);
              },
              splashColor: Colors.blue,
              child: ListTile(
                selected: selectedIndex == 1,
                contentPadding: EdgeInsets.zero,
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 40, // 이미지의 높이와 ListTile의 높이 조절
                      child: Image.asset(
                        'assets/images/nav2.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(height: 8), // 이미지와 제목 사이 간격 조절
                    const Text(
                      '트럭 규격 입력',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                      ), // 제목 폰트 크기 조절
                    ),
                  ],
                ),
              ),
            ),
          ),
          Material(
            color: Colors.transparent, // Material 위젯의 색을 투명하게 설정
            child: InkWell(
              onTap: () {
                onDestinationSelected(2);
                Navigator.pop(context);
              },
              splashColor: Colors.blue,
              child: ListTile(
                selected: selectedIndex == 2,

                contentPadding: EdgeInsets.zero,
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 40, // 이미지의 높이와 ListTile의 높이 조절
                      child: Image.asset(
                        'assets/images/nav3.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(height: 8), // 이미지와 제목 사이 간격 조절
                    const Text(
                      '적재 최적화 시뮬레이션',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                      ), // 제목 폰트 크기 조절
                    ),
                  ],
                ),
              ),
            ),
          ),
          Material(
            color: Colors.transparent, // Material 위젯의 색을 투명하게 설정
            child: InkWell(
              onTap: () {
                onDestinationSelected(3);
                Navigator.pop(context);
              },
              splashColor: Colors.blue,
              child: ListTile(
                selected: selectedIndex == 3,
                contentPadding: EdgeInsets.zero,
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 40, // 이미지의 높이와 ListTile의 높이 조절
                      child: Image.asset(
                        'assets/images/nav4.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(height: 8), // 이미지와 제목 사이 간격 조절
                    const Text(
                      '배송 구역 확인',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                      ), // 제목 폰트 크기 조절
                    ),
                  ],
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }
}
