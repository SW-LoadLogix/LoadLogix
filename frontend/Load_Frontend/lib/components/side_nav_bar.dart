import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:sidebarx/sidebarx.dart';

class CustomNavigationBar extends StatefulWidget {
  const CustomNavigationBar({super.key});

  // final _controller = SidebarXController(selectedIndex: 0, extended: true);
  // final _key = GlobalKey<ScaffoldState>();

  @override
  _CustomNavigationBarState createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // 네비게이션 상태에 따른 화면 전환 등 추가 작업 수행 가능
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.account_box),
          label: '배송 리스트',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.fire_truck),
          label: '트럭 규격 입력',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.front_loader),
          label: '적재 최적화 시뮬레이션',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.map),
          label: '배송 구역 확인',
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.blue,
      onTap: _onItemTapped,
    );
  }
}
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'load service sidebar',
//       // debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primaryColor: primaryColor,
//         canvasColor: canvasColor,
//         scaffoldBackgroundColor: scaffoldBackgroundColor,
//         textTheme: const TextTheme(
//           headlineSmall: TextStyle(
//             color: Colors.white,
//             fontSize: 46,
//             fontWeight: FontWeight.w800,
//           ),
//         ),
//       ),
//       home: Builder(
//         builder: (context) {
//           final isSmallScreen = MediaQuery.of(context).size.width < 600;
//           return Scaffold(
//             key: _key,
//             appBar: isSmallScreen
//                 ? AppBar(
//               backgroundColor: canvasColor,
//               title: Text(_getTitleByIndex(_controller.selectedIndex)),
//               leading: IconButton(
//                 onPressed: () {
//                   // if (!Platform.isAndroid && !Platform.isIOS) {
//                   //   _controller.setExtended(true);
//                   // }
//                   _key.currentState?.openDrawer();
//                 },
//                 icon: const Icon(Icons.menu),
//               ),
//             )
//                 : null,
//             drawer: ExampleSidebarX(controller: _controller),
//             body: Row(
//               children: [
//                 if (!isSmallScreen) ExampleSidebarX(controller: _controller),
//                 // Expanded(
//                 //   child: Center(
//                 //     child: _ScreensExample(
//                 //       controller: _controller,
//                 //     ),
//                 //   ),
//                 // ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
//
class ExampleSidebarX extends StatelessWidget {
  const ExampleSidebarX({
    Key? key,
    required SidebarXController controller,
  })  : _controller = controller,
        super(key: key);

  final SidebarXController _controller;

  @override
  Widget build(BuildContext context) {
    return SidebarX(
      controller: _controller,
      theme: SidebarXTheme(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: canvasColor,
          borderRadius: BorderRadius.circular(20),
        ),
        hoverColor: temporaryMenuColor,
        textStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
        selectedTextStyle: const TextStyle(color: Colors.white),
        hoverTextStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
        itemTextPadding: const EdgeInsets.only(left: 30),
        selectedItemTextPadding: const EdgeInsets.only(left: 30),
        itemDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: canvasColor),
        ),
        selectedItemDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: actionColor.withOpacity(0.37),
          ),
          gradient: const LinearGradient(
            colors: [accentCanvasColor, canvasColor],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.28),
              blurRadius: 30,
            )
          ],
        ),
        iconTheme: IconThemeData(
          color: Colors.white.withOpacity(0.7),
          size: 20,
        ),
        selectedIconTheme: const IconThemeData(
          color: Colors.white,
          size: 20,
        ),
      ),
      extendedTheme: const SidebarXTheme(
        width: 200,
        decoration: BoxDecoration(
          color: canvasColor,
        ),
      ),
      footerDivider: divider,
      headerBuilder: (context, extended) {
        return SizedBox(
          height: 100,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Image.asset('assets/images/logo.png'),
          ),
        );
      },
      items: [
        SidebarXItem(
          icon: Icons.account_box,
          label: '배송리스트',
          onTap: () {
            debugPrint('Home');
          },
        ),
        const SidebarXItem(
          icon: Icons.fire_truck,
          label: '트럭 규격 입력',
        ),
        const SidebarXItem(
          icon: Icons.front_loader,
          label: '적재 최적화 시뮬레이션',
        ),
        const SidebarXItem(
          icon: Icons.map,
          label: '배송 구역 확인',
        ),
        // SidebarXItem(
        //   icon: Icons.map,
        //   label: '배송 구역 확인',
        //   selectable: false,
        //   onTap: () => _showDisabledAlert(context),
        // ),
        // const SidebarXItem(
        //   iconWidget: FlutterLogo(size: 20),
        //   label: 'Flutter',
        // ),
      ],
    );
  }

  void _showDisabledAlert(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Item disabled for selecting',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
    );
  }
}

class _ScreensExample extends StatelessWidget {
  const _ScreensExample({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final SidebarXController controller;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        final pageTitle = _getTitleByIndex(controller.selectedIndex);
        switch (controller.selectedIndex) {
          case 0:
            return ListView.builder(
              padding: const EdgeInsets.only(top: 10),
              itemBuilder: (context, index) => Container(
                height: 100,
                width: double.infinity,
                margin: const EdgeInsets.only(bottom: 10, right: 10, left: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Theme.of(context).canvasColor,
                  boxShadow: const [BoxShadow()],
                ),
              ),
            );
          default:
            return Text(
              pageTitle,
              style: theme.textTheme.headlineSmall,
            );
        }
      },
    );
  }
}

String _getTitleByIndex(int index) {
  switch (index) {
    case 0:
      return 'Home';
    case 1:
      return 'Search';
    case 2:
      return 'People';
    case 3:
      return 'Favorites';
    case 4:
      return 'Custom iconWidget';
    case 5:
      return 'Profile';
    case 6:
      return 'Settings';
    default:
      return 'Not found page';
  }
}

const primaryColor = Colors.red;
const canvasColor = Color(0xFF3AB9FF);//Color(0xFF3ab9ff);//Color(0xFF2E2E48); # 네비게이션바 바디 색
const scaffoldBackgroundColor = Color(0xffffffff);//Color(0xFF464667); # 뷰포트 전체 바탕색
const temporaryMenuColor = Color(0x2dceedff);
const accentCanvasColor = Color(0x2dceedff);//Color(0xFF3ab9ff);//Color(0xFF3E3E61); # 선택되버린 후 메뉴바 고정 색
const white = Color(0x2dceedff);
final actionColor = Color(0x2dceedff);//Color(0xFF3ab9ff);//const Color(0xFF5F5FA7).withOpacity(0.6); # 선택된 메뉴바 테두리 색
final divider = Divider(color: white.withOpacity(0.3), height: 1); //하단의 선 스타일

/*
const primaryColor = Color(0xFF75ddcc);
const canvasColor = Color(0xFF256d7c);//Color(0xFF3ab9ff);//Color(0xFF2E2E48);
const scaffoldBackgroundColor = Color(0x7E75ddcc);//Color(0xFF464667);
const accentCanvasColor = Color(0xFF359d8c);//Color(0xFF3ab9ff);//Color(0xFF3E3E61);
const white = Colors.white;
final actionColor = Color(0xbb75ddcc);//Color(0xFF3ab9ff);//const Color(0xFF5F5FA7).withOpacity(0.6);
final divider = Divider(color: white.withOpacity(0.3), height: 1);
*/
/*
const primaryColor = Color(0xFF685BFF);
const canvasColor = Color(0xFF2E2E48);
const scaffoldBackgroundColor = Color(0xFF464667);
const accentCanvasColor = Color(0xFF3E3E61);
const white = Colors.white;
final actionColor = const Color(0xFF5F5FA7).withOpacity(0.6);
final divider = Divider(color: white.withOpacity(0.3), height: 1);
*/